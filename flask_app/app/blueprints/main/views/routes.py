from flask import render_template, flash, redirect, url_for, jsonify
from app.blueprints.main import bp
from app.blueprints.main.views.forms import ConvertForm, ConsultForm
from app.blueprints.main.services import svc_get_urls, svc_add_url, svc_get_url
from app.extensions import db
from app.models.url import Url

@bp.route('/view/index', methods=['GET'])
def index():
    response_data, status_code = svc_get_urls()

    if status_code != 200:
        return render_template('errors/500.html'), 500
    
    return render_template('index.html', urls=response_data), 200


@bp.route('/view/convert', methods=['GET', 'POST'])
def convert():
    form = ConvertForm()
    if form.validate_on_submit():
        data = {
            'name': form.name.data, 
            'original': form.original.data
        }
        response_data, status_code = svc_add_url(data)

        if status_code != 200:
            error_message = response_data['message']
            flash('Error saving {}. {} Try again'.format(form.name.data, error_message))
            return render_template('convert.html', form=form), 400
        
        flash('URL {} saved.'.format(form.name.data))
        return redirect(url_for('main.index'))

    return render_template('convert.html', form=form), 200


@bp.route('/view/consult', methods=['GET', 'POST'])
def consult():
    form = ConsultForm()
    if form.validate_on_submit():
        response_data, status_code = svc_get_url(form.name.data)
        
        if status_code != 200:
            error_message = response_data['message']
            flash('Error obtaining {}. {} Try again'.format(form.name.data, error_message))
            return render_template('consult.html', form=form), 400
        
        original = response_data
        flash('Original URL: {}'.format(original)) # not rendering it as clickable HTML ref for simplicity and to avoid XSS
        return redirect(url_for('main.consult'))

    return render_template('consult.html', form=form), 200
