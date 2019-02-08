from typing import List

from sqlalchemy import Column, Integer, Float, Text
from sqlalchemy import inspect

from abstract_item import AbstractItem


class Record(AbstractItem):
    __tablename__ = 'wishes'
    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(Text)
    note = Column(Text)
    link = Column(Text)
    price = Column(Float)

    def __init__(self, name: str, note: str, link: str, price: float) -> None:
        self.name: str = name
        self.note: str = note
        self.link: str = link
        self.price: float = price

    @staticmethod
    def keys() -> List[str]:
        return [c.key for c in inspect(Record).mapper.column_attrs]
