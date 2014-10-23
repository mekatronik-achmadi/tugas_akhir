#include "qrobot.h"
#include "ui_qrobot.h"

qrobot::qrobot(QWidget *parent) :
    QMainWindow(parent),my_port(0),
    ui(new Ui::qrobot)
{
    ui->setupUi(this);

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
