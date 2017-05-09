import QtQuick 2.0
import QtQuick.Layouts 1.0

Column {
    Layout.margins: 5
    spacing: 5

    Row {
        spacing: 5

        ResourceLabel { text: "Move/\nGain" }
        ResourceSquare { rtype: "move" }
        ResourceSquare { rtype: "move" }
        ResourceSquare { rtype: "move"; active: false }

        Rectangle {
            width: 2
            height: 0.8 * parent.height
            anchors.verticalCenter: parent.verticalCenter
            color: "black"
        }

        ResourceSquare { rtype: "coin" }
        ResourceSquare { rtype: "coin"; active: false }
    }
    Row {
        spacing: 5

        ResourceLabel { text: "Mine" }
        ResourceSquare {
            hsize: 1.4
            wsize: 2.5
            color: "blue"
            active: false
        }
    }
}
