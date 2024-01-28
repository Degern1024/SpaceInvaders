pragma Singleton
import QtQuick

QtObject {
    readonly property int bulletSpeed: 3
    readonly property int gameSpeed: 33
    readonly property int delayShots: 500
    readonly property string temp: "test"
    readonly property real enemySpeedX: 120 * gameSpeed/1000//enemySpeed*gameSpeed/1000
    readonly property real enemySpeedY: 10;
}
