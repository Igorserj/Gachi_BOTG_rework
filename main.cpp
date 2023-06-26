#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);
//    QQuickWindow::setSceneGraphBackend(QSGRendererInterface::OpenGL);
    QQuickWindow::setGraphicsApi(QSGRendererInterface::Vulkan);
//    QQuickWindow::setSceneGraphBackend(QSGRendererInterface::GLSL);
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
//    QQuickWindow window;
//    QString title = "Gachimuchi: Boss of this gym";
//    window.setTitle(title);
////    window.setResizeMode(QQuickView::SizeRootObjectToView);
////    window.setSource(QUrl("qrc:///main.qml"));
//    window.show();

//    return app.exec();
}
