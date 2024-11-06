import re
from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, BooleanField, SubmitField, ValidationError
from wtforms.validators import DataRequired

def NameValidator(form, field):
    name_pattern = r'^[a-z0-9]+(-[a-z0-9]+)*$'
    if not bool(re.match(name_pattern, field.data)):
        raise ValidationError('Name must contain only lowercase letters, numbers, and optional internal hyphens.')

class ConvertForm(FlaskForm):
    name = StringField('Name', validators=[DataRequired(), NameValidator])
    original = StringField('Original URL', validators=[DataRequired()])
    submit = SubmitField('Shorten it')

class ConsultForm(FlaskForm):
    name = StringField('Name', validators=[DataRequired(), NameValidator])
    submit = SubmitField('Get original URL')
