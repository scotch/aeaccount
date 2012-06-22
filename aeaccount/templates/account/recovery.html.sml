% extends "base.html"

% block title
  Forgot your password

% block content
  section
    header
      h2 | Forgot your password?

      p | To reset your password, enter the email address you used when creating your {{ application_title }} account.

      % include "partials/messages.html"
      form method="POST" action="/account/recovery"
        fieldset.control-group
          label.control-label for="email" | Email Address
          .controls > input.input-large type="text" name="email" /
        fieldset.control-group
          button.btn.primary type="submit" value="Submit" | Submit

    p > small | If you don't have a {{ application_title }} Account you can <a href="/auth/login"> create one now</a>