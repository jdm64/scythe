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
            ResourceCounter { type: "heart" }
            ResourceCounter { type: "coin" }
            ResourceCounter { type: "power" }

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
            contentWidth: 1.3 * parent.width

            RowLayout {
                id: cards
                width: parent.width
                height: parent.height
                spacing: 0

                Repeater {
                    model: 5
                    ActionCard {}
                }
            }
        }
    }

    function loadBoard(data) {
        for (var i = 0; i < data.length; i++) {
            cards.children[i].load(data[i]);
        }
    }
}
