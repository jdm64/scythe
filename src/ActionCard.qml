import QtQuick 2.0
import QtQuick.Layouts 1.0
import "Util.js" as Util

ColumnLayout {
    id: card

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

    function setToken(val) {
        if (card.children[1])
            card.children[1].token = val
    }

    function passClick(card) {
        parent.passClick(card)
    }
}
