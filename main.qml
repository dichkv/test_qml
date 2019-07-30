import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtMultimedia 5.12

import "content" as Content

ApplicationWindow {
    visible: true
    width: 1280
    height: 800
    title: qsTr("Video Phone")

    background: Image {
        id: imgbg
        source: "background.jpg"
    }

    ListView {
        id: clockview
        anchors.rightMargin: 1044
        anchors.bottomMargin: 556
        anchors.leftMargin: 10
        anchors.topMargin: 12
        anchors.fill: parent
        orientation: ListView.Horizontal
        cacheBuffer: 2000
        snapMode: ListView.SnapOneItem
        highlightRangeMode: ListView.ApplyRange

        delegate: Content.Clock { shift: timeShift }
        model: ListModel {
            ListElement { timeShift: 7 }
        }
    }
}
