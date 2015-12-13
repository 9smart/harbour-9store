#include "rpminstall.h"
#include <QProcess>
#include <QThread>
#include <QDebug>
#include <QFile>

RpmInstall::RpmInstall() :
    QObject(0)
{
    m_progress = 0;
    m_status = Ready;

    thread = new QThread();
    moveToThread(thread);
    thread->start();

    connect(this, SIGNAL(installLocalFile(QString)), SLOT(installRmp(QString)));
}

RpmInstall::~RpmInstall()
{
    if(thread){
        thread->terminate ();
        thread->wait ();
        delete thread;
    }
}

QString RpmInstall::errorString() const
{
    return errorInfo;
}

void RpmInstall::setProgress(qreal arg)
{
    if (m_progress != arg) {
        m_progress = arg;
        emit progressChanged(arg);
    }
}

qreal RpmInstall::progress() const
{
    return m_progress;
}

void RpmInstall::setStatus(RpmInstall::InstallState arg)
{
    if (m_status != arg) {
        m_status = arg;
        emit statusChanged(arg);
    }
}

RpmInstall::InstallState RpmInstall::status() const
{
    return m_status;
}

void RpmInstall::installRpm(const QString &fileName)
{
    if(m_status==Installing){
        qDebug()<<"RpmInstall: Installing the other package";
        return;
    }

    if(!QFile::exists (fileName)){
        errorInfo = tr("The file does not exist");
        qDebug()<<"RpmInstall:"<<errorInfo;
        emit installError ();
        setStatus (Error);
        return;
    }

    errorInfo = "";
    setStatus (Installing);

    QProcess pkcon;
    QStringList list;
    list<<"install-local"<<"-y"<<fileName;
    pkcon.start("pkcon", list);

    if(pkcon.waitForFinished ()){
		int exit_code = pkcon.exitCode();
        if(exit_code == 0){
            emit installFinished ();
            setStatus (Ready);
        }else{
            errorInfo = "error code is "+QString::number(exit_code);
            qDebug()<<"RpmInstall:"<<errorInfo;
            emit installError ();
            setStatus (Error);
        }
    }else{
        errorInfo = pkcon.errorString ();
        qDebug()<<"RpmInstall:"<<errorInfo;
        emit installError ();
        setStatus (Error);
    }

    pkcon.close ();
}
