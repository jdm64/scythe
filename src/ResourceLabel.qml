import QtQuick 2.0
import QtQuick.Window 2.2
import "Util.js" as Util

Text {
    property real size: 1

    anchors.verticalCenter: parent.verticalCenter
    font.pixelSize: Util.scale(Screen.pixelDensity) * size
}
