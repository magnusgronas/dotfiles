import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.calculator.components
import qs.common.widgets

Item {
    ColumnLayout {

        TextArea {
            id: textArea
            implicitHeight: 100
            implicitWidth: 400
            text: "Test"
        }

        GridLayout {
            columns: 3

            Repeater {
                id: numbers
                model: ["7", "8", "9", "4", "5", "6", "1", "2", "3", "0", ","]
                NumberButton {
                    buttonText: modelData
                    onClicked: textArea.text += event
                    property string event: {
                        switch (buttonText) {
                            default: return buttonText
                        }
                    }
                }
            }
            IconButton {
                symbol: "backspace"
            }
        }

    }
}
