#-------------------------------------------------
#
# Project created by QtCreator 2014-11-14T13:40:01
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = prochsv
TEMPLATE = app


SOURCES += main.cpp\
        prochsv.cpp

HEADERS  += prochsv.h

FORMS    += prochsv.ui

DEPENDPATH += .
INCLUDEPATH += .
INCLUDEPATH += /usr/local/include/opencv2
LIBS += -lopencv_core -lopencv_highgui -lopencv_imgproc
