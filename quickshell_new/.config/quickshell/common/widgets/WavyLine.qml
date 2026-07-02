pragma ComponentBehavior: Bound

import qs.common
import QtQuick

Canvas {
    id: root
    property real amplitudeMultiplier: 0.5
    property real frequency: 6
    property color color: Colors.md3.primary
    property real lineWidth: 4
    property real fullLength: width

    property bool isAnimated: false
    property real animatedAmplitude: isAnimated ? amplitudeMultiplier : 0

    Behavior on animatedAmplitude {
        NumberAnimation {
            duration: 300
            easing.type: Easing.InOutSine
        }
    }

    onAnimatedAmplitudeChanged: requestPaint()

    onPaint: {
        let ctx = getContext("2d");
        ctx.clearRect(0, 0, width, height);

        let amplitude = root.lineWidth * root.animatedAmplitude;
        let frequency = root.frequency;
        let phase = Date.now() / 400.0;
        let centerY = height / 2;

        ctx.strokeStyle = root.color;
        ctx.lineWidth = root.lineWidth;
        ctx.lineCap = "round";
        ctx.beginPath();
        let startX = ctx.lineWidth / 2
        for (let x = startX; x <= root.width - ctx.lineWidth / 2; x += 1) {
            let waveY = centerY + amplitude * Math.sin(frequency * 2 * Math.PI * x / root.fullLength + phase);
            if (x === startX)
                ctx.moveTo(x, waveY);
            else
                ctx.lineTo(x, waveY);
        }
        ctx.stroke();
    }
}
