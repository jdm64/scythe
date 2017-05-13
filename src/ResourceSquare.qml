import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.2
import "Util.js" as Util

Rectangle {
    property real hsize: 1
    property real wsize: 1
    property string rtype
    property bool active: true
    property bool isPay: false

    height: 2 * Util.scale(Screen.pixelDensity) * hsize
    width: 2 * Util.scale(Screen.pixelDensity) * wsize
    anchors.verticalCenter: parent.verticalCenter
    color: isPay? "#983c27" : "#7b8b67"
    border.width: 1

    Image {
        height: parent.height
        width: parent.width
        fillMode: Image.PreserveAspectFit
        source: rtype.length? "images/" + rtype + ".png" : ""
    }

    Rectangle {
        width: parent.width
        height: parent.height
        color: "black"
        opacity: 0.6
        visible: !active
    }
}
