from wtforms import Form
from wtforms import fields
from wtforms import validators

class PasswordRestForm(Form):
    email = fields.TextField('email')

class PasswordChangeForm(Form):
    email = fields.TextField('Email Address')
    current = fields.PasswordField('Current Password' )
    password = fields.PasswordField('New Password', [validators.Required()])