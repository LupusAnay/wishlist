import logging
from typing import Any, List

from sqlalchemy import inspect
from sqlalchemy.ext.declarative import as_declarative, declared_attr


@as_declarative()
class AbstractItem(object):
    @declared_attr
    def __tablename__(self):
        return self.__name__.lower()

    def as_dict(self) -> dict:
        return {c.key: getattr(self, c.key)
                for c in inspect(self).mapper.column_attrs}

    def set_value(self, column_name: str, value: Any):
        if column_name in self.as_dict().keys():
            setattr(self, column_name, value)
        else:
            logging.error(f'Row with name {column_name} not found')
            return None

    def get_value(self, column_name: str) -> Any:
        if column_name in self.as_dict().keys():
            return self.as_dict().get(column_name)
        else:
            logging.error(f'Row with name {column_name} not found')
            return None

    def update(self, **kwargs):
        for key, value in kwargs.items():
            self.set_value(key, value)

    @staticmethod
    def keys() -> List[str]:
        raise NotImplemented
