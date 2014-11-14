#include "qrobot.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    qrobot w;
    w.show();

    return a.exec();
}
