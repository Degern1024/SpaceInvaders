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

