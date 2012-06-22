% extends "base.html"

% block title
  Connected Accounts

% block content
  section
    header
      h1 | Connected Accounts
  .row
    .span2
      ul.nav.nav-list
        li > a href="/account/" | Overview
        li.active > a href="/account/connected" | Connected Accounts
        li > a href="/account/password" | Password
        li > a href="/account/profile" | Profile

    section
      .span7
        % include "partials/messages.html"
        .accordion#providers-accordion
          % for p in profiles
            .accordion-group
              .accordion-heading
                h3
                  a.accordion-toggle data-toggle="collapse" data-parent="#providers-accordion" data-target="#{{ p.get_provider() }}" href="#{{ p.get_provider() }}"|
                    img width=16 height=16 src="https://s2.googleusercontent.com/s2/favicons?domain={{ p.get_provider() }}.com" |
                    span
                      = p.get_provider().capitalize()
              div.collapse id="{{ p.get_provider() }}"
                .accordion-inner
                  = p.updated

      .well.span2
        h4 | Connected Accounts
        ul
          li | Provides you with alternative login paths.
          li | Allows you to pre-populate forms.
          li | Allows us to provide a tailored experience based on your interests and connections.
