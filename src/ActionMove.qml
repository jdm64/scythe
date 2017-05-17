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

        Divider { hoz: false; size: 2 }

        ResourceSquare { rtype: "coin" }
        ResourceSquare { rtype: "coin"; active: false }
    }
    Row {
        spacing: 5

        ResourceLabel { text: "Mine" }
        ResourceSquare {
            hsize: 1.4
            wsize: 2.5
            rtype: "mine"
            active: false
        }
    }
}
