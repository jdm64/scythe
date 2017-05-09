import QtQuick 2.0
import QtQuick.Layouts 1.0

Column {
    Layout.margins: 5
    spacing: 5

    Row {

        ResourceLabel { text : "Pay  " }
        ResourceSquare {
            hsize: 1.4
            color: "red"
            active: false
        }
        ResourceSquare {
            hsize: 1.4
            rtype: "bolster"
            color: "red"
            active: false
        }
        ResourceSquare {
            hsize: 1.4
            color: "red"
            active: false
        }
        ResourceSquare {
            hsize: 1.4
            rtype: "heart"
            color: "red"
            active: false
        }
        ResourceSquare {
            hsize: 1.4
            color: "red"
            active: false
        }
        ResourceSquare {
            hsize: 1.4
            color: "red"
            rtype: "coin"
            active: false
        }
    }
    Row {
        spacing: 5

        ResourceLabel { text: "Produce" }
        ResourceSquare { rtype: "prod" }
        ResourceSquare { rtype: "prod" }
        ResourceSquare { rtype: "prod"; active: false }
    }
    Row {
        spacing: 5

        ResourceLabel { text: "Mill" }
        ResourceSquare {
            hsize: 1.5
            wsize: 1.5
            rtype: "prod"
            active: false
        }
    }
}
