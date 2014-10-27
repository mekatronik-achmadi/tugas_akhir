#include "qrobot.h"
#include "ui_qrobot.h"

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
    cv::Mat imgThresholded2;
    cv::inRange(imgHSV, cv::Scalar(iLowH, iLowS, iLowV), cv::Scalar(iHighH, iHighS, iHighV), imgThresholded);
    cv::imshow("Thresholded Image", imgThresholded);
    imgThresholded2=imgThresholded;

    cv::erode(imgThresholded, imgThresholded, cv::getStructuringElement(cv::MORPH_ELLIPSE, cv::Size(5, 5)) );
    cv::dilate( imgThresholded, imgThresholded, cv::getStructuringElement(cv::MORPH_ELLIPSE, cv::Size(5, 5)) );

    cv::dilate( imgThresholded, imgThresholded, cv::getStructuringElement(cv::MORPH_ELLIPSE, cv::Size(5, 5)) );
    cv::erode(imgThresholded, imgThresholded, cv::getStructuringElement(cv::MORPH_ELLIPSE, cv::Size(5, 5)) );

    cv::Moments oMoments =cv::moments(imgThresholded);

    double dM01 = oMoments.m01;
    double dM10 = oMoments.m10;
    double dArea = oMoments.m00;

    if(dArea > 10000){

        int posX = dM10 / dArea;
        int posY = dM01 / dArea;

        cv::vector<cv::vector<cv::Point> > contours;
        cv::vector<cv::Vec4i> hierarchy;

        cv::findContours( imgThresholded2, contours, hierarchy, CV_RETR_TREE, CV_CHAIN_APPROX_SIMPLE, cv::Point(0, 0) );

        int Area = contourArea(contours[0]);

        int s = sqrt(Area);

        int posX1=(posX-(s/2))-5;
        int posY1=(posY-(s/2))-5;

        std::cout << "posX =" << posX << " posY=" << posY << std::endl;
        std::cout << "dArea =" << dArea << " s =" << s << " posX1 =" << posX1 << " posY1=" << posY1 << std::endl;
        std::cout << "Area=" << Area << std::endl;

        cv::Rect imgrect(posX1,posY1,s+10,s+10);
        cv::rectangle(imgsqr,imgrect,cv::Scalar(0,0,255),2);

    }

    cv::Mat imgFinal;

    cv::imshow("Thresholded Image 2", imgThresholded2);
    imgFinal = imgOriginal + imgsqr;
//     imgFinal = imgOriginal;
    cv::imshow("Final", imgFinal);
}
