from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, BooleanField, SubmitField
from wtforms.validators import DataRequired

class ConvertForm(FlaskForm):
    identifier = StringField('Name', validators=[DataRequired()])
    original_url = StringField('Original URL', validators=[DataRequired()])
    submit = SubmitField('Shorten it')

class ConsultForm(FlaskForm):
    identifier = StringField('Name', validators=[DataRequired()])
    submit = SubmitField('Get original URL')
