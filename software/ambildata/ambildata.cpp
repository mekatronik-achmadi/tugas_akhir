#include "ambildata.h"
#include "ui_ambildata.h"

ambildata::ambildata(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::ambildata)
{
    ui->setupUi(this);


    cam.open(0);
    if ( !cam.isOpened()){
        std::cout << "Cannot open the web cam" << std::endl;
    }

    cam.set(CV_CAP_PROP_FRAME_WIDTH, 320);
    cam.set(CV_CAP_PROP_FRAME_HEIGHT, 240);

    my_cam_timer = new QTimer(this);
    QObject::connect(my_cam_timer,SIGNAL(timeout()),this,SLOT(img_preview()));
    my_cam_timer->start(10);

    vCount = 0;
    ui->barProgress->setValue(10*vCount);

    my_cap_timer = new QTimer(this);
    QObject::connect(my_cap_timer,SIGNAL(timeout()),this,SLOT(img_cap()));
}

ambildata::~ambildata()
{
    delete ui;
}

void ambildata::img_preview(){
    cv::Mat imgOri;
    bool bSuccess = cam.read(imgOri);
    if (!bSuccess) {
      std::cout << "Cannot read a frame from video stream" << std::endl;
      return;
    }
    cv::imshow("Image",imgOri);
}

void ambildata::on_btnStart_clicked()
{
    imgName = ui->txtPreName->text();
    imgInterval = ui->txtInterval->text();
    imgAmount = ui->txtAmount->text();
    if( imgName.isEmpty() || imgInterval.isEmpty() || imgAmount.isEmpty() ){
        QMessageBox::critical(this,"UnFilled Request","Please Enter Prefix Name First or Interval Capture or Amount Capture");
        return;
    }

    ui->txtPreName->setReadOnly(true);
    ui->txtInterval->setReadOnly(true);
    ui->txtAmount->setReadOnly(true);
    ui->btnStart->setEnabled(false);

    vCount=0;
    my_cam_timer->stop();
    my_cap_timer->start(imgInterval.toInt());
}

void ambildata::img_cap(){
    imgName = ui->txtPreName->text() + "_" + QString::number(vCount) + ".png";
    cv::Mat imgOri;
    bool bSuccess = cam.read(imgOri);
    if (!bSuccess) {
      std::cout << "Cannot read a frame from video stream" << std::endl;
      return;
    }
    cv::imshow("Image",imgOri);
    cv::imwrite(imgName.toStdString(),imgOri);

    vCount++;
    ui->barProgress->setValue((100/imgAmount.toInt()*vCount));

    if(vCount==imgAmount.toInt()){
        my_cap_timer->stop();
        my_cam_timer->start(10);
        ui->txtPreName->setReadOnly(false);
        ui->txtInterval->setReadOnly(false);
        ui->txtAmount->setReadOnly(false);
        ui->btnStart->setEnabled(true);
    }
}
