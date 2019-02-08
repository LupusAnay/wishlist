import QtQuick 2.0
import QtQuick.Controls 2.2
import '.'

Dialog {
    id: delete_dialog

    property int index

    width: 200

    x: (parent.width - width) / 2
    y: (parent.height - height) / 2

    title: "Deleting"
    Label {
        text: "This action will delete the record.\n Are you sure?"
    }

    standardButtons: Dialog.Ok | Dialog.Cancel

    function remove(index_to_remove) {
        open()
        index = index_to_remove
    }

    onAccepted: {
        WishesModel.remove(index)
    }
}
