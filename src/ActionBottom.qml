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
                ApplicationWindow.window.updateResource(ptype, deploy_dialog.enlistCtr.getValue())
            }
        }

        function init() {
            deploy_dialog.coinCtr.setValue(payout)
            deploy_dialog.enlistCtr.setValue(enlist)
        }
    }

    BottomDialog {
        id: build_dialog

        title: atype + " Action"
        ctype: root.ctype
        cost: root.cost
        payout: root.payout
        ptype: root.ptype
        enlist: root.enlist

        property string tobuild

        actionBody: Component {
            Grid {
                spacing: 5
                columns: 2
                Item {
                    height: children[0].height
                    width: children[0].width
                    Row {
                        spacing: 5
                        ResourceLabel { size: 1.4; text: "Mine" }
                        ResourceSquare { hsize: 1.4; wsize: 2.5; rtype: "mine"; }
                    }
                    Rectangle { visible: false; opacity: .6; color: "blue"; z: -1; anchors.fill: parent }
                    MouseArea { anchors.fill: parent; onDoubleClicked: select(parent) }
                }
                Item {
                    height: children[0].height
                    width: children[0].width
                    Row {
                        spacing: 5
                        ResourceSquare { hsize: 1.5; wsize: 1.5; rtype: "prod" }
                        ResourceLabel { size: 1.4; text: "Mill" }
                    }
                    Rectangle { visible: false; opacity: .6; color: "blue"; z: -1; anchors.fill: parent }
                    MouseArea { anchors.fill: parent; onDoubleClicked: select(parent) }
                }
                Item {
                    height: children[0].height
                    width: children[0].width
                    Row {
                        spacing: 5
                        ResourceLabel { size: 1.4; text: "Armory" }
                        ResourceSquare { hsize: 1.8; wsize: 1.8; rtype: "bolster" }
                    }
                    Rectangle { visible: false; opacity: .6; color: "blue"; z: -1; anchors.fill: parent }
                    MouseArea { anchors.fill: parent; onDoubleClicked: select(parent) }
                }
                Item {
                    height: children[0].height
                    width: children[0].width
                    Row {
                        spacing: 5
                        ResourceSquare { hsize: 1.6; wsize: 2.6; rtype: "heart" }
                        ResourceLabel { size: 1.4; text: "Monument" }
                    }
                    Rectangle { visible: false; opacity: .6; color: "blue"; z: -1; anchors.fill: parent }
                    MouseArea { anchors.fill: parent; onDoubleClicked: select(parent) }
                }
                function select(item) {
                    item.children[1].visible ^= true
                    var blocks = item.parent.children
                    var keys = ["mine", "mill", "armory", "monument"]
                    for (var i = 0; i < blocks.length; i++) {
                        if (blocks[i] === item) {
                            build_dialog.tobuild = keys[i]
                            continue
                        }
                        blocks[i].children[1].visible = false
                    }
                }
                function init(data) {
                    var keys = ["mine", "mill", "armory", "monument"]
                    for (var i = 0; i < keys.length; i++) {
                        this.children[i].children[0].children[(i + 1) % 2].active = data[keys[i]].active
                    }
                }
            }
        }

        onAccepted: {
            if (ApplicationWindow.window.getResource(ctype) >= cost ) {
                ApplicationWindow.window.updateResource(ctype, -cost)
                ApplicationWindow.window.updateResource("coin", build_dialog.coinCtr.getValue())
                ApplicationWindow.window.updateResource(ptype, build_dialog.enlistCtr.getValue())

                if (tobuild) {
                    var data = ApplicationWindow.window.getBuilding()
                    data[tobuild].active = true
                }
            }
        }

        function init() {
            tobuild = ""
            build_dialog.inner.children[0].init(ApplicationWindow.window.getBuilding())
            build_dialog.coinCtr.setValue(payout)
            build_dialog.enlistCtr.setValue(enlist)
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
        case   "Build": return build_dialog
        case  "Enlist": return deploy_dialog
        }
    }
}
