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
    Item{
        id: stateID
        focus: true
        state: "IDLE"
        anchors.fill: parent
        Keys.onPressed: toggleGame();


        states:[
        State{
            name: "PAUSED"
            StateChangeScript{
                script: root.pause();
            }
        },
            State{
                name: "CONTINUE"
                StateChangeScript{
                    script: root.play();
                }
            },
            State{
                name: "IDLE"
            }

        ]

        Menu{
            onStart: root.start();
        }




    }






    function toggleGame(){
//        if()

        if(stateID.state=="PAUSED"){
            stateID.state="CONTINUE";
//            root.play();
        }
        else{
            stateID.state="PAUSED";
//            root.pause();
        }

        console.log("toggling");
    }

    function start(){
        console.log("start gry dziala");
    }
    function pause(){
        console.log("pause works");
    }
    function play(){
        console.log("play works");
    }

}
