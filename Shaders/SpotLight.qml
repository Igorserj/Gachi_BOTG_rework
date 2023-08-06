import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    property var image
    property alias upperLimit: slider.value
    property alias lowerLimit: slider2.value
    property alias length: slider3.value
    property alias angle: slider4.value
    property alias colorR: sliderR.value
    property alias colorG: sliderG.value
    property alias colorB: sliderB.value
    property alias lightPosX: dragArea.posX
    property alias lightPosY: dragArea.posY
    property alias animationDuration: pulsation.dur
    property alias pulsationRunning: pulsation.running
    property bool hideControls: false
    width: image.width
    height: image.height
    ShaderEffect {
        id: spotlight
        width: image.width
        height: image.height
        property variant source: ShaderEffectSource { sourceItem: image }
        property point lightPos: Qt.point(dragArea.posX, 1.-dragArea.posY)
        property point windowSize: Qt.point(width, height)
        property real upperLimit: slider.value
        property real lowerLimit: slider2.value
        property real l: slider3.value
        property real angle: slider4.value
        property real colorR: sliderR.value
        property real colorG: sliderG.value
        property real colorB: sliderB.value

        fragmentShader: "
            #ifdef GL_ES
            precision mediump float;
            #endif
            #define PI 3.14159265359

            uniform highp vec2 windowSize;
            uniform highp vec2 lightPos;
            uniform lowp float upperLimit;
            uniform lowp float lowerLimit;
            uniform lowp float l;
            uniform lowp float angle;
            uniform lowp float colorR;
            uniform lowp float colorG;
            uniform lowp float colorB;
            uniform sampler2D source;
            varying highp vec2 qt_TexCoord0;

            void main() {
                mediump vec3 lightColor = vec3(colorR, colorG, colorB);
                highp vec4 src = texture2D(source, qt_TexCoord0);
                vec2 st = gl_FragCoord.xy/windowSize;
                st.x *= windowSize.x/windowSize.y;
                float length = smoothstep(lowerLimit, upperLimit, max(distance(st, vec2(lightPos.x-l, lightPos.y-angle)),distance(st, vec2(lightPos.x+l, lightPos.y+angle))));
                vec3 map = vec3(length);
                //vec3 lightColor = vec3(1.0, 0.8, 0.8);
                src.rgb *= map * lightColor;
                gl_FragColor = vec4(src.rgb, 1.0);
            }"

        SequentialAnimation {
            id: pulsation
            loops: Animation.Infinite
            property int dur: 1000
            ParallelAnimation {
                PropertyAnimation {
                    target: slider
                    properties: "value"
                    to: slider.value+0.05
                    duration: pulsation.dur
                }
                PropertyAnimation {
                    target: slider2
                    properties: "value"
                    to: slider2.value+0.05
                    duration: pulsation.dur
                }
            }
            ParallelAnimation {
                PropertyAnimation {
                    target: slider
                    properties: "value"
                    to: slider.value-0.05
                    duration: pulsation.dur
                }
                PropertyAnimation {
                    target: slider2
                    properties: "value"
                    to: slider2.value-0.05
                    duration: pulsation.dur
                }
            }

        }
    }
    MouseArea {
        id: dragArea
        property real posX: 0.0
        property real posY: 0.0
        anchors.fill: spotlight
        enabled: !hideControls
        onMouseXChanged: posX = mouseX*(width/height)/width
        onMouseYChanged: posY = mouseY/height
    }
    Row {
        anchors.bottom: parent.bottom
        enabled: !hideControls
        visible: !hideControls
        Column {
            Rectangle {
                width: childrenRect.width
                height: childrenRect.height
                Text {
                    text: "Upper Limit " + slider.value
                    color: "Black"
                }
            }
            Slider {
                id: slider
                from: 0.0
                to: 1.0
            }
        }
        Column {
            Rectangle {
                width: childrenRect.width
                height: childrenRect.height
                Text {
                    text: "Lower Limit " + slider2.value
                    color: "Black"
                }
            }
            Slider {
                id: slider2
                from: 0.0
                to: 1.0
            }
        }
        Column {
            Rectangle {
                width: childrenRect.width
                height: childrenRect.height
                Text {
                    text: "Length " + slider3.value
                    color: "Black"
                }
            }
            Slider {
                id: slider3
                from: 0.0
                to: 1.0
            }
        }
        Column {
            Rectangle {
                width: childrenRect.width
                height: childrenRect.height
                Text {
                    text: "Angle " + slider4.value
                    color: "Black"
                }
            }
            Slider {
                id: slider4
                from: -0.4
                to: 0.4
            }
        }
        Column {
            Slider {
                id: sliderR
                from: 0.0
                to: 1.0
                value: 1.0
                orientation: Qt.Vertical
            }
            Rectangle {
                width: childrenRect.width
                height: childrenRect.height
                Text {
                    text: "Red " + sliderR.value
                    color: "Black"
                }
            }
        }

        Column {
            Slider {
                id: sliderG
                from: 0.0
                to: 1.0
                value: 0.8
                orientation: Qt.Vertical
            }
            Rectangle {
                width: childrenRect.width
                height: childrenRect.height
                Text {
                    text: "Green " + sliderG.value
                    color: "Black"
                }
            }
        }

        Column {
            Slider {
                id: sliderB
                from: 0.0
                to: 1.0
                value: 0.8
                orientation: Qt.Vertical
            }
            Rectangle {
                width: childrenRect.width
                height: childrenRect.height
                Text {
                    text: "Blue " + sliderB.value
                    color: "Black"
                }
            }
        }

        Rectangle {
            width: childrenRect.width
            height: childrenRect.height
            Text {
                text: (spotlight.lightPos.x + " " + spotlight.lightPos.y)
                color: "Black"
            }
        }
    }
}
