import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.0
import "Util.js" as Util

ApplicationWindow {
    id: root
    visible: true
    width: 640
    height: 360
    title: qsTr("Scythe Player Board")

    Component.onCompleted: {
        loadBoard(Util.getBoard(boardSelector.currentText))
        fixCardWidths()
    }

    ColumnLayout {
        height: parent.height
        width: parent.width
        spacing: 0

        RowLayout {
            ResourceCounter { id:  coinCtr; type: "coin" }
            ResourceCounter { id: heartCtr; type: "heart"; max: 18 }
            ResourceCounter { id: powerCtr; type: "bolster"; max: 16 }
            ResourceCounter { id:   oilCtr; type: "oil" }
            ResourceCounter { id:  ironCtr; type: "iron" }
            ResourceCounter { id:  woodCtr; type: "wood" }
            ResourceCounter { id:  foodCtr; type: "food" }
            ResourceCounter { id: acardCtr; type: "acard"; visible: false }
            ResourceCounter { type: "enlist"; onClicked: enlist_dialog.open() }

            ComboBox {
                id: boardSelector
                currentIndex: 0
                model: Object.keys(Util.Boards)
                onCurrentIndexChanged: loadBoard(Util.getBoard(textAt(currentIndex)));
            }
        }

        Divider {}

        Flickable {
            Layout.fillWidth: true
            Layout.fillHeight: true
            contentWidth: cards.width

            RowLayout {
                id: cards
                height: parent.height
                spacing: 0

                ActionCard {}
                Divider { hoz: false }
                ActionCard {}
                Divider { hoz: false }
                ActionCard {}
                Divider { hoz: false }
                ActionCard {}
                Divider { hoz: false }
                ActionCard {}
            }
        }
    }

    Dialog {
        id: enlist_dialog
        modal: true
        closePolicy: "NoAutoClose"
        standardButtons: Dialog.Ok
        x: (ApplicationWindow.window.width - width) / 2
        y: (ApplicationWindow.window.height - height) / 2
        parent: ApplicationWindow.overlay
        title: "Enlisted"

        Row {
            id: enlist_data
            spacing: 5
            ResourceSquare { rtype: "bolster"; hsize: 1.8; wsize: 1.8 }
            ResourceSquare { rtype: "coin"; hsize: 1.8; wsize: 1.8 }
            ResourceSquare { rtype: "heart"; hsize: 1.8; wsize: 1.8 }
            ResourceSquare { rtype: "acard"; hsize: 1.8; wsize: 1.8 }
        }
    }

    function getAction(cardIdx, actionIdx) {
        return cards.children[2 * cardIdx].children[actionIdx]
    }

    function fixCardWidths() {
        var max = 0
        for (var i = 0; i < 5; i++) {
            max = Math.max(max, cards.children[2 * i].width)
        }
        for (i = 0; i < 5; i++) {
            cards.children[2 * i].Layout.minimumWidth = max
        }

        max = 0
        for (i = 0; i < 4; i++) {
            max = Math.max(max, getAction(i, 0).height)
        }
        for (i = 0; i < 4; i++) {
            getAction(i, 0).Layout.minimumHeight = max
        }
    }

    function loadBoard(data) {
        var cardData = data.a;
        heartCtr.value = data.h;
        coinCtr.value = data.c;
        for (var i = 0; i < cardData.length; i++) {
            cards.children[2 * i].load(cardData[i]);
        }
    }

    function clearTokens(card) {
        for (var i = 0; i < 5; i++) {
            if (card !== cards.children[2 * i]) {
                cards.children[2 * i].setToken(false)
            }
        }
    }

    function getResourceCtr(type) {
        switch (type) {
        case   "heart": return heartCtr;
        case    "coin": return  coinCtr;
        case "bolster": return powerCtr;
        case     "oil": return   oilCtr;
        case    "iron": return  ironCtr;
        case    "wood": return  woodCtr;
        case    "food": return  foodCtr;
        case   "acard": return acardCtr;
        }
    }

    function updateResource(type, delta) {
        getResourceCtr(type).changeValue(delta)
    }

    function getResource(type) {
        return getResourceCtr(type).getValue()
    }

    function getBuilding() {
        var data = {}
        for (var i = 0; i < 4; i++) {
            getAction(i, 0).getBuilding(data)
        }
        return data
    }

    function getEnlist() {
        var data = {}
        data["to"] = enlist_data.children
        data["from"] = []
        for (var i = 0; i < 4; i++) {
            data["from"].push(getAction(i, 2).getEnlist())
        }
        return data
    }

    function setEnlist(data) {
        getAction(data["from"], 2).setEnlist(true)
        var toEnlist = enlist_data.children[data["to"]]
        toEnlist.active = false
        updateResource(toEnlist.rtype, 2)
    }

    function getUpgrade() {
        var data = {}
        data["from"] = []
        data["to"] = []
        for (var i = 0; i < 4; i++) {
            getAction(i, 0).getUpgrade(data["from"])
            getAction(i, 2).getUpgrade(data["to"])
        }
        return data
    }
}
