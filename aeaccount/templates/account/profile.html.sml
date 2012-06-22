% extends "account/account_base.html"

% block title
  Profile

% block account_header
  Profile

% block account_content
  % include "partials/messages.html"
  form.form-horizontal method="POST" action=""
    fieldset
      .control-group
        label.control-label
          Current password
        .controls
          = form.current
          br /
          br /
          a href="/account/recovery" > small | Forgot your password?
      .control-group
        label.control-label
          New password
        .controls
          = form.current
      .control-group
        label.control-label
          Verify password
        .controls
          = form.verify
      .form-actions
        button.btn.primary type="submit" value="Submit" | Save Changes

