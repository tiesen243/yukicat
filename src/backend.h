#pragma once

#include <QObject>
#include <QString>
#include <QtQml/qqmlregistration.h>

class Backend : public QObject {
  Q_OBJECT
  Q_PROPERTY(
      QString message READ message WRITE setMessage NOTIFY messageChanged)

  QML_ELEMENT

public:
  explicit Backend(QObject *parent = nullptr);

  QString message() const;
  void setMessage(const QString &newMessage);

signals:
  void messageChanged();

private:
  QString m_message;
};
