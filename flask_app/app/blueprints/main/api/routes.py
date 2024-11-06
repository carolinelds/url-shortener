from flask import render_template
from app.blueprints.main import bp
from app.blueprints.main.services import svc_get_urls, svc_add_url, svc_delete_url, svc_get_url

# controllers and routes in the same place for simplicity

@bp.route('/shorten', methods=['GET'])
def get_urls():
    return svc_get_urls()


@bp.route('/shorten', methods=['POST'])
def add_url():
    data = request.get_json()
    return svc_add_url(data)
    

@bp.route('/shorten/<string:name>', methods=['DELETE'])
def delete_url(name):
    return svc_delete_url(name)


@bp.route('/convert/<string:name>', methods=['GET'])
def get_url(name):    
    return svc_get_url(name)


@bp.route('/healthcheck', methods=['GET'])
def healthcheck():
    response_data, response_status = svc_get_urls()
    return 'OK', 200

