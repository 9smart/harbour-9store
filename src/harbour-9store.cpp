#include <QtQuick>
#include <QQuickView>
#include <sailfishapp.h>
#include <QGuiApplication>
#include <QtQml>
#include "shortcutshelper.h"
#include "desktopfilesortmodel.h"
#include "src/MyImage.h"

int main(int argc, char *argv[])
{

    qmlRegisterType<DesktopFileSortModel>("org.coderus.powermenu.desktopfilemodel", 1, 0, "DesktopFileSortModel");
    qmlRegisterType<MyImage>("com.stars.widgets",1,0,"MyImage");
    QGuiApplication *app = SailfishApp::application(argc, argv);
    QScopedPointer<QQuickView> view(SailfishApp::createView());
    //view->setSource(SailfishApp::pathTo("qml/harbour-9store.qml"));
    view->engine()->addImportPath("/usr/share/harbour-9store/qml");
    view->setSource(QUrl("qrc:/qml/harbour-9store.qml"));
    view->show();

    return app->exec();
}
