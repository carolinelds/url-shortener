from flask import Blueprint

bp = Blueprint('main', __name__)

from app.blueprints.main import services
from app.blueprints.main.api import errors, routes
from app.blueprints.main.views import forms, routes
