import logging
from flask import Flask
from config import Config
from app.extensions import db, migrate
from app.blueprints.errors import bp as errors_bp
from app.blueprints.main import bp as main_bp
from app.blueprints.cli import bp as cli_bp

def create_app(config_class=Config):
    app = Flask(__name__)
    app.config.from_object(Config)

    db.init_app(app)
    migrate.init_app(app, db)

    app.register_blueprint(errors_bp)
    app.register_blueprint(main_bp)
    app.register_blueprint(cli_bp)

    app.logger.setLevel(logging.DEBUG)
    app.logger.info('Application startup')

    return app
