#include "prochsv.h"
#include "ui_prochsv.h"

int iLowH = 0;
int iHighH = 5;

int iLowS = 150;
int iHighS = 180;

int iLowV = 150;
int iHighV = 180;

prochsv::prochsv(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::prochsv)
{


    ui->setupUi(this);
    imgOri = cv::imread("imgcap_9.png");

    cv::Mat imgHSV;
    cv::cvtColor(imgOri,imgHSV,cv::COLOR_BGR2HSV);

    vRow= imgOri.rows;
    vCol= imgOri.cols;

    ui->xVal->setMaximum(vCol);
    ui->yVal->setMaximum(vRow);

    cv::split(imgHSV,imgchan);

    cv::imshow("Hue",imgchan[0]);
    cv::imshow("Sat",imgchan[1]);
    cv::imshow("Val",imgchan[2]);

    cv::imshow("Ori",imgOri);

    my_timer= new QTimer(this);
    QObject::connect(my_timer,SIGNAL(timeout()),this,SLOT(img_calc()));
    my_timer->start(100);

    cv::namedWindow("Control", CV_WINDOW_AUTOSIZE); //create a window called "Control"

    cv::createTrackbar("LowH", "Control", &iLowH, 179); //Hue (0 - 179)
    cv::createTrackbar("HighH", "Control", &iHighH, 179);

    cv::createTrackbar("LowS", "Control", &iLowS, 255); //Saturation (0 - 255)
    cv::createTrackbar("HighS", "Control", &iHighS, 255);

    cv::createTrackbar("LowV", "Control", &iLowV, 255); //Value (0 - 255)
    cv::createTrackbar("HighV", "Control", &iHighV, 255);

}

prochsv::~prochsv()
{
    delete ui;
}

void prochsv::img_calc()
{
    imgCirc= cv::Mat::zeros(imgOri.size(),CV_8UC3);
    cv::circle(imgCirc,cv::Point(ui->xVal->value(),ui->yVal->value()),5,cv::Scalar(255,0,0),2);
    imgSelect= cv::Mat::zeros(imgOri.size(),CV_8UC3);
    imgSelect=imgOri + imgCirc;
    cv::imshow("Selected",imgSelect);

    vHue = imgchan[0].at<uchar>(ui->yVal->value(),ui->xVal->value());
    vSat = imgchan[1].at<uchar>(ui->yVal->value(),ui->xVal->value());
    vVal = imgchan[2].at<uchar>(ui->yVal->value(),ui->xVal->value());

    ui->txtHue->setText(QString::number(vHue));
    ui->txtSat->setText(QString::number(vSat));
    ui->txtVal->setText(QString::number(vVal));

    cv::cvtColor(imgOri, imgHSV, cv::COLOR_BGR2HSV);

    cv::Mat imgThresholded;
    cv::inRange(imgHSV, cv::Scalar(iLowH, iLowS, iLowV), cv::Scalar(iHighH, iHighS, iHighV), imgThresholded);
    cv::imshow("Thresholded Image", imgThresholded);
}
