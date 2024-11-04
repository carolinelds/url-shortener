import requests
import sqlalchemy as sa
from flask import render_template, flash, redirect, url_for, jsonify, current_app, request, abort
from app.blueprints.main import bp
from app.blueprints.main.api.errors import bad_request, internal_server_error
from app.extensions import db
from app.models.url import Url

@bp.route('/shorten', methods=['GET'])
def get_urls():
    try:
        urls = Url.query.all()
        urls_list = [url.to_dict() for url in urls]
        return urls_list, 200
    
    except Exception as e:
        return internal_server_error(str(e))

