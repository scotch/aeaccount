% extends "base.html"

% block title
  Email Sent
  
% block content
  section
    header
      h2 | Email sent to {{ email }}

    p | To get back into your account, follow the instructions we've sent to your {{ email }} email address.

    p > small | Didn't receive the password reset email? Check your spam folder for an email from <strong>{{ application.default_from_email }}</strong>. If you still don't see the email <a href="/account/recovery">try again</a>.