#pragma once

#include <QObject>
#include <QProcess>
#include <QStringList>

// QML se kisi bhi program ko launch karne ke liye
class Launcher : public QObject {
    Q_OBJECT
public:
    explicit Launcher(QObject *parent = nullptr) : QObject(parent) {}

    // e.g. Launcher.run("python3", ["main.py"], "apps/pyqt")
    //      Launcher.run("./build/rat-clock")
    //      Launcher.run("./node_modules/.bin/qode", ["main.js"], "apps/nodeqt")
    Q_INVOKABLE bool run(const QString &program,
                         const QStringList &args = {},
                         const QString &workdir = {}) {
        auto *p = new QProcess(this);
        p->setProcessChannelMode(QProcess::ForwardedChannels);
        if (!workdir.isEmpty())
            p->setWorkingDirectory(workdir);
        // Child inherits WAYLAND_DISPLAY / XDG_RUNTIME_DIR from the shell
        QObject::connect(p, &QProcess::finished, p, &QObject::deleteLater);
        p->start(program, args);
        if (!p->waitForStarted(3000)) {
            qWarning("Launcher: failed to start %s", qPrintable(program));
            p->deleteLater();
            return false;
        }
        return true;
    }
};
