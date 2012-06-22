.span7
  .well
    You have not created a password yet. Creating a password ensures that you will always have access to your account.
  form.form-horizontal method="POST" action=""
    fieldset
      .control-group
        label.control-label
          Current password
        .controls
          br /
          br /
          a href="/account/recovery" > small | Forgot your password?
      .control-group
        label.control-label
          Email Address
        .controls
          p.help-block | Setting a password requires a valid email address.
      .control-group
        label.control-label
          New password
        .controls
          pass
      .form-actions
        button.btn.btn-primary type="submit" value="Submit" | Save Changes


.well.span2
  h4 | Settings a password
