import QtQuick 2.0
import QtQuick.Layouts 1.0

Rectangle {
    property string rtype
    property bool active: true

    height: parent.height
    width: height
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
