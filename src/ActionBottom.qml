import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.1

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

    Dialog {
        id: deploy_dialog
        modal: true
        closePolicy: "NoAutoClose"
        standardButtons: Dialog.Cancel|Dialog.Ok
        x: (ApplicationWindow.window.width - deploy_dialog.width) / 2
        y: (ApplicationWindow.window.height - deploy_dialog.height) / 2
        parent: ApplicationWindow.overlay
        title: "Deploy Action"

        ColumnLayout {
            Row {
                spacing: 5
                ResourceLabel { size: 1.4; text : "Pay" }
                Repeater {
                    model: cost

                    ResourceSquare { rtype: ctype; isPay: true; hsize: 1.4; wsize: 1.4 }
                }
            }

            Divider { size: 2 }

            Row {
                spacing: 5
                ResourceLabel { size: 1.4; text : "Deploy" }
                ResourceSquare { rtype: itype; hsize: 1.4; wsize: 1.4 }
            }

            Divider { visible: enlist || payout }

            Row {
                spacing: 5
                visible: enlist || payout

                ResourceSpinner { id: deploy_coin; type: "coin"; max: payout + enlist }
            }
        }

        onAccepted: {
            if (ApplicationWindow.window.getResource(ctype) >= cost ) {
                ApplicationWindow.window.updateResource(ctype, -cost)
                ApplicationWindow.window.updateResource("coin", deploy_coin.getValue())
            }
        }

        function init() {
            deploy_coin.setValue(payout + enlist)
        }
    }

    function doAction() {
        deploy_dialog.init()
        deploy_dialog.open()
    }
}
