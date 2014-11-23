#include "ambildata.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    ambildata w;
    w.show();

    return a.exec();
}
