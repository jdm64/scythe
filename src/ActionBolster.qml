import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.1

Column {
    property var cardObj

    Layout.margins: 5
    spacing: 5

    Row {
        spacing: 5

        ResourceLabel { text : "Pay" }
        ResourceSquare { rtype: "coin"; isPay: true }
    }
    Row {
        spacing: 5

        ResourceLabel {  text: "Bolster" }
        ResourceSquare { rtype: "bolster" }
        ResourceSquare { rtype: "bolster" }
        ResourceSquare { id: bolster3; rtype: "bolster"; active: false }

        Divider { hoz: false; size: 2 }

        ResourceSquare { rtype: "acard" }
        ResourceSquare { id: acard2; rtype: "acard"; active: false }
    }
    Row {
        spacing: 5

        ResourceLabel { text: "Monument" }
        ResourceSquare {
            id: monument
            hsize: 1.6
            wsize: 2.6
            rtype: "heart"
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
        title: "Bolster Action"

        ColumnLayout {
            Row {
                spacing: 5
                ResourceLabel { size: 1.4; text : "Pay" }
                ResourceSquare { hsize: 1.4; wsize: 1.4; rtype: "coin"; isPay: true }
            }

            Divider { size: 2 }

            Row {
                spacing: 5
                ResourceSpinner { id: s_bolster; type: "bolster"; max: bolster3.active + 2; onChanged: dialog.fixValues(spinner) }
            }
            Divider { }
            Row {
                spacing: 5
                ResourceSpinner { id: s_acard; type: "acard"; max: acard2.active + 1; onChanged: dialog.fixValues(spinner) }
            }

            Divider { visible: monument.active; size: 2 }

            Row {
                visible: monument.active
                spacing: 5
                ResourceSpinner { id: s_heart; type: "heart"; max: monument.active; onChanged: dialog.fixValues(spinner) }
            }
        }

        onAccepted: {
            if (ApplicationWindow.window.getResource("coin") > 0) {
                ApplicationWindow.window.updateResource("coin", -1)
                var r = [s_bolster, s_heart]
                for (var i = 0; i < r.length; i++) {
                    ApplicationWindow.window.updateResource(r[i].type, r[i].getValue())
                }
            }
            cardObj.doBottomAction()
        }

        function fixValues(spinner) {
            if (spinner.type === "heart") {
                return
            } else if (ApplicationWindow.window.getResource("coin") < 1) {
                spinner.setValue(0)
                return
            } else if (spinner.type === "bolster") {
                s_acard.setValue(0)
                return
            } else if (spinner.type === "acard") {
                s_bolster.setValue(0)
                return
            }
        }

        function init() {
            s_heart.setValue(monument.active)
        }
    }

    function doAction(card) {
        cardObj = card
        dialog.init()
        dialog.open()
    }
}
