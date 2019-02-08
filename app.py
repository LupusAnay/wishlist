import configparser
import sys

from PyQt5.QtCore import QUrl
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtWidgets import QApplication
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

from record import Record
from record_model import RecordModel

config = configparser.ConfigParser()
config.read('config.cfg')
db_conf = config['DEFAULT']

db_url = f'mysql+pymysql://' \
    f'{db_conf["db_user"]}' \
    f':{db_conf["db_pass"]}' \
    f'@{db_conf["db_host"]}' \
    f':{db_conf["db_port"]}' \
    f'/{db_conf["db_name"]}'

db_engine = create_engine(db_url, echo=True)
Record.metadata.create_all(db_engine)

if __name__ == '__main__':
    Session = sessionmaker()
    Session.configure(bind=db_engine)
    session = Session()
    model = RecordModel(session)
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()
    engine.rootContext().setContextProperty('WishesModel', model)
    engine.load(QUrl('ui/MainWindow.qml'))
    window = engine.rootObjects()[0]
    window.show()

    sys.exit(app.exec())
