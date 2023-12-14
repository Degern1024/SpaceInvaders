import QtQuick

Item {
    id: menuController
    Menu{
        id:menu
        onStart: menuController.start();
        onShow: menuController.show();
        onQuit: menuController.quit();
        onHide: menuController.hide();
    }





    function start(){
        if(root.running==false){
            mainController.firstStart();
        }
        running=true;
//        mainController.showUI(false);
        stateID.state="RUNNING";

        console.log("start gry przycisk dziala");
    }
    function show(){
//        console.log(menu.notificationVis);
        menu.notificationVis=true;
//        console.log(menu.notificationVis);
    }

    function quit(){
        Qt.exit(0);
    }
    function hide(){
        menu.notificationVis=false;
    }
}
