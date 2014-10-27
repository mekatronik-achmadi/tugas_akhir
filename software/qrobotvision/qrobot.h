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

private:
    Ui::qrobot *ui;
    QextSerialPort *my_port;
    QTimer* my_cam_timer;
    QTimer* my_timer;
    cv::VideoCapture cam;
};

#endif // QROBOT_H
