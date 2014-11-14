#include "mycapture.h"
#include "ui_mycapture.h"

myCapture::myCapture(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::myCapture)
{
    ui->setupUi(this);

    my_cam_timer = new QTimer(this);

    QObject::connect(my_cam_timer,SIGNAL(timeout()),this,SLOT(get_img()));
    my_cam_timer->start(10);

    cap_stt="NO";
    cap_count=0;
    cap_name = "imgcap_" + QString::number(cap_count) + ".png";
    this->setWindowTitle(cap_name);

    cam.open(0);

    if ( !cam.isOpened()){
        std::cout << "Cannot open the web cam" << std::endl;
    }

    cam.set(CV_CAP_PROP_FRAME_WIDTH, 320);
    cam.set(CV_CAP_PROP_FRAME_HEIGHT, 240);
}

myCapture::~myCapture()
{
    delete ui;
}

void myCapture::get_img()
{
    cv::Mat imgOriginal;

    bool bSuccess = cam.read(imgOriginal);
    if (!bSuccess) {
      std::cout << "Cannot read a frame from video stream" << std::endl;
    }

    cv::imshow("Image",imgOriginal);

    if(cap_stt=="YES"){
        cap_stt="NO";

        cap_name = "imgcap_" + QString::number(cap_count) + ".png";

        const std::string str_name= cap_name.toStdString();
        cv::imwrite(str_name,imgOriginal);
        std::cout << "saved as " << str_name << std::endl;

        cap_count++;
        cap_name = "imgcap_" + QString::number(cap_count) + ".png";
        this->setWindowTitle(cap_name);
    }

}

void myCapture::on_actionCapture_triggered()
{
    cap_stt="YES";
}
