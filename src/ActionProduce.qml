import QtQuick 2.0
import QtQuick.Layouts 1.0

Column {
    Layout.margins: 5
    spacing: 5

    Row {

        Text {
            id: payTxt
            anchors.verticalCenter: parent.verticalCenter
            text : "Pay  "
        }
        Repeater {
            model: 6

            ResourceSquare {
                height: 1.5 * payTxt.height
                width: payTxt.height
                color: "red"
                active: false
            }
        }
    }
    Row {
        spacing: 5

        Text { text: "Produce" }
        ResourceSquare { rtype: "prod" }
        ResourceSquare { rtype: "prod" }
        ResourceSquare { rtype: "prod"; active: false }
    }
    Row {
        spacing: 5

        Text {
            id: millTxt
            anchors.verticalCenter: parent.verticalCenter
            text: "Mill"
        }
        ResourceSquare {
            height: 1.5 * millTxt.height
            rtype: "prod"
            active: false
        }
    }
}
