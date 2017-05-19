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
                ResourceSpinner { id: s_oil; type: "oil"; onChanged: dialog.fixValues(spinner) }
                ResourceSpinner { id: s_iron; type: "iron"; onChanged: dialog.fixValues(spinner) }

            }
            Row {
                spacing: 5
                ResourceSpinner { id: s_wood; type: "wood"; onChanged: dialog.fixValues(spinner) }
                ResourceSpinner { id: s_food; type: "food"; onChanged: dialog.fixValues(spinner) }
            }

            Divider {}

            Row {
                spacing: 5
                ResourceSpinner { id: s_heart; type: "heart"; onChanged: dialog.fixValues(spinner) }
            }

            Divider { visible: armory.active; size: 2 }

            Row {
                visible: armory.active
                spacing: 5
                ResourceSpinner { id: s_bolster; type: "bolster"; onChanged: dialog.fixValues(spinner) }
            }
        }

        function fixValues(spinner) {
            if (parent.parent.getResource("coin") < 1) {
                spinner.setValue(0)
                return
            } else if (spinner.getValue() > 2) {
                spinner.setValue(2)
                return
            } else if (spinner.type === "heart") {
                s_food.setValue(0)
                s_wood.setValue(0)
                s_oil.setValue(0)
                s_iron.setValue(0)
                if (!heart2.active && spinner.getValue() > 1) {
                    spinner.setValue(1)
                }
                return
            } else if (spinner.type === "bolster") {
                if (spinner.getValue() > 1) {
                    spinner.setValue(1)
                }
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
            if (armory.active) {
                s_bolster.setValue(1)
            }
        }
    }

    function doAction() {
        dialog.init()
        dialog.open()
    }
}
