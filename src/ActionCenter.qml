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
            if (!token) {
                parent.parent.doTopAction()
            }
        }
    }

    Image {
        opacity: 1
        height: .8 * Math.min(parent.height, parent.width)
        width: height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        visible: token
        source: "images/token.png"
    }
}
