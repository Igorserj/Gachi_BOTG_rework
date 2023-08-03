import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    property var image
    width: image.width
    height: image.height
    ShaderEffect {
        id: spotlight
        width: image.width
        height: image.height
        property variant source: ShaderEffectSource { sourceItem: image }
        property point lightPos: Qt.point(dragArea.mouseX*(width/height)/width, 1.-dragArea.mouseY/height)
        property point windowSize: Qt.point(width, height)
        property real upperLimit: slider.value
        property real lowerLimit: slider2.value
        property real l: slider3.value
        property real angle: slider4.value
        property real colorR: 1.0
        property real colorG: 0.8
        property real colorB: 0.8

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
    }
    MouseArea {
        id: dragArea
        anchors.fill: spotlight
    }
    Row {
        anchors.bottom: parent.bottom
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
    }
}
