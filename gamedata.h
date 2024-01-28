#ifndef GAMEDATA_H
#define GAMEDATA_H

#include <QObject>
#include <QtQml>

class GameData : public QObject
{
    Q_OBJECT
    QML_ELEMENT

//    Q_PROPERTY()
public:
    explicit GameData(QObject *parent = nullptr);
    Q_INVOKABLE int getDirection();
    Q_INVOKABLE void changeDirection();
    Q_INVOKABLE void addSpeed(float v);
    Q_INVOKABLE float getSpeed();
signals:

private:
    int m_direction=1;
    float m_speed_multiplayer=1;
    float m_speed_limit=3;
};

#endif // GAMEDATA_H
