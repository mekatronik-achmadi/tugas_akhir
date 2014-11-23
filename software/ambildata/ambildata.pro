#-------------------------------------------------
#
# Project created by QtCreator 2014-11-23T13:09:06
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = ambildata
TEMPLATE = app


SOURCES += main.cpp\
        ambildata.cpp

HEADERS  += ambildata.h

FORMS    += ambildata.ui

INCLUDEPATH += .
INCLUDEPATH += /usr/local/include/opencv2
LIBS += -lopencv_core -lopencv_highgui -lopencv_imgproc
