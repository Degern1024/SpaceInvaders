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
    property bool running:false //true if game started, nothing else
    property list<Bullet> bulletList;
    Item{
        id: gameWrapper
        focus: true
        state: "IDLE"
        anchors.fill: parent

        MainController{id:mainController}

        Keys.onEscapePressed: mainController.toggleGame();

        states:[
        State{
            name: "PAUSED"
            StateChangeScript{
                script: mainController.pause(gameLoop, bulletList);
            }
        },
            State{
                name: "RUNNING"
                StateChangeScript{
                    script: mainController.play(gameLoop, bulletList);
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
            onPositionChanged: mainController.follow(this, game, root.width, game.playerWidth);
            onClicked: mainController.shot(gameWrapper.state);
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
        Timer{
            id:gameLoop
            interval:Parameters.gameSpeed
            repeat:true
            running:false
            onTriggered:mainController.gameLoop(bulletList);
        }

    }








}
