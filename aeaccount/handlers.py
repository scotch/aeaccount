from google.appengine.api import mail
from google.appengine.api.taskqueue import taskqueue
import webapp2
from aeaccount import forms
from aecore.decorators import user_required
from aecore.handlers import Jinja2Handler
from aecore.models import Config
from aecore.models import User
from aecore.models import UserProfile
from aecore.models import UserToken


class AccountHandler(Jinja2Handler):
    @user_required
    def overview(self):
        self.render_template('account/index.html')

    @user_required
    def connected(self):
        all_profiles = self.request.user.get_profiles()
        profiles = [p for p in all_profiles if
                    p and 'ProviderUserProfile' in p.class_]
        self.render_template('account/connected.html', {'profiles': profiles})


class EmailHandler(Jinja2Handler):
    def get(self):
        self.render_template('account/email.html')

    def post(self):
        email = self.request.POST.get('email')
        if not email:
            self.request.add_message(
                'Please enter a valid email address', 'error')
            return self.get()
        existing_account = UserProfile.get_key('password', email).get()
        if not existing_account:
            self.request.add_message(
                'The email address you provided was not found. '
                'Please try again.', 'error')
            return self.get()
        return self.sent(email)

    def sent(self, email):
        self.render_template('account/sent.html', {'email': email})

# Mailers
class EmailTaskHandler(Jinja2Handler):

    def password_recovery(self):
        recipient_id = self.request.POST.get('recipient_id')
        if recipient_id is None: return
        recipient = User.get_by_id(int(recipient_id))
        token = UserToken.create(recipient.key.id(), 'password_reset').key.id()

        # uses the application_title set in the config
        subject = "{}: Password Assistance".format(
            Config.get('application').title)
        template = '/account/emails/password_reset.html'

        reset_url = self.uri_for(
            'account-recovery-verify', token=token, _full=True)

        # Create the email
        email = mail.EmailMessage()
        email.sender = Config.get('application').default_from_email
        email.subject = subject
        email.to = '{} <{}>'.format(recipient.name, recipient.email)
        email.body = self.render_template(template, {
            'recipient': recipient,
            'reset_url': reset_url,
            })
        email.send()


# Account Recovery
class RecoveryHandler(Jinja2Handler):
    def get(self):
        self.render_template('account/recovery.html')

    def post(self):
        email = self.request.POST.get('email')
        if not email or "@" not in email or "." not in email:
            self.request.add_message(
                'Please enter a valid email address', 'error')
            return self.get()
        existing_account = UserProfile.get_key('password', email).get()
        if not existing_account:
            self.request.add_message(
                'The email address you provided was not found. '
                'Please try again.', 'error')
            return self.get()
        user = User.get_by_auth_id(existing_account.key.id())
        taskqueue.add(url='/account/tasks/password-recovery-email', params={
            'recipient_id': user.key.id(),
            })
        return self.sent(email)

    def sent(self, email):
        self.render_template('account/sent.html', {'email': email})


class PasswordHandler(Jinja2Handler):

    @user_required
    def get(self, **kwargs):
        has_password = self.request.user.has_profile('password')
        self.render_template('account/password_change.html', {
            'has_password': has_password,
            'form': self.form,
            'user': self.request.user,
            })

    @user_required
    def post(self, **kwargs):
        if self.form.validate():
            from aeauth.strategies.password import PasswordUserProfile
            # existing password
            if self.request.user.has_profile('password'):
                # get profile for password
                p = PasswordUserProfile.get_by_id(
                    self.request.user.get_auth_id("password"))
                # make sure the passwords match.
                if not p.check_password(self.form.current.data):
                    self.add_message(
                        'Your current password did not match our records', 'error')
                    return self.get(**kwargs)
                    # change password
                p.set_password(self.form.password.data)
                p.put()
                self.add_message('Password changed successfully', 'success')
                return self.redirect_to("account-overview")
            # new password
            else:
                email = self.form.email.data
                if not email:
                    self.add_message('You must provide an email address', 'error')
                    return self.get(**kwargs)
                else:
                    auth_id = PasswordUserProfile.generate_auth_id('password', email)
                    # Check for an existing UserProfile
                    obj = PasswordUserProfile.get_by_id(auth_id)
                    if obj is not None:
                        # TODO: if a UserProfile exists then we need to
                        # consolidate accounts
                        self.add_message(
                            'The email address that you provided is already '
                            'associated with an account.', 'error')
                        return self.get(**kwargs)
                    else:
                        # TODO create the UserProfile with a person_raw and
                        # person attributes.
                        obj = PasswordUserProfile(id=auth_id)
                        obj.set_password(self.form.password.data)
                        obj.put()
                        self.request.user.add_auth_id(auth_id)
                        obj.put()
                        self.add_message(
                            'Password added successfully', 'success')
                        return self.redirect_to("account-overview")

        self.add_message('Password change failed.', 'error')
        return self.get(**kwargs)

    @webapp2.cached_property
    def form(self):
        return forms.PasswordChangeForm(self.request.POST)


class PasswordResetCompleteHandler(Jinja2Handler):

    def get(self, token):
        # Verify token
        token = UserToken.get_by_id(token)
        if token is None:
            self.add_message(
                'The token could not be found, please resubmit your email.',
                'error')
            self.redirect_to('account-recovery')
        return self.render_template('accounts/password_reset_complete.html', {
            'form': self.form,
            })

    def post(self, token):
        if self.form.validate():
            token = UserToken.get_by_id(token)
            # test current password
            user = User.get_by_id(token.user_id)
            if token is not None and user is not None:
                # updated the Users password UserProfile with the new password
                p = user.get_auth_id("password").get()
                p.set_password(self.form.password.data)
                p.put()
                # Delete token
                token.key.delete()
                # Login User
                self.add_message('Password updated successfully. '
                                 'Login with your new password', 'success')
                return self.redirect_to('auth-login')

        self.add_message('Please correct the form errors.', 'error')
        return self.get(token)

    @webapp2.cached_property
    def form(self):
        return forms.PasswordChangeForm(self.request.POST)