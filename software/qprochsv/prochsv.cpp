#include "prochsv.h"
#include "ui_prochsv.h"

int iLowH = 100;
int iHighH = 130;

int iLowS = 70;
int iHighS = 180;

int iLowV = 70;
int iHighV = 130;

prochsv::prochsv(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::prochsv)
{

    ui->setupUi(this);

    my_timer= new QTimer(this);
    QObject::connect(my_timer,SIGNAL(timeout()),this,SLOT(img_calc()));

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

    cv::inRange(imgHSV, cv::Scalar(iLowH, iLowS, iLowV), cv::Scalar(iHighH, iHighS, iHighV), imgThresholded);
    cv::imshow("Thresholded Image", imgThresholded);

    imgBiner = cv::Mat(imgOri.size(),CV_8U,cv::Scalar(0));

    for(i=0;i<vRow;i++){
        for(j=0;j<vCol;j++){
            if(imgThresholded.at<uchar>(i,j)==255){imgBiner.at<uchar>(i,j)=1;}
            else{imgBiner.at<uchar>(i,j)=0;}
        }
    }

    xval=cv::Mat(1,vCol,CV_16U,cv::Scalar(0));
    for(i=0;i<vCol;i++){
        xval.at<ushort>(0,i)=0;
        for(j=0;j<vRow;j++){
            xval.at<ushort>(0,i)=xval.at<ushort>(0,i)+imgBiner.at<uchar>(j,i);
        }
    }

    mArea=cv::Mat(1,1,CV_16U,cv::Scalar(0));
    for(i=0;i<vCol;i++){
        mArea.at<ushort>(0,0)=mArea.at<ushort>(0,0)+xval.at<ushort>(0,i);
    }
    Area=mArea.at<ushort>(0,0);
    ui->txtArea->setText(QString::number(Area));

    mxSum=cv::Mat(1,1,CV_32F,cv::Scalar(0));
    for(i=0;i<vCol;i++){
        mxSum.at<float>(0,0)=mxSum.at<float>(0,0)+(i*xval.at<ushort>(0,i));
    }
    xSum=mxSum.at<float>(0,0);

    xcen=xSum/Area;

    yval=cv::Mat(1,vRow,CV_16U,cv::Scalar(0));
    for(i=0;i<vRow;i++){
        yval.at<ushort>(0,i)=0;
        for(j=0;j<vCol;j++){
            yval.at<ushort>(0,i)=yval.at<ushort>(0,i)+imgBiner.at<uchar>(i,j);
        }
    }

    mySum=cv::Mat(1,1,CV_32F,cv::Scalar(0));

    for(i=0;i<vRow;i++){
        mySum.at<float>(0,0)=mySum.at<float>(0,0)+(i*yval.at<ushort>(0,i));
    }

    ySum=mySum.at<float>(0,0);

    ycen=ySum/Area;

    imgCen = cv::Mat( imgOri.size(), CV_8UC3,cv::Scalar(0,0,0));
    vCen=25;
    cv::circle(imgCen,cv::Point(xcen,ycen),vCen,cv::Scalar(0,255,0),2);

    imgRad= cv::Mat( imgOri.size(), CV_8UC3,cv::Scalar(0,0,0));
    vRad=45;
    cv::circle(imgRad,cv::Point(vCol/2,vRow/2),vRad,cv::Scalar(0,255,0),2);

    imgFinal = imgOri + imgRad+imgCen;
    cv::imshow("Final", imgFinal);

}

void prochsv::on_btnFile_clicked()
{
    if(my_timer->isActive()){
        my_timer->stop();
    }

    imgFile = QFileDialog::getOpenFileName(this,"Select Picture","Portable Network Graphic (*.png)");

    if(imgFile.isEmpty()){
        return;
    }

    ui->txtFile->setText(imgFile);

    imgOri = cv::imread(imgFile.toStdString());

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

    my_timer->start(100);

}

void prochsv::on_btnSave_clicked()
{
    if(my_timer->isActive()){
        my_timer->stop();
    }

    if(imgFile.isEmpty()){
        return;
    }

    QString filesave= QFileDialog::getSaveFileName(this,"Select Existing Text File","Text File (*.txt)");
    ui->txtFileSave->setText(filesave);

    QFile filestream(filesave);
    if(!filestream.open(QFile::WriteOnly|QFile::Text|QFile::Append)){
        QMessageBox::critical(this,"Failed","File failed to save");
        return;
    }

    QTextStream filewrite(&filestream);

    //the format is ImgFile Smin Smax Vmin Vmax Area

    QString strData;
    strData += imgFile + "\t";
    strData += QString::number(iLowS) + "\t";
    strData += QString::number(iHighS) + "\t";
    strData += QString::number(iLowV)  + "\t";
    strData += QString::number(iHighV) + "\t";
    strData += QString::number(Area) + "\n";

    filewrite << strData ;

    filestream.flush();
    filestream.close();

    cv::Mat imgSave;
    imgSave = imgThresholded;

    QString imgSaveName=imgFile + "_thres.png";
    cv::imwrite(imgSaveName.toStdString(),imgSave);

    my_timer->start(100);
}
