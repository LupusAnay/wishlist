from PyQt5.QtCore import pyqtSlot, QModelIndex
from sqlalchemy.orm import Session

from db_table_model import DBTableModel
from record import Record


class RecordModel(DBTableModel):
    def __init__(self, session: Session):
        super().__init__(Record, session)

    @pyqtSlot(int, name='remove')
    def remove(self, index: int):
        item = self._items[index]
        self.beginRemoveRows(QModelIndex(), index, index)
        self._items.remove(item)
        self._session.delete(item)
        self._session.commit()
        self.endRemoveRows()

    @pyqtSlot(str, str, str, float, name='add')
    def add(self, name: str, note: str, link: str, price: float) -> int:
        rows_before_insert = self.rowCount()
        record = Record(name, note, link, price)
        self._session.add(record)
        self._session.commit()

        self.beginInsertRows(QModelIndex(), self.rowCount(), self.rowCount())
        self._items.append(record)
        if rows_before_insert == 0:
            self._generate_role_names()
        self.endInsertRows()

        return record.id

    @pyqtSlot(int, str, str, str, int, name='update')
    def update(self, index: int, name, note, link, price) -> None:
        item = self._items[index]

        item.update(name=name, note=note, link=link, price=price)
        self._session.commit()
        self.dataChanged.emit(self.index(index),
                              self.index(index),
                              self.roleNames())
