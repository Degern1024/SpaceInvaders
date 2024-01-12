import QtQuick

Item{
    //this qml file is just a collection of methods
//    id: controller


    function toggleGame(){
        if(!root.running){
            console.log("game is not started")
            return;
        }


        if(gameWrapper.state === "PAUSED"){
            gameWrapper.state = "RUNNING";
//            root.play();
        }
        else{
            gameWrapper.state = "PAUSED";
//            root.pause();
        }

        console.log("toggling");
    }

    function pause(loop, allyBullets){
        showUI(true, allyBullets);
        loop.running = false;
        console.log("pause works");
    }
    function play(loop, allyBullets){
        showUI(false, allyBullets);
        loop.running = true;
        console.log("play works");
    }
    function showUI(show, allyBullets){
        menu.visible = show;
        game.visible = !show;
        allyBullets.forEach((bullet) => bullet.visible=!show);

    }
    function firstStart(){
        console.log("first start only function")
    }
    function follow(mouse, player, windowWidth, playerWidth){
//        console.log(mouse.mouseX);

        var temp = mouse.mouseX - playerWidth/2 - 0.5;//width is odd number
//        console.log("after declaration"+playerWidth);
        if(temp < 0) temp = 0;
        else if(temp > windowWidth - playerWidth) temp = windowWidth - playerWidth;
//        console.log(temp);

        player.playerPos = temp;
//        game.playerPos=mouseArea.mouseX;


//        console.log("follow mouse");
    }


    property date lastShot: new Date()
    //creates object and adds him to window.bulletList (where game logic is)
    function shot(gameState, parentObj=root, player=game){
        console.log(gameState);
        if(gameState === "RUNNING"){
            console.log("shoting");
            var currentTime = new Date();
            var timeDiff = currentTime - lastShot;
            console.log(timeDiff);
            if(timeDiff < Parameters.delayShots) return;

            lastShot=currentTime;
            var component = Qt.createComponent("Bullet.qml");
            var obj = component.createObject(parentObj);
            obj.startX = player.playerPos + player.playerWidth/2 + 0.5 - obj.bulletWidth/2;
            obj.startY = parentObj.height - obj.bulletHeight - player.playerHeight;
            obj.visible = true;

            parentObj.bulletList.push(obj);
            console.log(parentObj.bulletList.length);
        }
        else{
            console.log("shoting in pause");
        }
    }
    function gameLoop(bullets){
//        console.log("game loop is not finished")
        //bullet movement
        updateBullets(bullets);
        removeBullets(bullets);
        //enemy movement
        //checking bullet collision
    }
    function updateBullets(bullets){
        console.log("bullets");
        bullets.forEach((item)=>{
                  item.startY -= Parameters.bulletSpeed;
//                console.log("P"+Parameters.bulletSpeed);
                        }
        );



    }
    function removeBullets(bullets){
//        console.log("TODO remove bullets out of bonds");

        for(var i = 0; i < bullets.length; i++){
//            console.log("sY"+bullets[i].startY+"<" + bullets[i].bulletHeight);
            if(bullets[i].startY < -bullets[i].bulletHeight){
                console.log("bullet out of bond");
                removeBullet(bullets, i);
                i--;
            }
        }


    }
    function removeBullet(bullets, index){
        bullets.splice(index,1);
    }

}


