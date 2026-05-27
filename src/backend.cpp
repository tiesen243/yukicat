#include "backend.h"

Backend::Backend(QObject *parent) : QObject(parent), m_message("") {}

QString Backend::message() const { return m_message; }

void Backend::setMessage(const QString &newMessage) {
  if (m_message == newMessage)
    return;

  m_message = newMessage.toUpper();

  emit messageChanged();
}
