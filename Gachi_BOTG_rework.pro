!qtConfig(vulkan): error("This example requires Qt built with Vulkan support")
QMAKE_CXXFLAGS += -DQT_QUICK_BACKEND=vulkan
QT += qml quick
#QSG_RHI_PREFER_SOFTWARE_RENDERER = 0
#CONFIG += qmltypes
#QML_IMPORT_NAME = VulkanGachi
#QML_IMPORT_MAJOR_VERSION = 1

SOURCES += \
        main.cpp

RESOURCES += qml.qrc

target.path = $$PWD\building
INSTALLS += target

#QML_IMPORT_PATH =

#QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
#qnx: target.path = /tmp/$${TARGET}/bin
#else: unix:!android: target.path = /opt/$${TARGET}/bin
#!isEmpty(target.path): INSTALLS += target
