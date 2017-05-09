import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.2

Rectangle {
    property real hsize: 1
    property real wsize: 1
    property string rtype
    property bool active: true

    height: 4 * Screen.pixelDensity * hsize
    width: 4 * Screen.pixelDensity * wsize
    anchors.verticalCenter: parent.verticalCenter
    border.width: 1

    Image {
        height: parent.height
        width: parent.width
        fillMode: Image.PreserveAspectFit
        source: "images/" + rtype + ".png"
    }

    Rectangle {
        width: parent.width
        height: parent.height
        color: "black"
        opacity: 0.5
        visible: !active
    }
}
