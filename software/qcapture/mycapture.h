#ifndef MYCAPTURE_H
#define MYCAPTURE_H

#include <QMainWindow>
#include <QMessageBox>
#include <QTimer>

#include <iostream>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>

namespace Ui {
class myCapture;
}

class myCapture : public QMainWindow
{
    Q_OBJECT

public:
    explicit myCapture(QWidget *parent = 0);
    ~myCapture();

private:
    Ui::myCapture *ui;
    QTimer* my_cam_timer;
    cv::VideoCapture cam;
    QString cap_stt;
    QString cap_name;
    uint cap_count;


private slots:

    void get_img();

    void on_actionCapture_triggered();
};

#endif // MYCAPTURE_H
