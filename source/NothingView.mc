import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class NothingView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    function onLayout(dc as Dc) as Void { }

    function onShow() as Void { }

    function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();

        // center point
        var cX = dc.getWidth() / 2.0f;
        var cY = dc.getHeight() / 2.0f;

        // top 
        // - start point
        var topStartX = cX + (cX * Math.cos(150 * (Math.PI / 180)));
        var topStartY = cY - (cY * Math.sin(150 * (Math.PI / 180)));

        // - end point
        var topEndX = cX + (cX * Math.cos(30 * (Math.PI / 180)));
        var topEndY = cY - (cY * Math.sin(30 * (Math.PI / 180)));

        // bottom
        // - start point
        var bottomStartX = cX + (cX * Math.cos(210 * (Math.PI / 180)));
        var bottomStartY = cY - (cY * Math.sin(210 * (Math.PI / 180)));

        // - end point
        var bottomEndX = cX + (cX * Math.cos(330 * (Math.PI / 180)));
        var bottomEndY = cY - (cY * Math.sin(330 * (Math.PI / 180)));

        var width = topEndX - topStartX;
        var height = bottomStartY - topStartY;

        // dc.drawRectangle(topStartX, topStartY, width, height);

        var time = System.getClockTime();
        var formattedTime = time.hour.format("%02d") + ":" + time.min.format("%02d");

        var dimensions = Dots.size(formattedTime);
        var dotSize = width / dimensions[:x];

        var dotStride = (dotSize * 0.05f) / 2;
        var dotRadius = (dotSize / 2.0f) - dotStride;
        var radius = dotRadius + dotStride;

        var options = {
            :x => topStartX + radius,
            :y => topStartY + 0.5f * (height - 2 * radius * dimensions[:y]),
            :dotStride => dotStride,
            :dotRadius => dotRadius,
        };

        Dots.print(dc, formattedTime, options);
    }

    function onHide() as Void { }

    function onExitSleep() as Void { }

    function onEnterSleep() as Void { }

}