#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QTimer>
#include "qcustomplot.h"
#include<share_memory.h>

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

    void setupDemo();
    void setupRealtimeDataDemo(QCustomPlot *customPlot);


private slots:
  void realtimeDataSlot();



private:
    Ui::MainWindow *ui;
    QString demoName;
    QTimer dataTimer;

};

#endif // MAINWINDOW_H
