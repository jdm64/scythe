import QtQuick 2.0
import QtQuick.Layouts 1.0

Column {
    Layout.margins: 5
    spacing: 5

    Row {
        spacing: 5

        Text { text : "Pay" }
        ResourceSquare { rtype: "coin" }
    }
    Row {
        spacing: 5

        Text { text: "Trade" }
        ResourceSquare { rtype: "four" }
        ResourceSquare { rtype: "four" }

        Rectangle {
            width: 2
            height: parent.height
            color: "black"
        }

        ResourceSquare { rtype: "heart" }
        ResourceSquare { rtype: "heart" }
    }
    Row {
        spacing: 5

        Text {
            id: armoryTxt
            anchors.verticalCenter: parent.verticalCenter
            text: "Armory"
        }
        ResourceSquare {
            height: 2 * armoryTxt.height
            rtype: "power"
        }
    }
}
