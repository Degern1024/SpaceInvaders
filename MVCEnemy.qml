import QtQuick

//stands for Model View Controller for Enemy

Item {
    id:mainEnemy
//    property int startY: 200
    property alias model: listView.model

    ListModel{
        id: enemyModel

        ListElement{enemyX: 56; enemyY: 0}
        ListElement{enemyX: 153; enemyY: 0}
        ListElement{enemyX: 250; enemyY: 0}
        ListElement{enemyX: 347; enemyY: 0}
        ListElement{enemyX: 444; enemyY: 0}
        ListElement{enemyX: 541; enemyY: 0}

        ListElement{enemyX: 56; enemyY: 75}
        ListElement{enemyX: 153; enemyY: 75}
        ListElement{enemyX: 250; enemyY: 75}
        ListElement{enemyX: 347; enemyY: 75}
        ListElement{enemyX: 444; enemyY: 75}
        ListElement{enemyX: 541; enemyY: 75}

        ListElement{enemyX: 56; enemyY: 150}
        ListElement{enemyX: 153; enemyY: 150}
        ListElement{enemyX: 250; enemyY: 150}
        ListElement{enemyX: 347; enemyY: 150}
        ListElement{enemyX: 444; enemyY: 150}
        ListElement{enemyX: 541; enemyY: 150}

    }
    Repeater{
        id: listView
        width: root.width
        height: root.height//enemy height
//        height:640
//        width:320
        model: enemyModel
        delegate: Enemy{
            id: enemy
            y: enemyY
            x: enemyX
//            Component.onCompleted: console.log(y+"index"+index);
        }
    }


}
