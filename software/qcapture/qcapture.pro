#-------------------------------------------------
#
# Project created by QtCreator 2014-11-14T09:17:11
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = qcapture
TEMPLATE = app


SOURCES += main.cpp\
        mycapture.cpp

HEADERS  += mycapture.h

FORMS    += mycapture.ui

DEPENDPATH += .
INCLUDEPATH += .
INCLUDEPATH += /usr/local/include/opencv2
LIBS += -lopencv_core -lopencv_highgui -lopencv_imgproc
