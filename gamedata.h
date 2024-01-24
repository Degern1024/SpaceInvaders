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

signals:

private:
    int m_direction=1024;
};

#endif // GAMEDATA_H
