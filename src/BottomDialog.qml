import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.1

Dialog {
    property string ctype: "oil"
    property int cost: 4
    property int payout: 4
    property string ptype: "coin"
    property bool enlist: false

    property alias coinCtr: s_coin
    property alias enlistCtr: s_enlist

    property Component actionBody: null

    id: build_dialog
    modal: true
    closePolicy: "NoAutoClose"
    standardButtons: Dialog.Cancel|Dialog.Ok
    x: (ApplicationWindow.window.width - build_dialog.width) / 2
    y: (ApplicationWindow.window.height - build_dialog.height) / 2
    parent: ApplicationWindow.overlay

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

        Loader {
            sourceComponent: actionBody
        }

        Divider { visible: payout || enlist }

        Row {
            spacing: 5
            visible: payout
            ResourceLabel { size: 1.4; text : "Gain  " }
            ResourceSpinner { id: s_coin; type: "coin"; max: payout }
        }
        Row {
            spacing: 5
            visible: enlist
            ResourceLabel { size: 1.4; text : "Enlist" }
            ResourceSpinner { id: s_enlist; type: ptype; max: 1 }
        }
    }
}
