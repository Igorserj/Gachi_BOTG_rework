import QtQuick 2.15

Item {
    width: window.width
    height: window.height
    ShaderEffect {
        id: shader
        width: window.width
        height: window.height
        property point windowSize: Qt.point(window.width, window.height)
        property real time: 0
        property real shiftSpeed: 100. * window.height / 720
        fragmentShader: "
            #ifdef GL_ES
            precision highp float;
            #endif
            uniform highp vec2 windowSize;
            uniform highp float shiftSpeed;
            uniform highp float time;

            float random (in vec2 _st) {
                return fract(sin(dot(_st.xy,
                                     vec2(10.,70.)))*
                                     30000.);
            }

            float noise (in vec2 _st) {
                vec2 i = floor(_st);
                vec2 f = fract(_st);

                float a = random(i);
                float b = random(i + vec2(1.0, 0.0));
                float c = random(i + vec2(0.0, 1.0));
                float d = random(i + vec2(1.0, 1.0));

                vec2 u = f * f * (3.0 - 2.0 * f);

                return mix(a, b, u.x) +
                        (c - a)* u.y * (1.0 - u.x) +
                        (d - b) * u.x * u.y;
            }

            #define NUM_OCTAVES 10

            float fbm ( in vec2 _st) {
                float v = 0.0;
                float a = 0.5;
                vec2 shift = vec2(shiftSpeed);
                mat2 rot = mat2(cos(0.5), sin(0.5),
                                -sin(0.5), cos(0.50));
                for (int i = 0; i < NUM_OCTAVES; ++i) {
                    v += a * noise(_st);
                    _st = rot * _st * 2.0 + shift;
                    a *= 0.5;
                }
                return v;
            }

            void main() {
                vec2 st = gl_FragCoord.xy/windowSize.xy*4.;
                st.x *= windowSize.x/windowSize.y;
                vec3 color = vec3(0.0);

                vec2 q = vec2(0.);
                q.x = fbm( st + 0.05*time);
                q.y = fbm( st + vec2(1.0));

                vec2 r = vec2(0.);
                r.x = fbm( st + 1.0*q + vec2(1.7,9.2)+ 0.15*time );
                r.y = fbm( st + 1.0*q + vec2(8.3,2.8)+ 0.126*time);

                float f = fbm(st+r);
                color = mix(color, vec3(1,1,1), clamp(length(r.x),0.3,1.0));

                gl_FragColor = vec4((f*f*f+.6*f*f+.5*f)*color,1.);
            }"
    }
    Timer {
        id: timer
        running: true
        repeat: true
        interval: 1000/60
        onTriggered: shader.time+=0.01
    }
}
