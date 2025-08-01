import QtQml 2.15
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs

import org.kde.kirigami as Kirigami
import org.kde.iconthemes as KIconThemes
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.kcmutils as KCM

KCM.SimpleKCM {
    property alias cfg_scale: scale.value
    property alias cfg_layout: layout.currentIndex
    property alias cfg_transparency: transparency.checked
    property alias cfg_showKDEConnect: showKDEConnect.checked
    property alias cfg_showNightLight: showNightLight.checked
    property alias cfg_showColorSwitcher: showColorSwitcher.checked
    property alias cfg_showVolume: showVolume.checked
    property alias cfg_showBrightness: showBrightness.checked
    property alias cfg_showMediaPlayer: showMediaPlayer.checked
    property alias cfg_showAvatar: showAvatar.checked
    property alias cfg_showBattery: showBattery.checked
    property alias cfg_showSessionActions: showSessionActions.checked
    property alias cfg_showScreenshot: showScreenshot.checked
    property alias cfg_showCmd1: showCmd1.checked
    property alias cfg_showCmd2: showCmd2.checked
    property alias cfg_showPercentage: showPercentage.checked
    property alias cfg_mainIconName: mainIconName.icon.name
    property alias cfg_cmdIcon1: cmdIcon1.icon.name
    property alias cfg_cmdRun1: cmdRun1.text
    property alias cfg_cmdTitle1: cmdTitle1.text
    property alias cfg_cmdIcon2: cmdIcon2.icon.name
    property alias cfg_cmdRun2: cmdRun2.text
    property alias cfg_cmdTitle2: cmdTitle2.text

    property alias cfg_transparencyLevel: transparencyLevel.value
    property alias cfg_showBorders: showBorders.checked

    property alias cfg_volume_widget_flat: volume_widget_flat.checked
    property alias cfg_volume_widget_title: volume_widget_title.checked
    property alias cfg_volume_widget_thin: volume_widget_thin.checked

    property alias cfg_brightness_widget_flat: brightness_widget_flat.checked
    property alias cfg_brightness_widget_title: brightness_widget_title.checked
    property alias cfg_brightness_widget_thin: brightness_widget_thin.checked

    property alias cfg_animations: animations.checked

    property alias cfg_useSystemColorsOnToggles: useSystemColorsOnToggles.checked
    property alias cfg_useSystemColorsOnSliders: useSystemColorsOnSliders.checked
    property color cfg_toggleButtonsColor: Plasmoid.configuration.toggleButtonsColor
    property color cfg_slidersColor: Plasmoid.configuration.slidersColor

    property int numChecked: (layout.currentIndex == 1 ? showKDEConnect.checked : showColorSwitcher.checked) + showNightLight.checked + showCmd1.checked + showCmd2.checked + showScreenshot.checked
    property int maxNum: layout.currentIndex == 0 && !showBrightness.checked ? 4 :  layout.currentIndex == 2 ? 6 : 2 


    function toggleLayoutDefaults(index) {                    
        showNightLight.checked = true;
        showColorSwitcher.checked = true;
        showBrightness.checked = true;
        showKDEConnect.checked = true;

        showScreenshot.checked = false;
        showCmd1.checked = false;
        showCmd2.checked = false;

        volume_widget_flat.checked = false;
        volume_widget_title.checked = true;
        volume_widget_thin.checked = false;

        brightness_widget_flat.checked = false;
        brightness_widget_title.checked = true;
        brightness_widget_thin.checked = false;

        switch (index) {
            case 0:
                showColorSwitcher.enabled = true;
                showKDEConnect.enabled = false;
                break;
            case 1:
                showColorSwitcher.enabled = false;
                showKDEConnect.enabled = true;
                maxNum = 2;
                break;
            case 2:
                volume_widget_flat.checked = true;
                volume_widget_title.checked = false;
                volume_widget_thin.checked = true;

                brightness_widget_flat.checked = true;
                brightness_widget_title.checked = false;
                brightness_widget_thin.checked = true;
                break;
        }
    }

    // Used to select icons
    KIconThemes.IconDialog {
        id: iconDialog
        property var iconObj
        onIconNameChanged: iconObj.name = iconName
    }

    Kirigami.FormLayout {
        Button {
            id: mainIconName
            Kirigami.FormData.label: i18n("Icon:")
            icon.width: Kirigami.Units.iconSizes.medium
            icon.height: icon.width
            onClicked: {
                iconDialog.open()
                iconDialog.iconObj= mainIconName.icon
            }
        }

        SpinBox {
            id: scale
            Kirigami.FormData.label: i18n("Scale:")
            from: 0; to: 1000
        }
        Item {
            Kirigami.FormData.isSection: true
        }
        ComboBox {
            id: layout
            Kirigami.FormData.label: i18n("Layout:")
            model: [
                i18n("KDE Control Station (Default)"),
                i18n("Control Center"),
                i18n("Flat")
            ]
            onActivated: toggleLayoutDefaults(index)
        }

        Item {
            Kirigami.FormData.isSection: true
        }

        CheckBox {
            id: showPercentage
            Kirigami.FormData.label: i18n("General:")
            text: i18n("Show volume/brightness percentage")
        }
        CheckBox {
            id: animations
            text: i18n("Enable animations (Experimental)")
        }
        CheckBox {
            id: transparency
            text: i18n("Enable transparency")
        }
        Slider {
            id: transparencyLevel
            visible: transparency.checked
            Kirigami.FormData.label: i18n("Transparency level of widgets (%1%):", 100-value)
            from: 100
            value: 40
            to: 0
            stepSize: 1
            Layout.fillWidth: true
        }

        CheckBox {
            id: showBorders
            text: i18n("Show borders aroud components")
        }

        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Toggle buttons and sliders")
        }

        CheckBox {
            id: useSystemColorsOnToggles
            Kirigami.FormData.label: i18n("Highlight color")
            text: i18n('Use System highlight color on toggle buttons')
           // enabled: !checked && numChecked < maxNum || checked
        }

        Button {
            id: toggleButtonColorButton
            visible: !useSystemColorsOnToggles.checked
            width: Kirigami.Units.iconSizes.small
            height: width
            Kirigami.FormData.label: i18n("Toggle buttons color")
            Rectangle {
                anchors.centerIn: parent
                anchors.fill: parent
                radius: 10
                color: cfg_toggleButtonsColor
            }
            onPressed: toggleButtonsColorDialog.visible ? toggleButtonsColorDialog.close() : toggleButtonsColorDialog.open()
            ColorDialog {
                id: toggleButtonsColorDialog
                title: i18n("Please choose a color")
                onAccepted: {
                    cfg_toggleButtonsColor = toggleButtonsColorDialog.selectedColor;
                }
            }
        }

        CheckBox {
            id: useSystemColorsOnSliders
            text: i18n('Use System highlight color on sliders')
           // enabled: !checked && numChecked < maxNum || checked
        }

        Button {
            id: slidersColorButton
            visible: !useSystemColorsOnSliders.checked
            width: Kirigami.Units.iconSizes.small
            height: width
            Kirigami.FormData.label: i18n("Sliders color")
            Rectangle {
                anchors.centerIn: parent
                anchors.fill: parent
                radius: 10
                color: cfg_slidersColor
            }
            onPressed: slidersColorDialog.visible ? slidersColorDialog.close() : slidersColorDialog.open()
            ColorDialog {
                id: slidersColorDialog
                title: i18n("Please choose a color")
                onAccepted: {
                    cfg_slidersColor = slidersColorDialog.selectedColor;
                }
            }
        }

        Item {
            Kirigami.FormData.isSection: true
        }

        CheckBox {
            id: showKDEConnect
            Kirigami.FormData.label: i18n("Show quick toggle buttons:")
            text: i18n('KDE Connect')
           // enabled: !checked && numChecked < maxNum || checked
        }
        CheckBox {
            id: showNightLight
            text: i18n('Night Light')
            enabled: !checked && numChecked < maxNum || checked
        }
        CheckBox {
            id: showColorSwitcher
            text: i18n('Color Scheme Switcher')
            enabled: !checked && numChecked < maxNum || checked
        }
        CheckBox {
            id: showScreenshot
            text: i18n('Screenshot Button')
            enabled: !checked && numChecked < maxNum || checked
        }
        CheckBox {
            id: showCmd1
            text: i18n('Custom Command Block 1')
            enabled: !checked && numChecked < maxNum || checked
        }
        Kirigami.FormLayout {
            visible: showCmd1.checked
            TextField {
                id: cmdTitle1
                Kirigami.FormData.label: i18n("Name:")
            }
            TextField {
                id: cmdRun1
                Kirigami.FormData.label: i18n("Command:")
            }
            Button {
                id: cmdIcon1
                Kirigami.FormData.label: i18n("Icon:")
                icon.width: Kirigami.Units.iconSizes.medium
                icon.height: icon.width
                onClicked: {
                    iconDialog.open()
                    iconDialog.iconObj= cmdIcon1.icon
                }
            }
        }
        CheckBox {
            id: showCmd2
            text: i18n('Custom Command Block 2')
            enabled: !checked && numChecked < maxNum || checked
        }
        Kirigami.FormLayout {
            visible: showCmd2.checked
            TextField {
                id: cmdTitle2
                Kirigami.FormData.label: i18n("Name:")
            }
            TextField {
                id: cmdRun2
                Kirigami.FormData.label: i18n("Command:")
            }
            Button {
                id: cmdIcon2
                Kirigami.FormData.label: i18n("Icon:")
                icon.width: Kirigami.Units.iconSizes.medium
                icon.height: icon.width
                onClicked: {
                    iconDialog.open()
                    iconDialog.iconObj= cmdIcon2.icon
                }
            }
        }
        Label {
            text: i18n(`You can enable only ${maxNum} toggle buttons at a time.`)
            font: Kirigami.Theme.smallestFont
            color: Kirigami.Theme.neutralTextColor
            Layout.fillWidth: true
            wrapMode: Text.Wrap
        }

        Item {
            Kirigami.FormData.isSection: true
        }

        CheckBox {
            id: showVolume
            Kirigami.FormData.label: i18n("Show other components:")
            text: i18n('Volume Control')
        }
        Kirigami.FormLayout {
            visible: showVolume.checked
            RowLayout {
                CheckBox {
                    id: volume_widget_flat
                    text: i18n('Flat component')
                }
                CheckBox {
                    id: volume_widget_title
                    text: i18n('Show volume title')
                }
                CheckBox {
                    id: volume_widget_thin
                    text: i18n('Thin slider')
                }
            }
        }
        CheckBox {
            id: showBrightness
            text: i18n('Brightness Control')
        }
        Kirigami.FormLayout {
            visible: showBrightness.checked
            RowLayout {
                CheckBox {
                    id: brightness_widget_flat
                    text: i18n('Flat component')
                }
                CheckBox {
                    id: brightness_widget_title
                    text: i18n('Show brightness title')
                }
                CheckBox {
                    id: brightness_widget_thin
                    text: i18n('Thin slider')
                }
            }
        }
        CheckBox {
            id: showMediaPlayer
            text: i18n('Media Player')
        }
         CheckBox {
            id: showAvatar
            text: i18n('User Avatar')
        }
        CheckBox {
            id: showBattery
            text: i18n('Battery')
        }
        CheckBox {
            id: showSessionActions
            text: i18n('Session Actions')
        }
    }

    Item {
        Layout.fillHeight: true
    }
}
