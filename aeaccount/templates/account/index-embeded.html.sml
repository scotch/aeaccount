% extends "base.html"

% block title
  Account

% block head
  script src="http://cdnjs.cloudflare.com/ajax/libs/require.js/1.0.5/require.min.js" |
  script
    | require.config({
    |   baseUrl: "/account/static/scripts/",
    |   paths: {
    |    // uncomment this line to serve the optimized
    |    // main-build.js source file.
    |    //"main": "/account/static/scripts/main-built"
    |    "main": "/account/static/scripts/main"
    |  }
    |  });
    |  require(["plugins/order!https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js", "plugins/order!main"]);

% block content

  #content
    .init-loading |

  % raw
    <!-- account - layout -->
    script type="text/x-handlebars" data-template-name="account-layout"
      section
        header
          h1#section-header
            Account
        .row
          .span2
            ul#account-nav.nav.nav-list
              li.overview.active
                a href="#/"
                  i.icon-th-list |
                  Overview
              li.connected
                a href="#/connected"
                  i.icon-retweet |
                  Connected Accounts
              li.password
                a href="#/password"
                  i.icon-key |
                  Password
              li.profile
                a href="#/profile"
                  i.icon-user |
                  Profile

          section#section-content
            {{dynamicView}}

    <!-- account/overview -->
    script type="text/x-handlebars" data-template-name="account-overview"
      .span7
        section
          h3 | Profile
          h4 | {{ App.userProfile }}
          p > a href="/account/profile" | Edit Profile

        section
          h3 | Email address
          {{#if App.user.hasEmail}}
            p
              {{App.user.email}}
              span > a href="/account/profile" | Edit
          {{else}}
            .alert.alert-error
              i.icon-exclamation-sign.icon-large |
              You do <strong>not</strong> have an email address on file.
              Without a verified email address you may lose access to your account.
              Please add your email address now.
            h4 > a.btn.btn-success href="#/profile" | Add Email
          {{/if}}

      .well.span2
        h4 | Connected Accounts
        ul
          li.icon-ok | Provides you with alternative login paths.
          li.icon-ok | Allows you to pre-populate forms.
          li.icon-ok | Allows us to provide a tailored experience based on your interests and connections.

    <!-- account/connected -->
    script type="text/x-handlebars" data-template-name="account-connected"
      .span7
        .accordion#providers-accordion
          {{#each App.userProfiles}}
            .accordion-group
              .accordion-heading
                h3
                  a.accordion-toggle data-toggle="collapse" data-parent="#providers-accordion" data-target="#{{unbound provider}}" href="#/connected/{{unbound provider}}"|
                    {{favicon url}}
                    span
                      {{titlecase provider }}

              div id="{{provider}}"
                .accordion-inner
                  h3
                    img width=24 height=24 src="{{unbound image}}" /
                    {{name}}
                    {{gender}}
                    {{url}}

          {{/each}}

      .well.span2
        h4 | Why Connect Accounts?
        ul
          li | Provides you with alternative login paths.
          li | Allows you to pre-populate forms.
          li | Allows us to provide a tailored experience based on your interests and connections.

    <!-- account/profile -->
    script type="text/x-handlebars" data-template-name="account-profile"
      .span7
        .accordion#providers-accordion
          pass

      .well.span2
        h4 | Connected Accounts
        ul
          li | Provides you with alternative login paths.
          li | Allows you to pre-populate forms.
          li | Allows us to provide a tailored experience based on your interests and connections.

    <!-- account/password -->
    script type="text/x-handlebars" data-template-name="account-password"
      .span7
        {{#unless has_password}}
          .well
            You have not created a password yet. Creating a password ensures that you will always have access to your account.
        {{/unless}}
        form.form-horizontal method="POST" action=""
          fieldset
            {{#if has_password}}
              .control-group
                label.control-label
                  Current password
                .controls
                  br /
                  br /
                  a href="/account/recovery" > small | Forgot your password?
            {{else}}
              .control-group
                label.control-label
                  Email Address
                .controls
                  p.help-block | Setting a password requires a valid email address.
            {{/if}}
            .control-group
              label.control-label
                New password
              .controls
                pass
            .form-actions
              button.btn.btn-primary type="submit" value="Submit" | Save Changes

      .well.span2
        h4 | Settings a password
