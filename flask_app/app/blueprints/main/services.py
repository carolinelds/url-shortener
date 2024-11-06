import re
import sqlalchemy as sa
from nanoid import generate
from flask import render_template, flash, redirect, jsonify
from app.blueprints.main import bp
from app.blueprints.main.api.errors import bad_request, internal_server_error, not_found
from app.extensions import db
from app.models.url import Url

# services and repositories in the same file for simplicity

def svc_get_urls():
    try:
        urls = Url.query.all()
    except Exception as e:
        return internal_server_error(str(e))
    
    urls_list = [url.to_dict() for url in urls]
    return urls_list, 200


def svc_add_url(data):
    if 'name' not in data or 'original' not in data:
        return bad_request('Malformed request body.')

    name = data['name']
    name_pattern = r'^[a-z0-9]+(-[a-z0-9]+)*$'

    if not bool(re.match(name_pattern, name)):
        return bad_request('Invalid format for name field.')

    try:
        existing_name = Url.query.filter_by(name=name).first()
    except Exception as e:
        return internal_server_error(str(e))

    if existing_name:
        return bad_request('URL with the same identifier name already exists.')

    original = re.sub(r'^https?://', '', data['original'])
    short = f'short.ly/{generate()}'
    
    url = Url(name=name, original=original, short=short)
    
    try:
        db.session.add(url)
        db.session.commit()
    except Exception as e:
        return internal_server_error(str(e))
    
    return url.to_dict()['short'], 200


def svc_delete_url(name):
    name_pattern = r'^[a-z0-9]+(-[a-z0-9]+)*$'
    # lowercase alphanumeric with optional hiphens, but no trailing hiphens

    if not bool(re.match(name_pattern, name)):
        return bad_request('Invalid name string.')
    
    try:
        url = Url.query.filter_by(name=name).first()
    except Exception as e:
        return internal_server_error(str(e))

    if not url:
        return not_found('URL not found.')

    try:
        db.session.delete(url)
        db.session.commit()
    except Exception as e:
        return internal_server_error(str(e))

    return 'URL deleted with success.', 200


def svc_get_url(name):
    name_pattern = r'^[a-z0-9]+(-[a-z0-9]+)*$'
    # lowercase alphanumeric with optional hiphens, but no trailing hiphens

    if not bool(re.match(name_pattern, name)):
        return bad_request('Invalid name string.')

    try:
        url = Url.query.filter_by(name=name).first()
    except Exception as e:
        return internal_server_error(str(e))
    
    if not url:
        return not_found('URL not found.')
    
    return url.to_dict()['original'], 200
