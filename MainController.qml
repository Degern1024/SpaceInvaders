import QtQuick
import QtMultimedia
import SpaceInvaders

Item{
    //this qml file is just a collection of methods
//    id: controller
    required property MVCEnemy enemyRow1
    required property GameData gameData
    required property int enemyWidth
    required property int failureY
    required property EndScreen endScreen
    required property MouseArea mouseTrigger
    required property MediaPlayer mediaPlayer


    property double startTime;
    property double timeOffset: 0;//Date.now() - Date.now() returns double

    property int direction: 1
//    property bool gameEnded: false

    function toggleGame(){
        if(!root.running){
            console.log("game is not started")
            return;
        }
        if(endScreen.visible) return;

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
        timeOffset = timeOffset + (Date.now() - startTime);
        console.log(timeOffset);
        showUI(true, allyBullets, enemies);
        for(var i =0; i< bulletList.length;i++) bulletList[i].animationPaused=true;
        loop.running = false;

        console.log("pause works");
    }
    function play(loop, allyBullets, enemies){
        startTime=Date.now();
        showUI(false, allyBullets, enemies);
        for(var i =0; i < bulletList.length;i++) bulletList[i].animationPaused=false;

        //TODO object collision
        var tmp = enemyRow1;
        console.log("enemyY"+enemyRow1.model.get(2).enemyY+"");



        loop.running = true;
        console.log("play works");
    }
    function showUI(show, allyBullets, enemies){
        menu.visible = show;
        game.visible = !show;
        allyBullets.forEach((bullet) => bullet.visible = !show);
        enemyRow1.visible = !show;
    }
    function firstStart(){
        console.log("first start only function")
        startTime = Date.now();
    }
    function follow(mouse, player, windowWidth, playerWidth){
        var temp = mouse.mouseX - playerWidth/2 - 0.5;//width is odd number
        if(temp < 0) temp = 0;
        else if(temp > windowWidth - playerWidth) temp = windowWidth - playerWidth;
        player.playerPos = temp;
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
            if(mediaPlayer.playing) mediaPlayer.stop();
            mediaPlayer.play();

            lastShot = currentTime;
            var component = Qt.createComponent("Bullet.qml");
            var obj = component.createObject(parentObj);
            obj.startX = player.playerPos + player.playerWidth/2 + 0.5 - obj.bulletWidth/2;
            obj.startY = parentObj.height - obj.bulletHeight - player.playerHeight;
            obj.visible = true;
            obj.animationRunning = true;
            parentObj.bulletList.push(obj);
            console.log(parentObj.bulletList.length);
        }
        else{
            console.log("shoting in pause");
        }
    }
    function gameLoop(bullets){
        updateEnemyPosition(bullets);
        bulletCollision(bullets);
        removeBullets(bullets);
    }
    function updateBullets(bullets){
        console.log("use of deprecated function");
        console.log("bullets");
        bullets.forEach((item)=>{
                  item.startY -= Parameters.bulletSpeed;
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
        var t=bullets[index];
        bullets[index].visible = false;
        bullets.splice(index,1);
        t.destroy();
    }
    function removeEnemy(index){
        enemyRow1.model.remove(index, 1);
    }

    function bulletCollision(bullets){
        var bulletX;
        var bulletY;

        //do this with for instead of for each
        for(var i = 0; i < bullets.length; i++){
                    bulletX = bullets[i].startX+bullets[i].bulletWidth/2;
                    bulletY = bullets[i].startY+bullets[i].bulletHeight/2;

                        for(var j = 0; j < enemyRow1.model.count; j++){
                        if(checkBullet(bullets[i], bulletX, bulletY, enemyRow1.model.get(j))){
                                    console.log("enemy collided with bullet");
                                    removeEnemy(j);
                                    removeBullet(bullets,i);
                                    gameData.addSpeed(0.03);
                                    if(enemyRow1.model.count === 0) {
                                        console.log("no enemies left");
                                        gameOver("Wygrałeś, zajęło ci to: " + ((timeOffset+Date.now() - startTime)/1000).toString() + " sekund", bullets);
                                    }
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
        if(Math.abs(enemyX-bulletX) <= 20.5 + bullet.bulletWidth/2 && Math.abs(enemyY-bulletY) <= 10.5 + bullet.bulletHeight/2){
            return true;
        }
        return false;
    }

    function updateEnemyPosition(bullets){
        var changeDir = false;
        var singleEnemy;
        for(var i = 0; i < enemyRow1.model.count; i++){
            singleEnemy = enemyRow1.model.get(i);
            singleEnemy.enemyX = singleEnemy.enemyX + Parameters.enemySpeedX * gameData.getDirection()*gameData.getSpeed();
            //41 is enemy.Width
            if(singleEnemy.enemyX <=0 || singleEnemy.enemyX+enemyWidth > root.width){
                changeDir=true;
            }
        }
        if(changeDir == true){
            gameData.changeDirection();
            lowerEnemies(bullets);
            gameData.addSpeed(0.15);
        }
    }
    function lowerEnemies(bullets){
        var singleEnemy;
        for(var i = 0; i < enemyRow1.model.count; i++){
            singleEnemy = enemyRow1.model.get(i);
            singleEnemy.enemyY = singleEnemy.enemyY + Parameters.enemySpeedY;
            if(singleEnemy.enemyY > failureY){
                gameOver("Koniec gry, przegrałeś", bullets);
            }
        }
    }
    function gameOver(notification, bullets){
        console.log(notification);
        for(var i = 0; i < bullets.length; i++) bullets[i].visible = false;
        endScreen.txt = notification;
//        gameEnded = true;
        endScreen.visible = true;
        mouseTrigger.enabled = false;
    }


}


