import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0


Rectangle {
    id: record_entry

    property bool ro

    height: 30

    property string role_name: "None"
    property string role_value: "None"

    anchors.margins: 5
    anchors.left: parent.left
    anchors.right: parent.right

    function reset() {
        value_input.text = role_value
    }

    function get_value() {
        return value_input.text
    }


    Label {
        id: role_label

        width: 50
        height: parent.height

        anchors.left: parent.left
        text: role_name
        verticalAlignment: Text.AlignVCenter
    }

    TextField {
        id: value_input


        validator: IntValidator {
            bottom: 0
        }

        selectByMouse: true
        selectionColor: "black"

        readOnly: ro

        onPressed: {
            event.accepted = !ro
        }

        background: Rectangle {
            color: "transparent"
            border.color: value_input.focus ? "black" : "transparent"
            border.width: 2

            Rectangle {
                width: parent.width
                height: 1
                anchors.bottom: parent.bottom
                color: ro ? "transparent" : "black"
            }
        }

        width: parent.width - role_label.width
        height: parent.height

        anchors.right: parent.right
        text: role_value

        onTextEdited: {
            accept_button.visible = true
            decline_button.visible = true
        }
    }
}
