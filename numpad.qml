import QtQuick 2.0

Item {
    id: numpad

    signal buttonPressed
    x: 0
    width: 250
    height: 380
    transformOrigin: Item.Center

    Button { text: "1" ; anchors.left: parent.left;anchors.leftMargin: 20 }
    Button { x: 100; text: "2" ; anchors.horizontalCenter: parent.horizontalCenter }
    Button { x: 200; text: "3" ; anchors.right: parent.right; anchors.rightMargin: 20 }
    Button { y: 80; text: "4" ; anchors.left: parent.left;anchors.leftMargin: 20 }
    Button { y: 80; text: "5" ; anchors.horizontalCenter: parent.horizontalCenter}
    Button { x: 200; y: 80; width: 30; text: "6" ; anchors.right: parent.right; anchors.rightMargin: 20}
    Button { y: 160; text: "7" ; anchors.left: parent.left;anchors.leftMargin: 20}
    Button { y: 160; text: "8" ;anchors.horizontalCenter: parent.horizontalCenter }
    Button { y: 160; text: "9" ; anchors.right: parent.right;anchors.rightMargin: 20 }
    Button { y: 240; text: "*" ; anchors.left: parent.left;anchors.leftMargin: 20 }
    Button { y: 240; text: "0" ;anchors.horizontalCenter: parent.horizontalCenter }
    Button { y: 240; text: "#" ; anchors.right: parent.right;anchors.rightMargin: 20 }

    Image {
        id: dial
        x: 10
        y: 320
        width: 50
        height: 50
        source: "content/call.svg"
    }

    Image {
        id: answer
        x: 10
        y: 320
        width: 50
        height: 50
        anchors.horizontalCenter: parent.horizontalCenter
        source: "content/answer.svg"
    }

    Image {
        id: hungup
        x: 192
        width: 50
        height: 50
        anchors.right: parent.right
        anchors.rightMargin: 8
        y: 320
        source: "content/hangup.svg"
    }
}
