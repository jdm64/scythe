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
        ResourceSquare { rtype: "bolster" }
        ResourceSquare { rtype: "bolster" }
        ResourceSquare { rtype: "bolster"; active: false }

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
            hsize: 1.6
            wsize: 2.6
            rtype: "heart"
            active: false
        }
    }
}
