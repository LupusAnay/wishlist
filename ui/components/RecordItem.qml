import QtQuick 2.0
import QtQuick.Controls 2.2
import '.'

Component {
    Rectangle {

        id: record_item
        property bool is_active: ListView.isCurrentItem

        width: parent.width
        height: is_active ? 145 : 40
        border.color: 'black'
        border.width: 1

        MouseArea {
            anchors.fill: parent
            onClicked: {
                list_view.currentIndex = index
            }
        }

        Item {
            id: records

            anchors.right: remove_button.left
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            RecordEntry {
                id: name_entry

                anchors.top: parent.top

                role_name: 'Name: '
                role_value: model.name
                ro: !is_active
            }

            RecordEntry {
                id: note_entry

                anchors.top: name_entry.bottom

                role_name: 'Note: '
                role_value: model.note
                visible: is_active
            }

            RecordEntry {
                id: link_entry

                anchors.top: note_entry.bottom

                role_name: 'Link: '
                role_value: model.link
                visible: is_active
            }

            RecordEntry {
                id: price_entry

                anchors.top: link_entry.bottom

                role_name: 'Price: '
                role_value: model.price
                visible: is_active
            }
        }

        Button {
            id: accept_button
            width: 30
            height: 30

            visible: false

            icon.source: "../images/verification-mark.svg"

            anchors.top: remove_button.bottom
            anchors.right: parent.right
            anchors.topMargin: 10
            anchors.margins: 5

            background: Rectangle {
                id: accept_back
                color: "white"
            }
            onHoveredChanged: {
                hovered ? accept_back.color = "lightgray" : accept_back.color = "white"
            }

            onClicked: {
                WishesModel.update(
                    index,
                    name_entry.get_value(),
                    note_entry.get_value(),
                    link_entry.get_value(),
                    parseInt(price_entry.get_value())
                )
                accept_button.visible = false
                decline_button.visible = false
            }
        }

        Button {
            id: decline_button
            width: 30
            height: 30

            visible: false

            icon.source: "../images/decline.svg"

            anchors.top: accept_button.bottom
            anchors.right: parent.right
            anchors.margins: 5

            background: Rectangle {
                id: decline_back
                color: "white"
            }
            onHoveredChanged: {
                hovered ? decline_back.color = "lightgray" :
                          decline_back.color = "white"
            }

            onClicked: {
                accept_button.visible = false
                decline_button.visible = false

                name_entry.reset()
                note_entry.reset()
                link_entry.reset()
                price_entry.reset()
            }
        }


        Button {
            id: remove_button
            width: 30
            height: 30
            icon.source: "../images/clear-button.svg"
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.margins: 5

            background: Rectangle {
                id: remove_back
                color: "white"
            }
            onHoveredChanged: {
                hovered ? remove_back.color = "lightgray" :
                          remove_back.color = "white"
            }
            onClicked: {
                delete_dialog.remove(index);
            }
        }
    }
}
