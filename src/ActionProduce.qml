import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.1

Column {
    Layout.margins: 5
    spacing: 5

    Row {

        ResourceLabel { text : "Pay  " }
        ResourceSquare {
            id: firstWorker
            hsize: 1.4
            isPay: true
            active: false
        }
        ResourceSquare {
            id: bolster
            hsize: 1.4
            rtype: "bolster"
            isPay: true
            active: false
        }
        ResourceSquare {
            hsize: 1.4
            isPay: true
            active: false
        }
        ResourceSquare {
            id: heart
            hsize: 1.4
            rtype: "heart"
            isPay: true
            active: false
        }
        ResourceSquare {
            hsize: 1.4
            isPay: true
            active: false
        }
        ResourceSquare {
            id: coin
            hsize: 1.4
            isPay: true
            rtype: "coin"
            active: false
        }
    }
    Row {
        spacing: 5

        ResourceLabel { text: "Produce" }
        ResourceSquare { rtype: "prod" }
        ResourceSquare { rtype: "prod" }
        ResourceSquare { rtype: "prod"; active: false }
    }
    Row {
        spacing: 5

        ResourceLabel { text: "Mill" }
        ResourceSquare {
            id: mill
            hsize: 1.5
            wsize: 1.5
            rtype: "prod"
            active: false
        }
    }

    Dialog {
        id: dialog
        modal: true
        closePolicy: "NoAutoClose"
        standardButtons: Dialog.Cancel|Dialog.Ok
        title: "Produce Action"

        ColumnLayout {
            Row {
                spacing: 5
                ResourceLabel { size: 1.4; text : "Pay" }
                ResourceSquare { visible: bolster.active; hsize: 1.4; wsize: 1.4; rtype: "bolster"; isPay: true }
                ResourceSquare { visible:   heart.active; hsize: 1.4; wsize: 1.4; rtype:   "heart"; isPay: true }
                ResourceSquare { visible:    coin.active; hsize: 1.4; wsize: 1.4; rtype:    "coin"; isPay: true }
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
            Row {
                spacing: 5
                ResourceSpinner { id: s_worker; type: "worker"; onChanged: dialog.fixValues(spinner) }
            }
        }

        onAccepted: {
            var p = [bolster, heart, coin]
            for (var i = 0; i < p.length; i++) {
                parent.parent.updateResource(p[i].rtype, -p[i].active)
            }
            var r = [s_oil, s_iron, s_wood, s_food]
            for (i = 0; i < r.length; i++) {
                parent.parent.updateResource(r[i].type, r[i].getValue())
            }
            var worker = s_worker.getValue()
            var c = firstWorker.parent.children
            for (i = 1; i < c.length && worker; i++) {
                if (c[i].active) {
                    continue
                }
                c[i].active = true
                worker--
            }
        }

        function fixValues(spinner) {
            if (bolster.active && parent.parent.getResource("bolster") < 1
                    || heart.active && parent.parent.getResource("heart") < 1
                    || coin.active && parent.parent.getResource("coin") < 1) {
                spinner.setValue(0)
                return
            }
            var total = 0
            var r = [s_oil, s_iron, s_wood, s_food, s_worker]
            for (var i = 0; i < r.length; i++) {
                total += r[i].getValue()
            }
            var max = maxProd()
            if (total > max) {
                var over = total - max
                for (i = 0; i < r.length && over; i++) {
                    var val = r[i].getValue()
                    if (r[i] !== spinner && val > 0) {
                        var sub = Math.min(over, val)
                        r[i].setValue(val - sub)
                        over -= sub
                    }
                }
            }
        }

        function init() {
            var max = maxProd()
            var r = [s_oil, s_iron, s_wood, s_food]
            for (var i = 0; i < r.length; i++) {
                r[i].max = max
            }
            s_worker.max = Math.min(max, idleWorkers())
        }
    }

    function doAction() {
        dialog.init()
        dialog.open()
    }

    function maxProd() {
        return 8 - idleWorkers() + mill.active
    }

    function idleWorkers() {
        var c = firstWorker.parent.children
        for (var i = 1; i < c.length; i++) {
            if (!c[i].active) {
                return 7 - i
            }
        }
        return 0
    }
}
