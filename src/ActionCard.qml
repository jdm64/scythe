import QtQuick 2.0
import QtQuick.Layouts 1.0
import "Util.js" as Util

Rectangle {
    Layout.fillWidth: true
    Layout.fillHeight: true
    border.width: 1

    ColumnLayout {
        id: card
        anchors.fill: parent
    }

    function clear() {
        for (var i = 0; i < card.children.length; i++) {
            card.children[i].destroy();
        }
    }

    /**
     * {"t": <topAction>, "b": <bottomAction>}
     */
    function load(data) {
        clear();
        Util.loadCard(card, data.t, data.b);
    }
}