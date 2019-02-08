import QtQuick 2.0
import QtQuick.Controls 2.2
import 'components'

ApplicationWindow {
    width: 300
    height: 480
    title: 'Wish List'

    CreateDialog { id: create_dialog }

    DeleteDialog { id: delete_dialog }

    ListView {
        id: list_view
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: add_button.top
        anchors.margins: 5
        model: WishesModel
        spacing: 5
        delegate: record_item

        RecordItem {
            id: record_item
        }
    }

    Button {
        id: add_button
        text: 'Add'
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.margins: 5

        onClicked: {
            create_dialog.open()
        }
    }
}
