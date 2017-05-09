import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.2

Rectangle {
    property real hsize: 1
    property real wsize: 1
    property string rtype
    property bool active: true

    height: 4 * Screen.pixelDensity * hsize
    width: 4 * Screen.pixelDensity * wsize
    anchors.verticalCenter: parent.verticalCenter
    border.width: 1

    color: {
        switch (rtype) {
        case   "heart":   "pink"; break;
        case    "coin":   "gold"; break;
        case    "wood":  "brown"; break;
        case    "food": "yellow"; break;
        case     "oil":   "teal"; break;
        case    "iron":   "grey"; break;
        case    "four": "orange"; break;
        case "bolster":  "black"; break;
        case   "acard":    "red"; break;
        case    "move":   "blue"; break;
        case    "prod":  "green"; break;
        default: "white";
        }
    }

    Rectangle {
        width: parent.width
        height: parent.height
        color: "black"
        opacity: 0.5
        visible: !active
    }
}
