from typing import Optional
import sqlalchemy as sa
import sqlalchemy.orm as so
from app.extensions import db

class Url(db.Model):
    __tablename__ = "url"
    id: so.Mapped[int] = so.mapped_column(primary_key=True)
    name: so.Mapped[str] = so.mapped_column(sa.String(64), index=True, unique=True)
    original: so.Mapped[str] = so.mapped_column(sa.String(512), index=True, unique=False)
    short: so.Mapped[str] = so.mapped_column(sa.String(64), index=True, unique=True)

    def __repr__(self):
        return '<Url {}>'.format(self.name)
    
    def to_dict(self):
        return {
            "id": self.id,
            "name": self.name,
            "original": self.original,
            "short": self.short
        }
