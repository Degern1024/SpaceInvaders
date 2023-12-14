import QtQuick

Item{
    //this qml file is just a collection of methods
//    id: controller

    function toggleGame(){
        if(root.running==false){
            console.log("game is not started")
            return;
        }


        if(stateID.state=="PAUSED"){
            stateID.state="RUNNING";
//            root.play();
        }
        else{
            stateID.state="PAUSED";
//            root.pause();
        }

        console.log("toggling");
    }

    function pause(){
        showUI(true);
        console.log("pause works");
    }
    function play(){
        showUI(false);
        console.log("play works");
    }
    function showUI(show){
        menu.visible=show;
        game.visible=!show;
    }
    function firstStart(){
        console.log("first start only function")
    }
    function follow(){
        game.playerPos=mouseArea.x;
//        console.log(mouseArea.y);
//        console.log("follow mouse");
    }


}


