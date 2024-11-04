import requests
from flask import render_template, flash, redirect, url_for, jsonify, current_app, request, abort
from app.blueprints.main import bp
from app.extensions import db
from app.models.url import Url

@bp.route('/', methods=['GET'])
@bp.route('/view/index', methods=['GET'])
def index():
    api_url = url_for('main.get_urls', _external=True)
    response = requests.get(api_url)
    urls_list = response.json()
    return render_template('index.html', urls=urls_list), 200

