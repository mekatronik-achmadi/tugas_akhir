#ifndef QROBOT_H
#define QROBOT_H

#include <QMainWindow>
#include <QMessageBox>
#include <QTimer>
#include "SerialPortLibs/qextserialport.h"
#include "SerialPortLibs/qextserialenumerator.h"

#include <iostream>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>

namespace Ui {
class qrobot;
}

class qrobot : public QMainWindow
{
    Q_OBJECT

public:
    explicit qrobot(QWidget *parent = 0);
    ~qrobot();

private slots:
    void on_actionOpen_triggered();

    void on_actionClose_triggered();

    void on_actionFoward_triggered();

    void on_actionBackward_triggered();

    void on_actionRight_triggered();

    void on_actionLeft_triggered();

    void on_actionStop_triggered();

    void booted();

    void img_proc();

    void move_proc();

private:
    Ui::qrobot *ui;
    QextSerialPort *my_port;
    QTimer* my_cam_timer;
    QTimer* my_timer;

    cv::VideoCapture cam;

    uint imgRows;
    uint imgCols;

    uint i,j;

    cv::Mat imgBiner;

    uint sqr;
    cv::Mat mArea;
    uint Area;

    cv::Mat xval;
    cv::Mat mxSum;
    float xSum;
    uint xcen;

    cv::Mat yval;
    cv::Mat mySum;
    float ySum;
    uint ycen;

    cv::Mat imgRad;
    uint vRad;

    cv::Mat imgCen;
    uint vCen;

    cv::Mat imgFinal;

    QTimer* my_move;
    uint xPos,yPos;
    uint xDef,yDef;
    uint vDif,vDef;
    uint vArea;
};

#endif // QROBOT_H
