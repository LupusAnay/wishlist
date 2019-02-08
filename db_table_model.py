import logging
from typing import List, Any, Type

from PyQt5.QtCore import QAbstractListModel, QModelIndex, Qt
from sqlalchemy.orm import Session

from abstract_item import AbstractItem


class DBTableModel(QAbstractListModel):
    def __init__(self,
                 item_type: Type[AbstractItem],
                 session: Session) -> None:
        super().__init__()
        self._item_type: Type[AbstractItem] = item_type
        self._session: Session = session
        self._items: List[AbstractItem] = []
        self._role_names: dict = {}

    def rowCount(self, parent: QModelIndex = None, *args, **kwargs) -> int:
        return len(self._items)

    def canFetchMore(self, parent: QModelIndex) -> bool:
        items_in_db = self._session.query(self._item_type).count()
        items_in_model = self.rowCount()
        can_fetch_more = items_in_db > items_in_model
        logging.info(f'Can Fetch More called; result: {can_fetch_more}')
        return can_fetch_more

    def fetchMore(self, parent: QModelIndex) -> None:

        items = self._session.query(self._item_type).all()
        insert_from = self.rowCount()
        insert_count = self.rowCount() + len(items)

        if insert_count < insert_from:
            insert_count = insert_from

        print(insert_count, insert_from)

        if insert_count == 0:
            logging.error(f'Row not found: selected item is None')
            return None

        self.beginInsertRows(self.index(self.rowCount(), 0),
                             insert_from,
                             insert_count - 1)

        for item in items:
            self._items.append(item)

        self._generate_role_names()

        self.endInsertRows()

    def data(self, index: QModelIndex, role: int = None) -> Any:
        row = index.row()
        if row < 0 or row >= len(self._items):
            logging.error('Row not found: row index is invalid')
            return None

        item = self._items[row]
        return item.get_value(self._role_names[role].decode('utf-8'))

    def roleNames(self) -> dict:
        return self._role_names

    def _generate_role_names(self) -> None:
        names = self._item_type.keys()
        index = Qt.UserRole + 1
        if self.rowCount() > 0:
            for name in names:
                self._role_names[index] = bytes(name, 'utf-8')
                index += 1
