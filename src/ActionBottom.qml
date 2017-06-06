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
        id: payRow

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
        ResourceSquare { id: enlist_sq; rtype: ptype; active: enlist }
    }

    DialogBottom {
        id: upgrade_dialog

        title: atype + " Action"
        ctype: root.ctype
        cost: root.cost
        payout: root.payout
        ptype: root.ptype
        enlist: root.enlist

        property int topSelect: -1
        property int botSelect: -1

        actionBody: Component {
            ColumnLayout {
                Row {
                    spacing: 5
                    ResourceLabel { size: 1.4; text: "From" }
                    Repeater {
                        model: 6
                        ResourceSquare { hsize: 1.4; wsize: 1.4
                            Rectangle { visible: false; opacity: .4; color: "blue"; z: 3; anchors.fill: parent }
                            MouseArea { anchors.fill: parent; onDoubleClicked: select(parent, true) }
                        }
                    }
                }
                Row {
                    spacing: 5
                    ResourceLabel { size: 1.4; text: "To     " }
                    Repeater {
                        model: 4
                        ResourceSquare { hsize: 1.4; wsize: 1.4
                            Rectangle { visible: false; opacity: .4; color: "blue"; z: 3; anchors.fill: parent }
                            MouseArea { anchors.fill: parent; onDoubleClicked: select(parent, false) }
                        }
                    }
                }
                function select(item, isTop) {
                    if (isTop === item.active) {
                        return
                    }
                    var res = item.parent.children
                    for (var i = 1; i < 5; i++) {
                        var same = res[i] === item
                        res[i].children[2].visible = same
                        if (same) {
                            if (isTop) {
                                upgrade_dialog.topSelect = i - 1
                            } else {
                                upgrade_dialog.botSelect = i - 1
                            }
                        }
                    }
                }
                function init(data) {
                    for (var i = 1; i < 7; i++) {
                        this.children[0].children[i].active = data["from"][i - 1].active
                        this.children[0].children[i].rtype = data["from"][i - 1].rtype
                    }
                    for (i = 0; i < data["to"].length; i++) {
                        this.children[1].children[i + 1].active = data["to"][i].active
                        this.children[1].children[i + 1].rtype = data["to"][i].rtype
                        this.children[1].children[i + 1].visible = true
                    }
                    for (i = data["to"].length; i < 5; i++) {
                        this.children[1].children[i + 1].visible = false
                    }
                }
            }
        }

        onAccepted: {
            if (ApplicationWindow.window.getResource(ctype) >= cost ) {
                ApplicationWindow.window.updateResource(ctype, -cost)
                ApplicationWindow.window.updateResource("coin", upgrade_dialog.coinCtr.getValue())
                ApplicationWindow.window.updateResource(ptype, upgrade_dialog.enlistCtr.getValue())
                var data = ApplicationWindow.window.getUpgrade()
                data["from"][topSelect].active = true
                data["to"][botSelect].active = false
            }
        }

        function init() {
            upgrade_dialog.inner.children[0].init(ApplicationWindow.window.getUpgrade())
            upgrade_dialog.coinCtr.setValue(payout)
            upgrade_dialog.enlistCtr.setValue(enlist)
        }
    }

    DialogBottom {
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

    DialogBottom {
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

    DialogBottom {
        id: enlist_dialog

        title: atype + " Action"
        ctype: root.ctype
        cost: root.cost
        payout: root.payout
        ptype: root.ptype
        enlist: root.enlist

        property int topSelect: -1
        property int botSelect: -1

        actionBody: Component {
            ColumnLayout {
                Row {
                    spacing: 5
                    ResourceLabel { size: 1.4; text: "From" }
                    ResourceSquare { rtype: "bolster"; hsize: 1.4; wsize: 1.4
                        Rectangle { visible: false; opacity: .4; color: "blue"; z: 3; anchors.fill: parent }
                        MouseArea { anchors.fill: parent; onDoubleClicked: select(parent, true) }
                    }
                    ResourceSquare { rtype: "coin"; hsize: 1.4; wsize: 1.4; active: false
                        Rectangle { visible: false; opacity: .4; color: "blue"; z: 3; anchors.fill: parent }
                        MouseArea { anchors.fill: parent; onDoubleClicked: select(parent, true) }
                    }
                    ResourceSquare { rtype: "heart"; hsize: 1.4; wsize: 1.4
                        Rectangle { visible: false; opacity: .4; color: "blue"; z: 3; anchors.fill: parent }
                        MouseArea { anchors.fill: parent; onDoubleClicked: select(parent, true) }
                    }
                    ResourceSquare { rtype: "acard"; hsize: 1.4; wsize: 1.4
                        Rectangle { visible: false; opacity: .4; color: "blue"; z: 3; anchors.fill: parent }
                        MouseArea { anchors.fill: parent; onDoubleClicked: select(parent, true) }
                    }
                }
                Row {
                    spacing: 5
                    ResourceLabel { size: 1.4; text: "To     " }
                    ResourceSquare { rtype: "bolster"; hsize: 1.4; wsize: 1.4
                        Rectangle { visible: false; opacity: .4; color: "blue"; z: 3; anchors.fill: parent }
                        MouseArea { anchors.fill: parent; onDoubleClicked: select(parent, false) }
                    }
                    ResourceSquare { rtype: "coin"; hsize: 1.4; wsize: 1.4
                        Rectangle { visible: false; opacity: .4; color: "blue"; z: 3; anchors.fill: parent }
                        MouseArea { anchors.fill: parent; onDoubleClicked: select(parent, false) }
                    }
                    ResourceSquare { rtype: "heart"; hsize: 1.4; wsize: 1.4
                        Rectangle { visible: false; opacity: .4; color: "blue"; z: 3; anchors.fill: parent }
                        MouseArea { anchors.fill: parent; onDoubleClicked: select(parent, false) }
                    }
                    ResourceSquare { rtype: "acard"; hsize: 1.4; wsize: 1.4
                        Rectangle { visible: false; opacity: .4; color: "blue"; z: 3; anchors.fill: parent }
                        MouseArea { anchors.fill: parent; onDoubleClicked: select(parent, false) }
                    }
                }
                function select(item, isTop) {
                    if (isTop === item.active) {
                        return
                    }
                    var res = item.parent.children
                    for (var i = 1; i < 5; i++) {
                        var same = res[i] === item
                        res[i].children[2].visible = same
                        if (same) {
                            if (isTop) {
                                enlist_dialog.topSelect = i - 1
                            } else {
                                enlist_dialog.botSelect = i - 1
                            }
                        }
                    }
                }
                function init(data) {
                    for (var i = 1; i < 5; i++) {
                        this.children[0].children[i].active = data["from"][i - 1].active
                        this.children[1].children[i].active = data["to"][i - 1].active
                    }
                }
            }
        }

        onAccepted: {
            if (ApplicationWindow.window.getResource(ctype) >= cost ) {
                ApplicationWindow.window.updateResource(ctype, -cost)
                ApplicationWindow.window.updateResource("coin", enlist_dialog.coinCtr.getValue())
                ApplicationWindow.window.updateResource(ptype, enlist_dialog.enlistCtr.getValue())
                ApplicationWindow.window.setEnlist({"from": topSelect, "to": botSelect})
            }
        }

        function init() {
            enlist_dialog.inner.children[0].init(ApplicationWindow.window.getEnlist())
            enlist_dialog.coinCtr.setValue(payout)
            enlist_dialog.enlistCtr.setValue(enlist)
        }
    }

    function doAction() {
        var d = getDialog()
        d.init()
        d.open()
    }

    function getDialog() {
        switch (atype) {
        case "Upgrade": return upgrade_dialog
        case  "Deploy": return deploy_dialog
        case   "Build": return build_dialog
        case  "Enlist": return enlist_dialog
        }
    }

    function getEnlist() {
        return enlist_sq
    }

    function setEnlist(val) {
        enlist_sq.active = val
    }

    function getUpgrade(list) {
        var c = payRow.children
        var u = []
        for (var i = cost - upgrade + 1; i < c.length - 1; i++) {
            u.push(c[i])
        }
        while (u.length > 1) {
            if (!u[u.length - 1].active) {
                u.pop()
            }
            break
        }
        var x = u.pop()
        if (x) {
            list.push(x)
        }
    }
}
