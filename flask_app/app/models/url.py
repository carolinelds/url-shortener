from typing import Optional
import sqlalchemy as sa
import sqlalchemy.orm as so
from app.extensions import db

class Url(db.Model):
    __tablename__ = "url"
    id: so.Mapped[int] = so.mapped_column(primary_key=True)
    name: so.Mapped[str] = so.mapped_column(sa.String(64), index=True, unique=True)
    long: so.Mapped[str] = so.mapped_column(sa.String(256), index=True, unique=False)
    short: so.Mapped[str] = so.mapped_column(sa.String(64), index=True, unique=True)

    def __repr__(self):
        return '<Url {}>'.format(self.name)
    
    def to_dict(self):
        return {
            "id": self.id,
            "name": self.name,
            "long": self.long,
            "short": self.short
        }
