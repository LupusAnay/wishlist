import QtQuick 2.0
import QtQuick.Controls 2.2
import '.'

Dialog {
    id: create_dialog
    width: 200
    height: 300

    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    title: 'Create record'
    standardButtons: Dialog.Ok | Dialog.Cancel

    TextField {
        id: name_input
        anchors.margins: 5
        anchors.right: parent.right
        anchors.left: parent.left
        selectByMouse: true
        placeholderText: 'Name'
    }
    TextField {
        id: note_input
        anchors.top: name_input.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.margins: 5
        selectByMouse: true
        placeholderText: 'Note'
    }
    TextField {
        id: link_input
        anchors.top: note_input.bottom
        anchors.margins: 5
        anchors.right: parent.right
        anchors.left: parent.left
        selectByMouse: true
        placeholderText: 'Link'
    }
    TextField {
        id: price_input
        anchors.top: link_input.bottom
        anchors.margins: 5
        anchors.right: parent.right
        anchors.left: parent.left
        selectByMouse: true
        placeholderText: 'Price'

        validator: IntValidator {
            bottom: 0
        }
    }

    onAccepted: {
        WishesModel.add(
            name_input.text,
            note_input.text,
            link_input.text,
            price_input.text
        )
    }
}
