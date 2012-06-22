
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
    {{/each}}

.well.span2
  h4 | Why Connect Accounts?
  ul
    li | Provides you with alternative login paths.
    li | Allows you to pre-populate forms.
    li | Allows us to provide a tailored experience based on your interests and connections.