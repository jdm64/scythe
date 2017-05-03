import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

Row {
    property string type
    property int value: 0

    Layout.margins: 5

    ResourceSquare { rtype: type }

    Label {
        text: value
        leftPadding: 4
        font.pointSize: 14
        anchors.verticalCenter: parent.verticalCenter
    }
}
