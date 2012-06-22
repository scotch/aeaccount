.span7
  section
    h3 | Profile
    h4 | "{{ App.userProfile }}"
    p > a href="/profile" | Edit Profile

  section
    h3 | Email address
    input type="checkbox" ng-model="checked" /
    div ng-show="checked"
      p
        {{partialTitle}}
        {{App.user.email}}
        span > a href="/account/profile" | Edit
    div ng-hide="checked"
      .alert.alert-error
        i.icon-exclamation-sign.icon-large |
        You do <strong>not</strong> have an email address on file.
        Without a verified email address you may lose access to your account.
        Please add your email address now.
      h4 > a.btn.btn-success href="#/profile" | Add Email

.well.span2
  h4 | Connected Accounts
  ul
    li.icon-ok | Provides you with alternative login paths.
    li.icon-ok | Allows you to pre-populate forms.
    li.icon-ok | Allows us to provide a tailored experience based on your interests and connections.