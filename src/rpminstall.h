#ifndef RPMINSTALL_H
#define RPMINSTALL_H

#include <QObject>

class RpmInstall : public QObject
{
    Q_OBJECT

    Q_ENUMS(InstallState)
    Q_PROPERTY(InstallState status READ status NOTIFY statusChanged FINAL)
    Q_PROPERTY(qreal progress READ progress NOTIFY progressChanged FINAL)
public:
    explicit RpmInstall();
    ~RpmInstall();

    enum InstallState{
        Error,
        Installing,
        Ready
    };

    InstallState status() const;
    qreal progress() const;
public slots:
    QString errorString() const;
signals:
    void installLocalFile(const QString& fileName);
    void statusChanged(InstallState arg);
    void installFinished();
    void installError();
    void progressChanged(qreal arg);

private slots:
    void installRpm(const QString& fileName);
private:
    QThread *thread;
    InstallState m_status;
    qreal m_progress;
    QString errorInfo;

private:
    void setStatus(InstallState arg);
    void setProgress(qreal arg);
};

#endif // RPMINSTALL_H
