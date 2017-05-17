import QtQuick 2.0
import QtQuick.Layouts 1.0

Rectangle {
    property bool hoz: true
    property int size: 1

    height: hoz? size : parent.height
    width: hoz? parent.width : size
    color: "black"

    Layout.fillWidth: hoz
    Layout.fillHeight: !hoz
}
