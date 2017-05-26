import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.1

Column {
    id: root

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
        case "Upgrade": "bolster"; break;
        case  "Deploy":  "coin"; break;
        case   "Build": "heart"; break;
        case  "Enlist": "acard"; break;
        }
    }

    // icon type
    property string itype: {
        switch (atype) {
        case "Upgrade": "upgrade"; break;
        case  "Deploy":    "mech"; break;
        case   "Build":   "build"; break;
        case  "Enlist":  "enlist"; break;
        }
    }

    spacing: 5
    Layout.margins: 5

    Row {
        spacing: 5

        ResourceLabel { text: "Pay" }
        Repeater {
            model: cost

            ResourceSquare { rtype: ctype; isPay: true }
        }
    }
    Row {
        spacing: 5

        ResourceLabel { text: atype }
        ResourceSquare { rtype: itype }
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

    BottomDialog {
        id: deploy_dialog

        title: atype + " Action"
        ctype: root.ctype
        cost: root.cost
        payout: root.payout
        ptype: root.ptype
        enlist: root.enlist

        actionBody: Component {
            Row {
                spacing: 5
                ResourceLabel { size: 1.4; text: atype }
                ResourceSquare { rtype: itype; hsize: 1.4; wsize: 1.4 }
            }
        }

        onAccepted: {
            if (ApplicationWindow.window.getResource(ctype) >= cost ) {
                ApplicationWindow.window.updateResource(ctype, -cost)
                ApplicationWindow.window.updateResource("coin", deploy_dialog.coinCtr.getValue())
            }
        }

        function init() {
            deploy_dialog.coinCtr.setValue(payout)
            deploy_dialog.enlistCtr.setValue(enlist)
        }
    }

    function doAction() {
        var d = getDialog()
        d.init()
        d.open()
    }

    function getDialog() {
        switch (atype) {
        case "Upgrade": return deploy_dialog
        case  "Deploy": return deploy_dialog
        case   "Build": return deploy_dialog
        case  "Enlist": return deploy_dialog
        }
    }
}
