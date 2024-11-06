import logging
from app import create_app

application = create_app()

if __name__ == "__main__":
    application.run(debug=True)

# from app import db
# import sqlalchemy as sa
# import sqlalchemy.orm as so
# from app.models.url import Url

# @app.shell_context_processor
# def make_shell_context():
#     return {'sa': sa, 'so': so, 'db': db, 'Url': Url}
