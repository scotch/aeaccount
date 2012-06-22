% extends "base.html"

% block title
  Account Overview

% block content
  section
    header
      h1 | Account

  noscript
    .alert.alert-error
      Your browser does not support Javascript or Javascript has been disabled.
    p | As your browser does not support Javascript or has Javascript disabled, we are not able to display the requested page.

  #content
    .init-loading |

  .row
    .span2
      ul.nav.nav-list
        li.active > a href="/account/" | Overview
        li > a href="/account/connected" | Connected Accounts
        li > a href="/account/password" | Password
        li > a href="/account/profile" | Profile


    .span7
      % include "partials/messages.html"
      section
        h3 | Profile
        h4 | {{ user.displayName }}
        p > a href="/account/profile" | Edit Profile

      section
        h3 | Email address
        % if user.email != None
          p
            {{ user.email }}
            span > a href="/account/profile" | Edit
        % else
          .alert.alert-error
            You do <strong>not</strong> have an email address on file.
            Without a verified email address you may lose access to your account.
            Please add your email address now.
          h4 > a.btn.btn-success href="/account/profile" | Add Email
