import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

import Toybox.Application.Properties;

class NothingView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    function onLayout(dc as Dc) as Void { }

    function onShow() as Void { }

    function onUpdate(dc as Dc) as Void {
        var layout = Properties.getValue(Dots.LAYOUT_KEY);
        if (layout == null) { layout = Dots.Layout.Horizontal; }

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        
        if (layout == Dots.Layout.Horizontal) { drawTimeHorizontally(dc); return; }
        if (layout == Dots.Layout.Vertical) { drawTimeVertically(dc); return; }
    }

    function onHide() as Void { }

    function onExitSleep() as Void { }

    function onEnterSleep() as Void { }

    function drawTimeHorizontally(dc as Dc) as Void {
        var box = getDrawBox(dc, 30);

        // dc.drawRectangle(
        //     box[:topStartX], 
        //     box[:topStartY], 
        //     box[:width], 
        //     box[:height]
        // );

        var time = System.getClockTime();
        var formattedTime = time.hour.format("%02d") + ":" + time.min.format("%02d");

        var dimensions = Dots.size(formattedTime);
        var dotSize = box[:width] / dimensions[:x];

        var dotStride = (dotSize * 0.05f) / 2;
        var dotRadius = (dotSize / 2.0f) - dotStride;
        var radius = dotRadius + dotStride;

        Dots.print(dc, formattedTime, {
            :x => box[:topStartX] + radius,
            :y => box[:topStartY] + 0.5f * (box[:height] - 2 * radius * dimensions[:y]),
            :dotStride => dotStride,
            :dotRadius => dotRadius,
        });
    }

    function drawTimeVertically(dc as Dc) as Void {
        var box = getDrawBox(dc, 60);

        // dc.drawRectangle(
        //     box[:topStartX], 
        //     box[:topStartY], 
        //     box[:width], 
        //     box[:height]
        // );
        // dc.drawLine(
        //     box[:topStartX], 
        //     box[:topStartY] + 0.5f * box[:height], 
        //     box[:topEndX], 
        //     box[:topEndY] + 0.5f * box[:height]
        // );

        var time = System.getClockTime();
        var hours = time.hour.format("%02d");
        var minutes = time.min.format("%02d");

        var dimensions = Dots.size(hours);
        var dotSize = min(
            box[:width] / dimensions[:x],
            (box[:height] / 2) / dimensions[:y]
        );

        var dotStride = (dotSize * 0.05f) / 2;
        var dotRadius = (dotSize / 2.0f) - dotStride;
        var radius = dotRadius + dotStride;

        var x = box[:topStartX] + radius + (box[:width] - (dimensions[:x] * dotSize)) * 0.5f;
        var y = box[:topStartY] + radius + (box[:height] * 0.5f - (dimensions[:y] * dotSize)) * 0.5f;

        Dots.print(dc, hours, {
            :x => x,
            :y => y,
            :dotStride => dotStride,
            :dotRadius => dotRadius
        });

        Dots.print(dc, minutes, {
            :x => x,
            :y => y + box[:height] * 0.5f,
            :dotStride => dotStride,
            :dotRadius => dotRadius,
        });
    }

    function getDrawBox(dc as Dc, degrees as Number) {
        // center point
        var cX = dc.getWidth() / 2.0f;
        var cY = dc.getHeight() / 2.0f;

        var radians = Math.toRadians(degrees);
        var sin = Math.sin(radians);
        var cos = Math.cos(radians);

        // top 
        // - start point
        var topStartX = cX - (cX * cos);
        var topStartY = cY - (cY * sin);

        // - end point
        var topEndX = cX + (cX * cos);
        var topEndY = cY - (cY * sin);

        // bottom
        // - start point
        var bottomStartX = cX - (cX * cos);
        var bottomStartY = cY + (cY * sin);

        // - end point
        var bottomEndX = cX + (cX * cos);
        var bottomEndY = cY + (cY * sin);

        var width = topEndX - topStartX;
        var height = bottomStartY - topStartY;

        return {
            :topStartX => topStartX,
            :topStartY => topStartY,
            :topEndX => topEndX,
            :topEndY => topEndY,
            :bottomStartX => bottomStartX,
            :bottomStartY => bottomStartY,
            :bottomEndX => bottomEndX,
            :bottomEndY => bottomEndY,
            :width => width,
            :height => height
        };
    }

    function min(a as Number, b as Number) as Number {
        return (a > b) ? b : a;
    }
}