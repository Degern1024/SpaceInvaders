import QtQuick
import QtQuick.Controls

Item {
id: menu
//    property alias fun: b1.onClicked
        property alias notificationVis: notification.visible
        signal start()
        signal show()
        signal quit()
        signal hide()
    Text{
        x: root.width/3
        y: root.height/4
        text: "Space Invaders"
        font.pointSize: 20
//        font.family: "Comic Scans"
    }

    Button{
        id: b1
        x: root.width/3 * 1.25
        y: root.height/3
        width: 70
        height: 30
        Text{
            x: 20
            y: 5
            text: "Start"
        }
        onClicked: start();
    }
    Button{
        id: b2
        x: root.width/3 * 1.25
        y: root.height/3 + b1.height+10
        width: 70
        height: 30
        Text{
            x: 20
            y: 5
            text: "Quit"
        }
        onClicked: show();
    }
    Item{
        id: notification
        visible: false
        Text{
            id: warning
            text: "Do you want to exit?"
            x: root.width/3 * 1.15
            y: root.height/3 + b1.height + b2.height + 10

        }

        Button{
            x: root.width/3 * 1.05
            y: root.height/3 + b1.height + b2.height + warning.height + 10
            width: 70
            height: 30
            Text{
                x: 20
                y: 5
                text: "Yes"
            }
            onClicked: quit();
        }
        Button{
            x: root.width/3 * 1.45
            y: root.height/3 + b1.height + b2.height + warning.height + 10
            width: 70
            height: 30
            Text{
                x: 20
                y: 5
                text: "No"
            }
            onClicked: hide();
        }
    }


//    function start(){
//        console.log("dziala");
//    }

}
