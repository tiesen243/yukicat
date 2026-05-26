import QtQuick
import QtQuick.Controls

Window {
  id: mainWindow
  width: 400
  height: 150
  visible: true
  
  flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint

  x: (Screen.width - width) / 2
  y: (Screen.height - height) / 3

  color: "transparent"

  Rectangle {
    anchors.fill: parent
    color: "#1e1e2e"
    radius: 15
    border.color: "#cba6f7"
    border.width: 2

    Text {
      anchors.centerIn: parent
      text: "Hello World"
      color: "#ffffff"
      font.pointSize: 24
      font.bold: true
    }

    Shortcut {
      sequence: "Escape"
      onActivated: Qt.quit()
    }
  }
}
