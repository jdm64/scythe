import QtQuick 2.0
import QtQuick.Controls 2.1

Row {
    property string type

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
    }
}
