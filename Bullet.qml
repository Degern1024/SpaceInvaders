import QtQuick

Item {
//    objectName:testBullet
    property alias startX: bullet.x
    property alias startY: bullet.y
    property alias bulletWidth: bullet.width
    property alias bulletHeight: bullet.height
    visible:false
    Rectangle{
        id:bullet
        width:10
        height:30
//        border.color: "green"
        color: "green"
//        y:root.height-30-game.playerHeight
    }
    function show(){

    }

}
