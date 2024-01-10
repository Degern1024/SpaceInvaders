#include <QGuiApplication>
#include <QQmlApplicationEngine>


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

//    qmlRegisterSingletonType(QStringLiteral("Parameters.qml"), "Parameters", 1,0,"Parameters");

    QQmlApplicationEngine engine;
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("SpaceInvaders", "Main");

    return app.exec();
}
