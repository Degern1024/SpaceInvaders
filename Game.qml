import QtQuick

Item {
    property alias playerPos: player.x
    signal follow()
    Rectangle{
        id:player
        x:0
        y:root.height-21
        width:41
        height:21 // width and height are current player sprite
//        color:"red"
        Image{
            source: "player2.png"

        }
    }

}
