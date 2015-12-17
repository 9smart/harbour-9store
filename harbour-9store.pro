# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-9store

CONFIG += sailfishapp

PKGCONFIG += mlite5

service.path = /etc/systemd/system/
service.files += harbour-9store.service \
                harbour-9store.timer

INSTALLS += service

SOURCES += src/harbour-9store.cpp \
    src/desktopfilemodel.cpp \
    src/desktopfilemodelplugin.cpp \
    src/desktopfilesortmodel.cpp \
    src/shortcutshelper.cpp

QT += network quick qml dbus

#SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256



# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/harbour-9store-de.ts \
                translations/harbour-9store-zh_CN.ts

HEADERS += \
    src/desktopfilemodel.h \
    src/desktopfilemodelplugin.h \
    src/desktopfilesortmodel.h \
    src/qmlthreadworker.h \
    src/shortcutshelper.h

OTHER_FILES += \
    qml/pages/AboutPage.qml \
    qml/pages/AppClass.qml \
    qml/pages/AppDetail.qml \
    qml/pages/AppList.qml \
    qml/pages/DownloadPage.qml \
    qml/pages/LoginDialog.qml \
    qml/pages/RegisterPage.qml \
    qml/pages/SearchApp.qml \
    qml/pages/SettingPage.qml \
    qml/pages/ShortcutsPage.qml \
    qml/pages/Signalcenter.qml \
    qml/pages/UserCenter.qml \
    qml/pages/WelcomePage.qml \
    qml/harbour-9store.qml \
    harbour-9store.desktop \
    rpm/harbour-9store.yaml \
    rpm/harbour-9store.changes \
    rpm/harbour-9store.spec \
    translations/harbour-9store.ts \
    translations/harbour-9store-de.ts \
    translations/harbour-9store-zh_CN.ts \
    qml/pages/components/ActivitiesComponent.qml \
    qml/pages/components/AppBackgroundItem.qml \
    qml/pages/components/AppGridComponent.qml \
    qml/pages/components/AppListComponent.qml \
    qml/pages/components/CacheImage.qml \
    qml/pages/components/CanvasComponent.qml \
    qml/pages/components/CommentsComponent.qml \
    qml/pages/components/CurrentOpeartion.qml \
    qml/pages/components/DetailComponent.qml \
    qml/pages/components/ImagePage.qml \
    qml/pages/components/LabelText.qml \
    qml/pages/components/LoginComponent.qml \
    qml/pages/components/MoreButton.qml \
    qml/pages/components/RatingBox.qml \
    qml/pages/components/RealtedComponent.qml \
    qml/pages/components/RegisterComponent.qml \
    qml/pages/components/ScreenshotBox.qml \
    qml/pages/components/SubmitCommentComponent.qml \
    qml/pages/components/TextCollapsible.qml \
    qml/pages/components/WelcomeBoxBackground.qml \
    qml/pages/components/WelcomeFeedItem.qml \
    qml/pages/model/SysInfo.qml \
    qml/pages/model/User.qml \
    qml/js/api.js \
    qml/js/base64.js \
    qml/js/des.js \
    qml/js/login.js \
    qml/js/main.js \
    qml/js/md5.js \
    qml/js/Setting.js \
    qml/cover/CoverPage.qml \
    qml/py/__init__.py \
    qml/py/basedir.py \
    qml/py/image.py \
    qml/py/jobs.py \
    qml/py/mypy.py \
    qml/py/rpms.py \
    qml/py/*.sh \
    harbour-9store.service \
    harbour-9store.timer
