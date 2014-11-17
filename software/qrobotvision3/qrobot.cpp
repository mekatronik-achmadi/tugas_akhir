#include "qrobot.h"
#include "ui_qrobot.h"

int iLowH = 100;
int iHighH = 130;

int iLowS = 70;
int iHighS = 180;

int iLowV = 70;
int iHighV = 180;

uint minArea = 300;
uint maxArea = 35000;

qrobot::qrobot(QWidget *parent) :
    QMainWindow(parent),my_port(0),
    ui(new Ui::qrobot)
{
    ui->setupUi(this);

    my_cam_timer = new QTimer(this);

    QObject::connect(my_cam_timer,SIGNAL(timeout()),this,SLOT(img_proc()));
    my_cam_timer->start(10);

    cam.open(1);

    if ( !cam.isOpened()){
        std::cout << "Cannot open the web cam" << std::endl;
    }

    cv::namedWindow("Control", CV_WINDOW_AUTOSIZE); //create a window called "Control"

    cv::createTrackbar("LowH", "Control", &iLowH, 179); //Hue (0 - 179)
    cv::createTrackbar("HighH", "Control", &iHighH, 179);

    cv::createTrackbar("LowS", "Control", &iLowS, 255); //Saturation (0 - 255)
    cv::createTrackbar("HighS", "Control", &iHighS, 255);

    cv::createTrackbar("LowV", "Control", &iLowV, 255); //Value (0 - 255)
    cv::createTrackbar("HighV", "Control", &iHighV, 255);

    cam.set(CV_CAP_PROP_FRAME_WIDTH, 320);
    cam.set(CV_CAP_PROP_FRAME_HEIGHT, 240);

    this->setWindowTitle("QRobot [Closed]");
    ui->actionOpen->setEnabled(true);
    ui->actionClose->setEnabled(false);
    ui->actionStop->setEnabled(false);
    ui->actionFoward->setEnabled(false);
    ui->actionBackward->setEnabled(false);
    ui->actionRight->setEnabled(false);
    ui->actionLeft->setEnabled(false);


    qrobot::on_actionOpen_triggered();

    my_timer = new QTimer(this);

    QObject::connect(my_timer,SIGNAL(timeout()),this,SLOT(booted()));
    my_timer->start(500);

    my_move = new QTimer(this);

    QObject::connect(my_move,SIGNAL(timeout()),this,SLOT(move_proc()));
    my_move->start(500);

    QObject::connect(my_port,SIGNAL(readyRead()),this,SLOT(next_move()));
}

qrobot::~qrobot()
{
    delete ui;
}

void qrobot::on_actionOpen_triggered()
{
    if(my_port){

        if(my_port->isOpen()){
            my_port->close();
        }

        delete my_port;
        my_port=NULL;
    }

    QString my_device= "/dev/ttyUSB0";
    BaudRateType my_baud = BAUD38400;

    my_port = new QextSerialPort(my_device,QextSerialPort::Polling);
    my_port->setBaudRate(my_baud);
    my_port->setDataBits(DATA_8);
    my_port->setParity(PAR_NONE);
    my_port->setStopBits(STOP_1);
    my_port->setFlowControl(FLOW_OFF);
    my_port->setTimeout(100);

    if(!my_port->open(QIODevice::ReadWrite)){
        delete my_port;
        my_port=NULL;

        QString s="Cannot open device at ";
        s += my_device;
        QMessageBox::critical(this,"Error",s);

        this->setWindowTitle("QRobot [Closed]");
        ui->actionOpen->setEnabled(true);
        ui->actionClose->setEnabled(false);
        ui->actionStop->setEnabled(false);
        ui->actionFoward->setEnabled(false);
        ui->actionBackward->setEnabled(false);
        ui->actionRight->setEnabled(false);
        ui->actionLeft->setEnabled(false);
    }
    else{
        this->setWindowTitle("QRobot [Opened]");
        ui->actionOpen->setEnabled(false);
        ui->actionClose->setEnabled(true);
        ui->actionStop->setEnabled(true);
        ui->actionFoward->setEnabled(true);
        ui->actionBackward->setEnabled(true);
        ui->actionRight->setEnabled(true);
        ui->actionLeft->setEnabled(true);
    }
}

void qrobot::on_actionClose_triggered()
{
    if(my_port){

        if(my_port->isOpen()){
            my_port->close();
        }

        delete my_port;
        my_port=NULL;

        this->setWindowTitle("QRobot [Closed]");
        ui->actionOpen->setEnabled(true);
        ui->actionClose->setEnabled(false);
        ui->actionStop->setEnabled(false);
        ui->actionFoward->setEnabled(false);
        ui->actionBackward->setEnabled(false);
        ui->actionRight->setEnabled(false);
        ui->actionLeft->setEnabled(false);
    }
}

void qrobot::on_actionFoward_triggered()
{
    my_timer->stop();
    QByteArray comdata="foward\n";
    my_port->write(comdata);
    my_timer->start(500);
}

void qrobot::on_actionBackward_triggered()
{
    my_timer->stop();
    QByteArray comdata="backward\n";
    my_port->write(comdata);
    my_timer->start(500);
}

void qrobot::on_actionRight_triggered()
{
    my_timer->stop();
    QByteArray comdata="right\n";
    my_port->write(comdata);
    my_timer->start(500);
}

void qrobot::on_actionLeft_triggered()
{
    my_timer->stop();
    QByteArray comdata="left\n";
    my_port->write(comdata);
    my_timer->start(500);
}

void qrobot::on_actionStop_triggered()
{
    my_timer->stop();
    QByteArray comdata="stop\n";
    my_port->write(comdata);
    my_timer->start(500);
}

void qrobot::booted()
{
    my_timer->stop();
    QByteArray comdata="booted\n";
    my_port->write(comdata);
    my_timer->start(500);
}

void qrobot::img_proc()
{
    cv::Mat imgOriginal;

    bool bSuccess = cam.read(imgOriginal);
    if (!bSuccess) {
      std::cout << "Cannot read a frame from video stream" << std::endl;
    }

    cv::Mat imgsqr= cv::Mat::zeros( imgOriginal.size(), CV_8UC3 );

    cv::Mat imgHSV;
    cv::cvtColor(imgOriginal, imgHSV, cv::COLOR_BGR2HSV);

    cv::Mat imgThresholded;
    cv::inRange(imgHSV, cv::Scalar(iLowH, iLowS, iLowV), cv::Scalar(iHighH, iHighS, iHighV), imgThresholded);
    cv::imshow("Thresholded Image", imgThresholded);

    imgRows = imgThresholded.rows;
    imgCols = imgThresholded.cols;

    imgBiner = cv::Mat(imgRows,imgCols,CV_8U,cv::Scalar(0));

    for(i=0;i<imgRows;i++){
        for(j=0;j<imgCols;j++){
            if(imgThresholded.at<uchar>(i,j)==255){imgBiner.at<uchar>(i,j)=1;}
            else{imgBiner.at<uchar>(i,j)=0;}
        }
    }

    xval=cv::Mat(1,imgCols,CV_16U,cv::Scalar(0));
    for(i=0;i<imgCols;i++){
        xval.at<ushort>(0,i)=0;
        for(j=0;j<imgRows;j++){
            xval.at<ushort>(0,i)=xval.at<ushort>(0,i)+imgBiner.at<uchar>(j,i);
        }
    }

    mArea=cv::Mat(1,1,CV_16U,cv::Scalar(0));
    for(i=0;i<imgCols;i++){
        mArea.at<ushort>(0,0)=mArea.at<ushort>(0,0)+xval.at<ushort>(0,i);
    }
    Area=mArea.at<ushort>(0,0);

    if((Area>minArea)&&(Area<=maxArea)){

        mxSum=cv::Mat(1,1,CV_32F,cv::Scalar(0));
        for(i=0;i<imgCols;i++){
            mxSum.at<float>(0,0)=mxSum.at<float>(0,0)+(i*xval.at<ushort>(0,i));
        }
        xSum=mxSum.at<float>(0,0);

        xcen=xSum/Area;

        yval=cv::Mat(1,imgRows,CV_16U,cv::Scalar(0));
        for(i=0;i<imgRows;i++){
            yval.at<ushort>(0,i)=0;
            for(j=0;j<imgCols;j++){
                yval.at<ushort>(0,i)=yval.at<ushort>(0,i)+imgBiner.at<uchar>(i,j);
            }
        }

        mySum=cv::Mat(1,1,CV_32F,cv::Scalar(0));

        for(i=0;i<imgRows;i++){
            mySum.at<float>(0,0)=mySum.at<float>(0,0)+(i*yval.at<ushort>(0,i));
        }

        ySum=mySum.at<float>(0,0);

        ycen=ySum/Area;

    }

    imgCen = cv::Mat( imgOriginal.size(), CV_8UC3,cv::Scalar(0,0,0));
    vCen=25;
    cv::circle(imgCen,cv::Point(xcen,ycen),vCen,cv::Scalar(0,255,0),2);

    imgRad= cv::Mat( imgOriginal.size(), CV_8UC3,cv::Scalar(0,0,0));
    vRad=45;
    cv::circle(imgRad,cv::Point(imgCols/2,imgRows/2),vRad,cv::Scalar(0,255,0),2);

    cv::imshow("Thresholded Image", imgThresholded);
    imgFinal = imgOriginal + imgRad+imgCen;
    cv::imshow("Final", imgFinal);
}

void qrobot::move_proc(){
    xPos= xcen;
    yPos= xcen;

    xDef= imgCols/2;
    yDef= imgRows/2;

    vDef = 25;
    vArea= Area;
    
    if((Area>minArea)&&(Area<=maxArea)){
      
      std::cout << "xPos= " << xPos << " " << "yPos= " << yPos << " " << "Area= " << vArea << std::endl;
      
      if(xPos<xDef){
	  if((xDef-xPos)>vDef){
	      qrobot::on_actionLeft_triggered();
	      std::cout << "LEFT" << std::endl;
	  }
	  else{
	      qrobot::on_actionFoward_triggered();
	      std::cout << "FOWARD" << std::endl;
	  }
      }
      else if(xPos>xDef){
	  if((xPos-xDef)>vDef){
	      qrobot::on_actionRight_triggered();
	      std::cout << "RIGHT" << std::endl;
	  }
	  else{
	      qrobot::on_actionFoward_triggered();
	      std::cout << "FOWARD" << std::endl;
	  }
      }
      else if(xPos==xDef){
	  qrobot::on_actionFoward_triggered();
	  std::cout << "FOWARD" << std::endl;
      }
    }
    else{
      std::cout << "xPos= " << xPos << " " << "yPos= " << yPos << " " << "Area= " << vArea << std::endl;
      std::cout << "STOP" << std::endl;
    }
}

