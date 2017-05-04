import QtQuick 2.0
import QtQuick.Layouts 1.0

Rectangle {
    Layout.fillWidth: true
    Layout.margins: 5

    Column {
        spacing: 5

        Row {
            spacing: 5

            Text { text: "Move/\nGain" }
            ResourceSquare {
                height: parent.height / 2
                rtype: "move"
            }
            ResourceSquare {
                height: parent.height / 2
                rtype: "move"
            }
            ResourceSquare {
                height: parent.height / 2
                rtype: "move"
                active: false
            }

            Rectangle {
                width: 2
                height: 0.8 * parent.height
                anchors.verticalCenter: parent.verticalCenter
                color: "black"
            }

            ResourceSquare {
                height: parent.height / 2
                rtype: "coin"
            }
            ResourceSquare {
                height: parent.height / 2
                rtype: "coin"
                active: false
            }
        }
        Row {
            spacing: 5

            Text {
                id: mineTxt
                anchors.verticalCenter: parent.verticalCenter
                text: "Mine"
            }
            ResourceSquare {
                height: 1.5 * mineTxt.height
                width: 1.7 * height
                color: "blue"
                active: false
            }
        }
    }
}
