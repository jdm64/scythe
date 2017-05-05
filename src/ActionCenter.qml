import QtQuick 2.0
import QtQuick.Layouts 1.0

Item {
    property bool token: false

    Layout.fillHeight: true
    Layout.fillWidth: true

    Rectangle {
        opacity: 1
        height: parent.height / 4
        width: parent.width / 4
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        visible: token
        color: "green"
    }
}
