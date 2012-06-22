% extends "base.html"

% block title
  Change Password

% block content
  section
    header
      h1 | Change Password
  .row
    .span2
      ul.nav.nav-list
        li > a href="/account/" | Overview
        li > a href="/account/connected" | Connected Accounts
        li.active > a href="/account/password" | Password
        li > a href="/account/profile" | Profile

    section.span7
      % if not has_password
        .well
          You have not created a password yet. Creating a password ensures that you will always have access to your account.
      % include "partials/messages.html"
      form.form-horizontal method="POST" action=""
        fieldset
          % if has_password
            .control-group
              label.control-label
                Current password
              .controls
                = form.current
                br /
                br /
                a href="/account/recovery" > small | Forgot your password?
          % else
            .control-group
              label.control-label
                Email Address
              .controls
                = form.email
                p.help-block | Setting a password requires a valid email address.
          .control-group
            label.control-label
              New password
            .controls
              = form.password
          .form-actions
            button.btn.btn-primary type="submit" value="Submit" | Save Changes

