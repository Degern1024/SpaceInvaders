#include "gamedata.h"

GameData::GameData(QObject *parent)
    : QObject{parent}
{

}
void GameData::changeDirection(){
    m_direction*=-1;
}
int GameData::getDirection(){
    return m_direction;
}
void GameData::addSpeed(float v){
    m_speed_multiplayer += v;
    if(m_speed_limit < m_speed_multiplayer) m_speed_multiplayer = m_speed_limit;
}
float GameData::getSpeed(){
    return m_speed_multiplayer;
}
