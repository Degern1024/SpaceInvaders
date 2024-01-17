import QtQuick

Item {
//    objectName:testBullet
    property alias startX: bullet.x
    property alias startY: bullet.y
    property alias bulletWidth: bullet.width
    property alias bulletHeight: bullet.height
    property alias animationPaused: animation.paused
    property alias animationRunning: animation.running




    visible:false
    Rectangle{
        id:bullet
        width:10
        height:30
//        border.color: "green"
        color: "green"
//        y:root.height-30-game.playerHeight
        NumberAnimation on y{
            id: animation
//            property: "animation"
//            to: -bullet.height-1;
            from:root.height-30-game.playerHeight
            to:-50
            running:false
//            paused:true
            duration: (root.height-30-game.playerHeight)/3*Parameters.gameSpeed
//            duration:4719
        }

    }
    function show(){

    }


}
