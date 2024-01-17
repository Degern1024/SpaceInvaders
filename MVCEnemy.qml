import QtQuick

//stands for Model View Controller for Enemy

Item {
    id:mainEnemy
    property int startY: 200
    ListModel{
        id: enemyModel

        ListElement{enemyX: 0}
        ListElement{enemyX: 100}
        ListElement{enemyX: 200}
        ListElement{enemyX: 300}
        ListElement{enemyX: 400}
        ListElement{enemyX: 500}

    }
    ListView{
        id:listView
        width:root.width
        height:21//enemy height
//        height:640
//        width:320
        model: enemyModel
        delegate: Enemy{
            id:enemy
            y:mainEnemy.startY
            x:enemyX
        }
    }


}
