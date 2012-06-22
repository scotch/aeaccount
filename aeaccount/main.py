from aerest.api import Api
from aeaccount.resources import UserProfileResource
import os
import webapp2
from webapp2_extras.routes import PathPrefixRoute
from webapp2_extras.routes import RedirectRoute

api_v1 = Api()
api_v1.register(UserProfileResource)

routes = [
    PathPrefixRoute(r'/account/api/v1', api_v1.get_routes()),
    RedirectRoute(r'/account', redirect_to='/account/'),
    webapp2.Route(r'/account/', handler='aeaccount.handlers.AccountHandler:overview', name='account-overview'),
    webapp2.Route(r'/account/email', handler='aeaccount.handlers.EmailHandler', name='account-email-list'),
    webapp2.Route(r'/account/connected', handler='aeaccount.handlers.AccountHandler:connected', name='account-recovery'),
    webapp2.Route(r'/account/overview', handler='aeaccount.handlers.AccountHandler:overview', name='account-settings'),
    webapp2.Route(r'/account/password', handler='aeaccount.handlers.PasswordHandler', name='account-password'),
    webapp2.Route(r'/account/profile', handler='aeaccount.handlers.ProfileHandler', name='account-profile'),

    # Account Recovery
    webapp2.Route(r'/account/recovery', handler='aeaccount.handlers.RecoveryHandler', name='account-recovery'),
    webapp2.Route(r'/account/recovery/<token>', handler='aeaccount.handlers.RecoveryCompleteHandler', name='account-recovery-verify'),

    # Tasks
    webapp2.Route(r'/account/tasks/password-recovery-email', handler='aeaccount.handlers.EmailTaskHandler:password_recovery', name='account-task-password-recovery'),
    ]

template_path = os.path.join(os.path.dirname(__file__), 'templates')

config = {
    'webapp2_extras.jinja2': {
        'template_path': ['templates', template_path],
        },
    }
application = webapp2.WSGIApplication(routes, config=config)
