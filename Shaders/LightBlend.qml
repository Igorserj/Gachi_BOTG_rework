import QtQuick 2.15

Item {
    property var image
    property var image2
    width: image.width
    height: image.height
    ShaderEffect {
        width: image.width
        height: image.height
        property variant source1: ShaderEffectSource { sourceItem: image }
        property variant source2: ShaderEffectSource { sourceItem: image2 }
        property point windowSize: Qt.point(width, height)
        fragmentShader: "
            #ifdef GL_ES
            precision mediump float;
            #endif

            uniform lowp vec2 windowSize;
            uniform sampler2D source1;
            uniform sampler2D source2;
            varying highp vec2 qt_TexCoord0;

            void main() {
                highp vec4 src1 = texture2D(source1, qt_TexCoord0);
                highp vec4 src2 = texture2D(source2, qt_TexCoord0);
                src1 += src2;
                gl_FragColor = src1;
            }"
    }
}
