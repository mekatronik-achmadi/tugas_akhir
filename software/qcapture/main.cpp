#include "mycapture.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    myCapture w;
    w.show();

    return a.exec();
}
