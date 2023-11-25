#include<iostream>
#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QDebug>
#include <QDesktopWidget>
#include <QScreen>
#include <QMessageBox>
#include <QMetaEnum>
#include <cstdlib>
#include <unistd.h>
#include <stdio.h>
#include <string>
#include <time.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>
#include <sys/wait.h>


CShareMemory csm("txh", 128);
CShareMemory csm2("txh2", 128);



MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    setGeometry(400, 250, 542, 390);
    setupDemo();
}




void MainWindow::setupDemo()
{

  setupRealtimeDataDemo(ui->customPlot);
  setWindowTitle("QCustomPlot: "+demoName);
  statusBar()->clearMessage();
  ui->customPlot->replot();
}


void MainWindow::setupRealtimeDataDemo(QCustomPlot *customPlot)
{
  demoName = "Real Time Data Demo";

  customPlot->addGraph(); // blue line
  customPlot->graph(0)->setPen(QPen(QColor(40, 110, 255)));
  customPlot->addGraph(); // red line
  customPlot->graph(1)->setPen(QPen(QColor(255, 110, 40)));

  QSharedPointer<QCPAxisTickerTime> timeTicker(new QCPAxisTickerTime);
  timeTicker->setTimeFormat("%h:%m:%s");
  customPlot->xAxis->setTicker(timeTicker);
  customPlot->axisRect()->setupFullAxesBox();
  customPlot->yAxis->setRange(-60, 60);

  // make left and bottom axes transfer their ranges to right and top axes:
  connect(customPlot->xAxis, SIGNAL(rangeChanged(QCPRange)), customPlot->xAxis2, SLOT(setRange(QCPRange)));
  connect(customPlot->yAxis, SIGNAL(rangeChanged(QCPRange)), customPlot->yAxis2, SLOT(setRange(QCPRange)));

  // setup a timer that repeatedly calls MainWindow::realtimeDataSlot:
  connect(&dataTimer, SIGNAL(timeout()), this, SLOT(realtimeDataSlot()));
  dataTimer.start(0); // Interval 0 means to refresh as fast as possible
  customPlot->setInteractions(QCP::iRangeDrag | QCP::iRangeZoom | QCP::iSelectPlottables);
}



void MainWindow::realtimeDataSlot()
{
//  std::cout<<111<<endl;
  static QTime time(QTime::currentTime());

  double key = time.elapsed()/1000.0;
  static double lastPointKey = 0;

//  std::cout<<'hello'<<std::endl;

  unsigned char buffer[128] = {0};
  unsigned int length = sizeof(buffer);
  csm.GetFromShareMem(buffer,length);
  std::cout<<buffer<<std::endl;
  double y = atof((char*)buffer);

  unsigned char buffer2[128] = {0};
  unsigned int length2 = sizeof(buffer2);
  csm2.GetFromShareMem(buffer2,length2);
  std::cout<<buffer2<<std::endl;
  double y2 = atof((char*)buffer2);

  if (key-lastPointKey > 0.002 )
  {
    // add data to lines:
    double y1 = qSin(key)+qrand()/(double)RAND_MAX*1*qSin(key/0.3843)/*(float)(rand()%100 - 50)/200*/;
//    ui->customPlot->graph(0)->addData(key, y1);
    ui->customPlot->graph(0)->addData(key, y);
    ui->customPlot->graph(1)->addData(key, y2);

    lastPointKey = key;
  }

  ui->customPlot->xAxis->setRange(key, 8, Qt::AlignRight);
  ui->customPlot->replot();


  static double lastFpsKey;
  static int frameCount;
  ++frameCount;
  if (key-lastFpsKey > 2)
  {
    ui->statusBar->showMessage(
          QString("%1 FPS, Total Data points: %2")
          .arg(frameCount/(key-lastFpsKey), 0, 'f', 0)
          .arg(ui->customPlot->graph(0)->data()->size()+ui->customPlot->graph(1)->data()->size())
          , 0);
    lastFpsKey = key;
    frameCount = 0;
  }
}


MainWindow::~MainWindow()
{
    delete ui;
}
