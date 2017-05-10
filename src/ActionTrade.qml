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

        ResourceLabel { text: "Trade" }
        ResourceSquare { rtype: "four" }
        ResourceSquare { rtype: "four" }

        Rectangle {
            width: 2
            height: parent.height
            color: "black"
        }

        ResourceSquare { rtype: "heart" }
        ResourceSquare { rtype: "heart"; active: false }
    }
    Row {
        spacing: 5

        ResourceLabel { text: "Armory" }
        ResourceSquare {
            hsize: 1.8
            wsize: 1.8
            rtype: "bolster"
            active: false
        }
    }
}
