import QtQuick
import SpaceInvaders

Item{
    //this qml file is just a collection of methods
//    id: controller
    required property MVCEnemy enemyRow1
    required property GameData gameData



//    required property MVCEnemy enemyRow2
//    required property MVCEnemy enemyRow3
    property int direction:1

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

    function pause(loop, allyBullets, enemies){
        showUI(true, allyBullets, enemies);
        for(var i =0; i< bulletList.length;i++) bulletList[i].animationPaused=true;
        loop.running = false;

        console.log("pause works");
    }
    function play(loop, allyBullets, enemies){
        showUI(false, allyBullets, enemies);
        for(var i =0; i< bulletList.length;i++) bulletList[i].animationPaused=false;

        //TODO object collision
        var tmp = enemyRow1;
        console.log("enemyY"+enemyRow1.model.get(2).enemyY+"");



        loop.running = true;
        console.log("play works");
    }
    function showUI(show, allyBullets, enemies){
        menu.visible = show;
        game.visible = !show;
        allyBullets.forEach((bullet) => bullet.visible=!show);
//        enemies.visible=!show;
        enemyRow1.visible=!show;
//        enemyRow2.visible=!show;
//        enemyRow3.visible=!show;
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
            obj.animationRunning=true;
            parentObj.bulletList.push(obj);
            console.log(parentObj.bulletList.length);
        }
        else{
            console.log("shoting in pause");
        }
    }
    function gameLoop(bullets){

            console.log(gameData.getDirection());
//        console.log("game loop is not finished")
        //bullet movement
//        updateBullets(bullets);

//        console.log(gameData)

        bulletCollision(bullets);
        removeBullets(bullets);
        //enemy movement
        //checking bullet collision
    }
    function updateBullets(bullets){
        console.log("use of deprecated function");
        console.log("bullets");
        bullets.forEach((item)=>{
                  item.startY -= Parameters.bulletSpeed;
//                console.log("P"+Parameters.bulletSpeed);
                        }
        );



    }
    function removeBullets(bullets){

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
        bullets[index].visible=false;
        bullets.splice(index,1);
    }
    function removeEnemy(index){
        enemyRow1.model.remove(index,1);
    }

    function bulletCollision(bullets){
        var bulletX;
        var bulletY;
//        console.log("bulletCollision");

        //do this with for instead of for each
        for(var i=0;i<bullets.length;i++){
                    bulletX=bullets[i].startX+bullets[i].bulletWidth/2;
                    bulletY=bullets[i].startY+bullets[i].bulletHeight/2;

                        for(var j=0;j<enemyRow1.model.count;j++){
//                        console.log(i);
                        if(checkBullet(bullets[i], bulletX, bulletY, enemyRow1.model.get(j))){
                                    console.log("enemy collided with bullet");
                                    removeEnemy(j);
                                    removeBullet(bullets,i);//this should be for instead of for each
                                    break;
                                }
                    }
        }
    }
    //check if bullet collides with 1 enemy; true -> bullet collides with singleEnemy
    function checkBullet(bullet, bulletX,bulletY, singleEnemy){

//        var enemyX=singleEnemy.enemyX+Enemy.width/2;
//        var enemyY=singleEnemy.enemyY+Enemy.height/2;
        var enemyX=singleEnemy.enemyX+20.5;
        var enemyY=singleEnemy.enemyY+10.5;

//        if(Math.abs(enemyX-bulletX) <= 20.5+bullet.bulletWidth/2){
//            console.log("x sie zgadzaja");
//        }
//        if(Math.abs(enemyY-bulletY) <= 10.5+bullet.bulletHeight/2){
//            console.log("Y sie zgadzaja");
//        }

        if(Math.abs(enemyX-bulletX) <= 20.5+bullet.bulletWidth/2 && Math.abs(enemyY-bulletY) <= 10.5+bullet.bulletHeight/2){
            return true;
        }


        return false;
    }


}


