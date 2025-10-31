import QtQuick
import QtQuick.Layouts

import qs.services
import qs.common.widgets

// TODO: MAKE PART OF GLOBAL CONFIG
StyledPopup {
    id: root
    property string formattedDate: Qt.formatDateTime(DateTime.clock.date, "dddd, MMMM dd, yyyy")
    property string formattedTime: DateTime.time
    property string formattedUptime: DateTime.uptime
    property string todosSection: getUpcommingTodos()

    function getUpcommingTodos() {
        const unfinishedTodos = Todo.list.filter(function (item) {
            return !item.done;
        });
        if (unfinishedTodos.length === 0) {
            return "No pending tasks";
        }

        const limitedTodos = unfinishedTodos.slice(0, 5);
        let todoText = limitedTodos.map(function (item, index) {
            return `${index + 1}. ${item.content}`;
        }).join("\n");

        if (unfinishedTodos.length > 5) {
            todoText += `\n... and %1 more`.arg(unfinishedTodos.length - 5);
        }
    }

    ColumnLayout {
        id: columnLayout
        anchors.centerIn: parent
        spacing: 4

        // Date + Time
        Row {
            spacing: 5

            MaterialSymbol {
                anchors.verticalCenter: parent.verticalCenter
                fill: 0
                font.weight: Font.Medium
                text: "calendar_month"
                iconSize: 17
                color: "#c5c6d0"
            }
            StyledText {
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignLeft
                color: "#c5c6d0"
                text: root.formattedDate
                font.weight: Font.Medium
            }
        }

        // Uptime
        RowLayout {
            spacing: 5
            Layout.fillWidth: true
            MaterialSymbol {
                text: "timelapse"
                color: "#c5c6d0"
                font.pixelSize: 17
            }
            StyledText {
                text: "System uptime:"
                color: "#c5c6d0"
            }
            StyledText {
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignRight
                color: "#c5c6d0"
                text: root.formattedUptime
            }
        }

        // Todo
        Column {
            spacing: 0
            Layout.fillWidth: true

            Row {
                spacing: 4
                MaterialSymbol {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "checklist"
                    color: "#c5c6d0"
                    font.pixelSize: 17
                }
                StyledText {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "To Do:"
                    color: "#c5c6d0"
                }
            }
            StyledText {
                horizontalAlignment: Text.AlignLeft
                wrapMode: Text.Wrap
                color: "#c5c6d0"
                text: root.todosSection
            }
        }
    }
}
