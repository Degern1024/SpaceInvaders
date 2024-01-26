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
        if(root.running === false){
            mainController.firstStart();
        }
        running = true;
//        mainController.showUI(false);
        gameWrapper.state = "RUNNING";

        console.log("start gry przycisk dziala");
    }
    function show(){
        menu.notificationVis = true;
    }

    function quit(){
        Qt.exit(0);
    }
    function hide(){
        menu.notificationVis = false;
    }
}
