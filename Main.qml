import QtQuick
import QtQuick.Window
import SpaceInvaders

Window {
    id: root
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

//bool running
    property bool running:false
    Item{
        id: stateID
        focus: true
        state: "IDLE"
        anchors.fill: parent

        MainController{id:mainController}

        Keys.onEscapePressed: mainController.toggleGame();

        states:[
        State{
            name: "PAUSED"
            StateChangeScript{
                script: mainController.pause();
            }
        },
            State{
                name: "RUNNING"
                StateChangeScript{
                    script: mainController.play();
                }
            },
            State{
                name: "IDLE"
            }

        ]

        MouseArea{
            id:mouseArea
            propagateComposedEvents: true
            anchors.fill: parent
            onPositionChanged: mainController.follow();
            hoverEnabled:true
        }

        MenuController{
            id:menu
//            onStart: root.start();
        }
        Game{
            id:game
            visible:false
        }


    }








}
