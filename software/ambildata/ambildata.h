#ifndef AMBILDATA_H
#define AMBILDATA_H

#include <QDialog>
#include <QMessageBox>
#include <QTimer>

#include <iostream>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>

namespace Ui {
class ambildata;
}

class ambildata : public QDialog
{
    Q_OBJECT

public:
    explicit ambildata(QWidget *parent = 0);
    ~ambildata();

private:
    Ui::ambildata *ui;

    QTimer* my_cam_timer;
    QTimer* my_cap_timer;
    cv::VideoCapture cam;
    int vCount;
    QString imgName;
    QString imgInterval;
    QString imgAmount;

private slots:
    void img_preview();
    void img_cap();
    void on_btnStart_clicked();
};

#endif // AMBILDATA_H
