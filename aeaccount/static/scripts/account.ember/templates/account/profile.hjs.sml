.span7
  form.form-horizontal
    fieldset
      legend | {{content.id}}
      img width=24 height=24 src="{{unbound image}}" /
      .control-group
        label.control-label for="name" | Name
        .controls
          {{view Em.TextField valueBinding="profile.familyName"}}
      .control-group
        label.control-label for="name" | Gender
        .controls
          {{view Em.Select
            contentBinding="App.genderChoices"
            selectionBinding="profile.gender"
            optionLabelPath="content"
            optionValuePath="content"
            prompt="Pick a person:"}}
      .form-actions
        button.btn.btn-primary {{action "save"}} | Save
        button.btn {{action "cancel"}} | Cancel
      {{#each profile.accounts}}
        .control-group
          label.control-label for="name" | Name
          .controls
            {{view Em.TextField valueBinding="name"}}
        .control-group
          label.control-label for="name" | URL
          .controls
            {{view Em.TextField valueBinding="url"}}
      {{/each}}
.well.span2
  h4 | Connected Accounts
  ul
    li | Provides you with alternative login paths.
    li | Allows you to pre-populate forms.
    li | Allows us to provide a tailored experience based on your interests and connections.