import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.1

Column {
    Layout.margins: 5
    spacing: 5

    Row {
        spacing: 5

        ResourceLabel { text : "Pay" }
        ResourceSquare { rtype: "coin"; isPay: true }
    }
    Row {
        spacing: 5

        ResourceLabel { text: "Trade" }
        ResourceSquare { rtype: "four" }
        ResourceSquare { rtype: "four" }

        Divider { hoz: false; size: 2 }

        ResourceSquare { rtype: "heart" }
        ResourceSquare { id: heart2; rtype: "heart"; active: false }
    }
    Row {
        spacing: 5

        ResourceLabel { text: "Armory" }
        ResourceSquare {
            id: armory
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
        x: (ApplicationWindow.window.width - dialog.width) / 2
        y: (ApplicationWindow.window.height - dialog.height) / 2
        parent: ApplicationWindow.overlay
        title: "Trade Action"

        ColumnLayout {
            Row {
                spacing: 5
                ResourceLabel { size: 1.4; text : "Pay" }
                ResourceSquare { hsize: 1.4; wsize: 1.4; rtype: "coin"; isPay: true }
            }

            Divider { size: 2 }

            Row {
                spacing: 5
                ResourceSpinner { id: s_oil; type: "oil"; max: 2; onChanged: dialog.fixValues(spinner) }
                ResourceSpinner { id: s_iron; type: "iron"; max: 2; onChanged: dialog.fixValues(spinner) }

            }
            Row {
                spacing: 5
                ResourceSpinner { id: s_wood; type: "wood"; max: 2; onChanged: dialog.fixValues(spinner) }
                ResourceSpinner { id: s_food; type: "food"; max: 2; onChanged: dialog.fixValues(spinner) }
            }

            Divider {}

            Row {
                spacing: 5
                ResourceSpinner { id: s_heart; type: "heart"; max: heart2.active + 1; onChanged: dialog.fixValues(spinner) }
            }

            Divider { visible: armory.active; size: 2 }

            Row {
                visible: armory.active
                spacing: 5
                ResourceSpinner { id: s_bolster; type: "bolster"; max: armory.active; onChanged: dialog.fixValues(spinner) }
            }
        }

        onAccepted: {
            if (ApplicationWindow.window.getResource("coin") > 0) {
                ApplicationWindow.window.updateResource("coin", -1)
                var r = [s_oil, s_iron, s_wood, s_food, s_heart, s_bolster]
                for (var i = 0; i < r.length; i++) {
                    ApplicationWindow.window.updateResource(r[i].type, r[i].getValue())
                }
            }
        }

        function fixValues(spinner) {
            if (spinner.type === "bolster") {
                return
            } else if (ApplicationWindow.window.getResource("coin") < 1) {
                spinner.setValue(0)
                return
            } else if (spinner.type === "heart") {
                s_oil.setValue(0)
                s_iron.setValue(0)
                s_wood.setValue(0)
                s_food.setValue(0)
                return
            }

            // spinner is resource type at this point
            s_heart.setValue(0)
            var l = [s_oil, s_iron, s_wood, s_food]
            if (spinner.getValue() === 2) {
                for (var i = 0; i < l.length; i++) {
                    if (l[i] !== spinner) {
                        l[i].setValue(0)
                    }
                }
            } else if (spinner.getValue() === 1) {
                var found = null
                for (i = 0; i < l.length; i++) {
                    if (l[i] === spinner) {
                        continue
                    } else if (l[i].getValue() === 2) {
                        l[i].setValue(1)
                        return
                    } else if (l[i].getValue() === 1) {
                        if (found) {
                            l[i].setValue(0)
                        } else {
                            found = l[i]
                        }
                    }
                }
            }
        }

        function init() {
            s_bolster.setValue(armory.active)
        }
    }

    function doAction() {
        dialog.init()
        dialog.open()
    }
}
