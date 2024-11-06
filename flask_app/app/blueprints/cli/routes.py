from flask import Blueprint, current_app
from sqlalchemy_utils import database_exists, create_database, drop_database
from app.blueprints.cli import bp

@bp.cli.command('resetdb')
def resetdb_command():
    """Reset database."""
    db_url = current_app.config['SQLALCHEMY_DATABASE_URI']
    if database_exists(db_url):
        drop_database(db_url)
        print('Database deleted.')

@bp.cli.command('createdb')
def resetdb_command():
    """Create database."""
    db_url = current_app.config['SQLALCHEMY_DATABASE_URI']
    if not database_exists(db_url):
        create_database(db_url)
        print('Database created.')
