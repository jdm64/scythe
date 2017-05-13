import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import "Util.js" as Util

ApplicationWindow {
    id: root
    visible: true
    width: 640
    height: 360
    title: qsTr("Scythe Player Board")

    Component.onCompleted: loadBoard(Util.getBoard(boardSelector.currentText))

    ColumnLayout {
        height: parent.height
        width: parent.width
        spacing: 0

        RowLayout {
            ResourceCounter { id: heartCtr; type: "heart" }
            ResourceCounter { id:  coinCtr; type: "coin" }
            ResourceCounter { id: powerCtr; type: "bolster" }

            ComboBox {
                id: boardSelector
                currentIndex: 0
                model: Object.keys(Util.Boards)
                onCurrentIndexChanged: loadBoard(Util.getBoard(textAt(currentIndex)));
            }
        }

        Rectangle {
            height: 1
            color: "black"
            Layout.fillWidth: true
        }

        Flickable {
            Layout.fillWidth: true
            Layout.fillHeight: true
            contentWidth: cards.width

            RowLayout {
                id: cards
                height: parent.height
                spacing: 0

                Repeater {
                    model: 5
                    ActionCard {}
                }

                function clearTokens(card) {
                    root.clearTokens(card)
                }
            }
        }
    }

    function loadBoard(data) {
        var cardData = data.a;
        heartCtr.value = data.h;
        coinCtr.value = data.c;
        for (var i = 0; i < cardData.length; i++) {
            cards.children[i].load(cardData[i]);
        }
    }

    function clearTokens(card) {
        for (var i = 0; i < 5; i++) {
            if (card !== cards.children[i]) {
                cards.children[i].setToken(false)
            }
        }
    }
}
