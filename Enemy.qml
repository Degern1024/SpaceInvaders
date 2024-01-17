import QtQuick

Item {
    property alias startY: enemy.y

    Rectangle{
        id:enemy
        width: 41
        height:21
        x:0
        y:0
//        color: "red"
        Image{
            //this image is not working
            x:0
            y:0
            source: "enemy.png"
        }
    }

}
