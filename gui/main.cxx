#include <QApplication>
#include <QLabel>
#include "example.h"

int main(int argc, char *argv[])
{
    double outputValue = mysqrt(5);

    QApplication app(argc, argv);
    QLabel *label = new QLabel("Hello World!");
    label->show();
    return app.exec();
}
