import QtQuick 2.0
import QtQuick.Layouts 1.0

Rectangle {
    Layout.fillWidth: true
    Layout.margins: 5

    Column {
        spacing: 5

        Row {
            spacing: 5

            Text { text : "Pay" }
            ResourceSquare { rtype: "coin" }
        }
        Row {
            spacing: 5

            Text { text: "Bolster" }
            ResourceSquare { rtype: "power" }
            ResourceSquare { rtype: "power" }
            ResourceSquare { rtype: "power"; active: false }

            Rectangle {
                width: 2
                height: parent.height
                anchors.verticalCenter: parent.verticalCenter
                color: "black"
            }

            ResourceSquare { rtype: "acard" }
            ResourceSquare { rtype: "acard"; active: false }
        }
        Row {
            spacing: 5

            Text {
                id: monumentTxt
                anchors.verticalCenter: parent.verticalCenter
                text: "Monument"
            }
            ResourceSquare {
                height: 1.6 * monumentTxt.height
                width: 1.8 * height
                rtype: "heart"
                active: false
            }
        }
    }
}
