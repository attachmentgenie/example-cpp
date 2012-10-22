#include <string>
#include <QApplication>
#include <QLabel>
#include "example.h"

int main(int argc, char *argv[])
{
	std::string strHelloName = hello("gui");

    QApplication app(argc, argv);
    QLabel *label = new QLabel(QString::fromStdString(strHelloName));
    label->show();
    return app.exec();
}
