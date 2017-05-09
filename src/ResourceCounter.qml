import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

Row {
    property string type
    property int value: 0

    Layout.margins: 3

    ResourceSquare {
        hsize: 1.2
        wsize: 1.2
        rtype: type
    }
    ResourceLabel {
        text: " " + value
        size: 1.4
    }
}
