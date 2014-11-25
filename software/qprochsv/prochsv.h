#ifndef PROCHSV_H
#define PROCHSV_H

#include <QMainWindow>
#include <QMessageBox>
#include <QTimer>
#include <QFileDialog>
#include <QFile>
#include <QTextStream>

#include <iostream>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>

namespace Ui {
class prochsv;
}

class prochsv : public QMainWindow
{
    Q_OBJECT

public:
    explicit prochsv(QWidget *parent = 0);
    ~prochsv();

private slots:

    void img_calc();

    void on_btnFile_clicked();

    void on_btnSave_clicked();

private:
    Ui::prochsv *ui;
    QString imgFile;
    cv::Mat imgOri;
    QTimer* my_timer;

    uint vRow,vCol;

    cv::Mat imgThresholded;
    cv::Mat imgHSV;
    cv::Mat imgShow;
    cv::Mat imgCirc;
    cv::Mat imgSelect;

    cv::Mat imgchan[3];

    uchar vHue,vSat,vVal;

    uint i,j;

    cv::Mat imgBiner;

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
};

#endif // PROCHSV_H
