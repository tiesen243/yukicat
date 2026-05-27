import QtQuick
import QtQuick.Layouts
import QtQuick.Window
import Yukicat 1.0

Window {
  id: panel
  width: 640
  height: 360
  color: "#1e1e2e"
  visible: true

  Backend {
    id: cppBackend
  }

  ColumnLayout {
    anchors.fill: parent
    anchors.margins: 20
    spacing: 15

    Rectangle {
      Layout.fillWidth: true
      Layout.preferredHeight: 40
      color: "#313244"
      radius: 8
      border.color: input.activeFocus ? "#cba6f7" : "transparent"
      border.width: 1

      TextInput {
        id: input
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        verticalAlignment: TextInput.AlignVCenter
        
        color: "white"
        font.pixelSize: 16
        focus: true

        onTextChanged: cppBackend.message = input.text
      }
    }

    Text {
      id: output
      Layout.fillWidth: true
      Layout.fillHeight: true
      
      text: cppBackend.message
      
      color: "#a6e3a1"
      font.pixelSize: 18
      wrapMode: Text.Wrap
    }
  }
}
