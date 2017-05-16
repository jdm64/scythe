import QtQuick 2.0
import QtQuick.Controls 2.1

Row {
    id: rspinner

    property string type

    signal changed(var spinner)

    spacing: 5

    ResourceSquare {
        id: sq
        hsize: 1.4
        wsize: 1.4
        rtype: type
    }
    SpinBox {
        id: box
        height: sq.height
        width: 4.1 * height

        onValueChanged: rspinner.changed(rspinner)
    }

    function getValue() {
        return box.value
    }

    function setValue(val) {
        box.value = val
    }
}
