import QtQuick 2.0
import QtQuick.Layouts 1.0

Column {
    property string atype: "Upgrade"
    property int cost: 2
    property int upgrade: 2
    property int payout: 1
    property bool enlist: false

    // cost type
    property string ctype: {
        switch (atype) {
        case "Upgrade":  "oil"; break;
        case  "Deploy": "iron"; break;
        case   "Build": "wood"; break;
        case  "Enlist": "food"; break;
        }
    }

    // enlist type
    property string ptype: {
        switch (atype) {
        case "Upgrade": "power"; break;
        case  "Deploy":  "coin"; break;
        case   "Build": "heart"; break;
        case  "Enlist": "acard"; break;
        }
    }

    spacing: 5
    Layout.margins: 5

    Row {
        spacing: 5

        ResourceLabel { text: "Pay" }
        Repeater {
            model: cost

            ResourceSquare { rtype: ctype }
        }
    }
    Row {
        spacing: 5

        ResourceLabel { text: atype }
        ResourceSquare {}
        Repeater {
            model: payout

            ResourceSquare { rtype: "coin" }
        }
    }
    Row {
        spacing: 5

        ResourceLabel { text: "Gain" }
        ResourceSquare { rtype: ptype; active: enlist }
    }
}
