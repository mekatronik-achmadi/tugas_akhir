#-------------------------------------------------
#
# Project created by QtCreator 2014-10-21T09:39:07
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = qrobot
TEMPLATE = app


SOURCES += main.cpp\
        qrobot.cpp \
    SerialPortLibs/posix_qextserialport.cpp \
    SerialPortLibs/qextserialbase.cpp \
    SerialPortLibs/qextserialenumerator.cpp \
    SerialPortLibs/qextserialport.cpp

HEADERS  += qrobot.h \
    SerialPortLibs/posix_qextserialport.h \
    SerialPortLibs/qextserialbase.h \
    SerialPortLibs/qextserialenumerator.h \
    SerialPortLibs/qextserialport.h

FORMS    += qrobot.ui

DEFINES += _TTY_POSIX_
