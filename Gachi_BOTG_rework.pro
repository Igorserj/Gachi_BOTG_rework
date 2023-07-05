#QT += \
#        quick \
#        gui

!qtConfig(vulkan): error("This example requires Qt built with Vulkan support")
QMAKE_CXXFLAGS += -DQT_QUICK_BACKEND=vulkan
QT += qml quick
#QSG_RHI_PREFER_SOFTWARE_RENDERER = 0
#CONFIG += qmltypes
#QML_IMPORT_NAME = VulkanGachi
#QML_IMPORT_MAJOR_VERSION = 1
# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        main.cpp

RESOURCES += qml.qrc

target.path = $$PWD\building
INSTALLS += target

# Additional import path used to resolve QML modules in Qt Creator's code model
#QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
#QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
#qnx: target.path = /tmp/$${TARGET}/bin
#else: unix:!android: target.path = /opt/$${TARGET}/bin
#!isEmpty(target.path): INSTALLS += target
