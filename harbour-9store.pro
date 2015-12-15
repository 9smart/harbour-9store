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

SOURCES += src/harbour-9store.cpp \
    src/desktopfilemodel.cpp \
    src/desktopfilemodelplugin.cpp \
    src/desktopfilesortmodel.cpp \
    src/shortcutshelper.cpp

QT += network quick qml dbus

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

OTHER_FILES += \
    qml/cover/CoverPage.qml \
    qml/pages/*.qml \
    qml/js/main.js \
    qml/js/base64.js \
    qml/js/md5.js \
    qml/js/login.js \
    qml/img/star_active.png\
    qml/img/star_inactive.png\
    translations/*.ts \
    qml/pages/AboutPage.qml \
    qml/pages/components/ScreenshotBox.qml \
    qml/pages/qmlprovate.js \
    qml/pages/components/TextCollapsible.qml\
    qml/py/*.py \
    qml/pages/components/*.qml \
    qml/pages/components/RatingBox.qml \
    qml/pages/components/Progress.qml \
    qml/pages/components/ImagePage.qml \
    qml/pages/WelcomePage.qml \
    qml/pages/UserCenter.qml \
    qml/js/base64.js \
    qml/js/des.js \
    qml/js/main.js \
    qml/js/md5.js \
    qml/js/api.js \
    qml/pages/Signalcenter.qml \
    qml/js/han2pin.js \
    qml/img/notifactionbar.png \
    qml/pages/components/WelcomeBoxBackground.qml \
    qml/pages/components/MoreButton.qml \
    qml/pages/components/WelcomeFeedItem.qml \
    qml/img/harbour-9smart.png \
    qml/img/App_icon_Error.svg \
    qml/img/App_icon_Loading.svg \
    qml/img/Score_1.* \
    qml/img/Score_2.* \
    qml/img/Score_3.* \
    rpm/harbour-9store.changes \
    rpm/harbour-9store.yaml \
    rpm/harbour-9store.spec \
    harbour-9store.desktop \
    qml/harbour-9store.qml \
    qml/pages/DownloadPage.qml \
    qml/pages/components/CacheImage.qml \
    qml/pages/SettingPage.qml \
    qml/pages/components/AppBackgroundItem.qml \
    qml/img/HeadPortrait_Mask_x2.bmp \
    qml/img/splash.png \
    qml/py/__init__.py \
    qml/py/basedir.py \
    qml/pages/components/LabelText.qml \
    qml/pages/components/CurrentOpeartion.qml \
    qml/pages/model/SysInfo.qml \
    qml/pages/model/User.qml
    qml/pages/components/LoginComponent.qml \
    qml/pages/components/RegisterComponent.qml \

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
