import QtQuick

Item {
    property alias txt: content.text
    Rectangle{
        width: root.width
        height: root.height
        x:0
        y:0
        Text{
            id: content
            x: parent.width/2 - 40
            y: parent.height/2 - 10
//            text: "Koniec gry"
        }

    }

}
