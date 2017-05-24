import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.1

Column {
    property var cardObj

    Layout.margins: 5
    spacing: 5

    Row {
        spacing: 5

        ResourceLabel { text: "Move/\nGain" }
        ResourceSquare { rtype: "move" }
        ResourceSquare { rtype: "move" }
        ResourceSquare { id: move3; rtype: "move"; active: false }

        Divider { hoz: false; size: 2 }

        ResourceSquare { rtype: "coin" }
        ResourceSquare { id: coin2; rtype: "coin"; active: false }
    }
    Row {
        spacing: 5

        ResourceLabel { text: "Mine" }
        ResourceSquare {
            hsize: 1.4
            wsize: 2.5
            rtype: "mine"
            active: false
        }
    }

    Dialog {
        id: dialog
        modal: true
        closePolicy: "NoAutoClose"
        standardButtons: Dialog.Cancel|Dialog.Ok
        x: (ApplicationWindow.window.width - dialog.width) / 2
        y: (ApplicationWindow.window.height - dialog.height) / 2
        parent: ApplicationWindow.overlay
        title: "Move Action"

        ColumnLayout {
            Row {
                spacing: 5
                ResourceSpinner { id: s_move; type: "move"; max: move3.active + 2; onChanged: dialog.fixValues(spinner) }
            }
            Divider { }
            Row {
                spacing: 5
                ResourceSpinner { id: s_coin; type: "coin"; max: coin2.active + 1; onChanged: dialog.fixValues(spinner) }
            }
        }

        onAccepted: {
            ApplicationWindow.window.updateResource("coin", s_coin.getValue())
            cardObj.doBottomAction()
        }

        function fixValues(spinner) {
            if (spinner.type === "move") {
                s_coin.setValue(0)
                return
            } else if (spinner.type === "coin") {
                s_move.setValue(0)
                return
            }
        }
    }

    function doAction(card) {
        cardObj = card
        dialog.open()
    }
}
