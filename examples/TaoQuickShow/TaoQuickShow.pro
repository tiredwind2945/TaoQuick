TEMPLATE = app
TARGET = TaoQuickShow

QT += core gui qml quick

CONFIG += c++1z qtquickcompiler utf8_source

load(taoVersion)
setTaoVersion()

load(taoBundle)
BundlePath = $$getBundlePath("TaoQuickShow")

#load(taoBuildPath)
#setBuildPath($${TaoQuick_BUILD_TREE}/$${TARGET})

CONFIG(debug,debug|release) {
    DESTDIR = $${TaoQuick_RUN_TREE}/debug
    DEFINES += TAODEBUG
} else {
    DESTDIR = $${TaoQuick_RUN_TREE}/release
}

include($${TaoQuick_3RDPARTY_TREE}/TaoCommon/TaoCommon.pri)
include($${TaoQuick_SOURCE_TREE}/src/TaoQuick/imports/imports.pri)
include(TaoQuickShow.pri)
DEFINES += QMAKE_GEN_TAOMACRO
!build_pass {
    headerContents = \
        "$${LITERAL_HASH}pragma once" \
        "$${LITERAL_HASH}define TaoQuickImport $${TaoQuickImport}" \
        "$${LITERAL_HASH}define TaoQuickImage $${TaoQuickImage}" \
        "$${LITERAL_HASH}define qmlPath $${qmlPath}" \
        "$${LITERAL_HASH}define contentsPath $${contentsPath}" \
        "$${LITERAL_HASH}define imgPath $${imgPath}" \
        "$${LITERAL_HASH}define transDir $${transDir}"

    write_file(taoMacro.h, headerContents)
}


win32:!mingw {
    RC_FILE = App.rc
}
macos {
    ICON = milk.icns
}
