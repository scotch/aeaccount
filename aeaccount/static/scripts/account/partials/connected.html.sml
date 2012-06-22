
.span7
  .accordion#providers-accordion
    .accordion-group ng-repeat="profile in userProfiles"
      .accordion-heading
        h3
          a.accordion-toggle data-toggle="collapse" data-parent="#providers-accordion" data-target="#{{profiles.provider}}" href="#/connected/{{profile.provider}}"|
            {{profile.url}}
            span
              {{profile.provider}}

      div id="{{profile.provider}}"
        .accordion-inner
          h3
            img width=24 height=24 ng-src="{{profile.image}}" /
            {{profile.name}}

.well.span2
  h4 | Why Connect Accounts?
  ul
    li | Provides you with alternative login paths.
    li | Allows you to pre-populate forms.
    li | Allows us to provide a tailored experience based on your interests and connections.