import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.1
import QtQuick.Window 2.2
import "Util.js" as Util

Item {
    property bool token: false

    Layout.fillHeight: true
    Layout.fillWidth: true

    MouseArea {
        anchors.fill: parent

        onDoubleClicked: {
            parent.parent.doTopAction()
        }
    }

    Image {
        opacity: 1
        height: .5 * Math.min(parent.height, parent.width)
        width: height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom

        visible: token
        source: "images/token.png"
    }
}
