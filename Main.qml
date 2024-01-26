import QtQuick
import QtQuick.Window
import SpaceInvaders


Window {
    id: root
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    property bool running: false //true if game started, nothing else
    property list<Bullet> bulletList;

    Item{
        id: gameWrapper
        focus: true
        state: "IDLE"
        anchors.fill: parent

        MainController{
            id: mainController
            enemyRow1: enemies
            gameData: myGameData//may show error, but compiles
            enemyWidth: 41
            failureY: root.height - 21 - game.playerHeight//41 is height of enemy
            endScreen: end
            mouseTrigger: mouseArea

        }

        Keys.onEscapePressed: mainController.toggleGame();

        states:[
        State{
            name: "PAUSED"
            StateChangeScript{
                script: mainController.pause(gameLoop, bulletList, enemies);
            }
        },
            State{
                name: "RUNNING"
                StateChangeScript{
                    script: mainController.play(gameLoop, bulletList, enemies);
                }
            },
            State{
                name: "IDLE"
            }

        ]



        MouseArea{
            id: mouseArea
            propagateComposedEvents: true
            anchors.fill: parent
            onPositionChanged: mainController.follow(this, game, root.width, game.playerWidth);
            onClicked: mainController.shot(gameWrapper.state);
            hoverEnabled: true
            z: 100
        }

        MenuController{
            id: menu
            z: 150
//            onStart: root.start();
        }
        Game{
            id: game
            visible: false
        }
        Timer{
            id: gameLoop
            interval: Parameters.gameSpeed
            repeat: true
            running: false
            onTriggered: mainController.gameLoop(bulletList);
        }
        MVCEnemy{
            id: enemies
            visible: false
        }
        GameData{
            id: myGameData
//            Component.onCompleted: console.log(myGameData.getDirection());
        }
        EndScreen{
            id: end
            visible: false
            z: 90
        }

    }








}
