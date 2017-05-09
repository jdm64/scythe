import QtQuick 2.0
import QtQuick.Layouts 1.0

Column {
    Layout.margins: 5
    spacing: 5

    Row {
        spacing: 5

        ResourceLabel { text : "Pay" }
        ResourceSquare { rtype: "coin" }
    }
    Row {
        spacing: 5

        ResourceLabel {  text: "Bolster" }
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

        ResourceLabel { text: "Monument" }
        ResourceSquare {
            height: 1.6 * monumentTxt.height
            width: 1.8 * height
            rtype: "heart"
            active: false
        }
    }
}
