import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

Row {
    property string type
    property int value: 0
    property int max: 0

    signal clicked(var self)

    Layout.margins: 3

    ResourceSquare {
        hsize: 1.2
        wsize: 1.2
        rtype: type

        MouseArea {
            anchors.fill: parent
            onDoubleClicked: parent.parent.clicked(parent.parent)
        }
    }
    ResourceLabel {
        text: " " + value
        size: 1.4
    }

    function getValue() {
        return value
    }

    function changeValue(delta) {
        value += delta
        if (max && value > max) {
            value = max
        }
    }
}
