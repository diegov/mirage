import QtQuick 2.7
import QtQuick.Layouts 1.3
import "../Base"

Column {
    id: accountDelegate
    width: parent.width

    property var user: Backend.users.get(userId)

    property string roomCategoriesListUserId: userId
    property bool expanded: true

    HRowLayout {
        width: parent.width
        height: childrenRect.height
        id: row

        HAvatar {
            id: avatar
            name: user.displayName.value
        }

        HColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            HLabel {
                id: accountLabel
                text: user.displayName.value
                elide: HLabel.ElideRight
                maximumLineCount: 1
                Layout.fillWidth: true
                leftPadding: 6
                rightPadding: leftPadding
            }

            HTextField {
                id: statusEdit
                text: user.statusMessage || ""
                placeholderText: qsTr("Set status message")
                font.pixelSize: HStyle.fontSize.small
                background: null

                padding: 0
                leftPadding: accountLabel.leftPadding
                rightPadding: leftPadding
                Layout.fillWidth: true

                onEditingFinished: {
                    //Backend.setStatusMessage(userId, text)
                    pageStack.forceActiveFocus()
                }
            }
        }

        ExpandButton {
            expandableItem: accountDelegate
            Layout.preferredHeight: row.height
        }
    }

    RoomCategoriesList {
        id: roomCategoriesList
        interactive: false  // no scrolling
        visible: height > 0
        width: parent.width
        height: childrenRect.height * (accountDelegate.expanded ? 1 : 0)
        clip: heightAnimation.running

        userId: roomCategoriesListUserId

        Behavior on height {
            NumberAnimation { id: heightAnimation; duration: 100 }
        }
    }
}
