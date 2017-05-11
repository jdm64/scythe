import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.1

Column {
    Layout.margins: 5
    spacing: 5

    Row {
        spacing: 5

        ResourceLabel { text : "Pay" }
        ResourceSquare { rtype: "coin" }
    }
    Row {
        spacing: 5

        ResourceLabel { text: "Trade" }
        ResourceSquare { rtype: "four" }
        ResourceSquare { rtype: "four" }

        Rectangle {
            width: 2
            height: parent.height
            color: "black"
        }

        ResourceSquare { rtype: "heart" }
        ResourceSquare { rtype: "heart"; active: false }
    }
    Row {
        spacing: 5

        ResourceLabel { text: "Armory" }
        ResourceSquare {
            hsize: 1.8
            wsize: 1.8
            rtype: "bolster"
            active: false
        }
    }

    Dialog {
        id: dialog
        modal: true
        closePolicy: "NoAutoClose"
        standardButtons: Dialog.Cancel|Dialog.Ok
        title: "Trade Action"

        ColumnLayout {
            Row {
                spacing: 5
                ResourceLabel { size: 1.4; text : "Pay" }
                ResourceSquare { hsize: 1.4; wsize: 1.4; rtype: "coin" }
            }
            Rectangle {
                height: 2
                color: "black"
                Layout.fillWidth: true
            }
            Row {
                spacing: 5
                ResourceSpinner { type: "food"; }
                ResourceSpinner { type: "wood" }
            }
            Row {
                spacing: 5
                ResourceSpinner { type: "oil" }
                ResourceSpinner { type: "iron" }
            }
            Rectangle {
                height: 1
                color: "black"
                Layout.fillWidth: true
            }
            Row {
                spacing: 5
                ResourceSpinner { type: "heart" }
            }
        }
    }
}
