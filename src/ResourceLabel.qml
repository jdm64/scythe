import QtQuick 2.0
import QtQuick.Window 2.2

Text {
    property real size: 1

    anchors.verticalCenter: parent.verticalCenter
    font.pixelSize: 2 * Screen.pixelDensity * size
}
