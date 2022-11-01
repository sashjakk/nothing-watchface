import Toybox.System;
import Toybox.Lang;
import Toybox.Graphics;

module Dots {
    const CHARACTERS = {
        '0' => [
            [0, 1, 1, 1, 0],
            [1, 0, 0, 0, 1],
            [1, 0, 0, 0, 1],
            [1, 0, 0, 0, 1],
            [1, 0, 0, 0, 1],
            [1, 0, 0, 0, 1],
            [0, 1, 1, 1, 0]
        ],
        '1' => [
            [0, 0, 1, 0, 0],
            [0, 1, 1, 0, 0],
            [0, 0, 1, 0, 0],
            [0, 0, 1, 0, 0],
            [0, 0, 1, 0, 0],
            [0, 0, 1, 0, 0],
            [0, 1, 1, 1, 0]
        ],
        '2' => [
            [0, 1, 1, 1, 0],
            [1, 0, 0, 0, 1],
            [0, 0, 0, 0, 1],
            [0, 0, 0, 1, 0],
            [0, 0, 1, 0, 0],
            [0, 1, 0, 0, 0],
            [1, 1, 1, 1, 1]
        ],
        '3' => [
            [0, 1, 1, 1, 0],
            [1, 0, 0, 0, 1],
            [0, 0, 0, 0, 1],
            [0, 0, 1, 1, 0],
            [0, 0, 0, 0, 1],
            [1, 0, 0, 0, 1],
            [0, 1, 1, 1, 0]
        ],
        '4' => [
            [0, 0, 0, 1, 0],
            [0, 0, 1, 1, 0],
            [0, 1, 0, 1, 0],
            [1, 0, 0, 1, 0],
            [1, 1, 1, 1, 1],
            [0, 0, 0, 1, 0],
            [0, 0, 0, 1, 0]
        ],
        '5' => [
            [1, 1, 1, 1, 1],
            [1, 0, 0, 0, 0],
            [1, 0, 0, 0, 0],
            [1, 1, 1, 1, 0],
            [0, 0, 0, 0, 1],
            [1, 0, 0, 0, 1],
            [0, 1, 1, 1, 0]
        ],
        '6' => [
            [0, 0, 1, 1, 1],
            [0, 1, 0, 0, 0],
            [1, 0, 0, 0, 0],
            [1, 1, 1, 1, 0],
            [1, 0, 0, 0, 1],
            [1, 0, 0, 0, 1],
            [0, 1, 1, 1, 0]
        ],
        '7' => [
            [1, 1, 1, 1, 1],
            [0, 0, 0, 0, 1],
            [0, 0, 0, 1, 0],
            [0, 0, 1, 0, 0],
            [0, 1, 0, 0, 0],
            [0, 1, 0, 0, 0],
            [0, 1, 0, 0, 0]
        ],
        '8' => [
            [0, 1, 1, 1, 0],
            [1, 0, 0, 0, 1],
            [1, 0, 0, 0, 1],
            [0, 1, 1, 1, 0],
            [1, 0, 0, 0, 1],
            [1, 0, 0, 0, 1],
            [0, 1, 1, 1, 0]
        ],
        '9' => [
            [0, 1, 1, 1, 0],
            [1, 0, 0, 0, 1],
            [1, 0, 0, 0, 1],
            [0, 1, 1, 1, 1],
            [0, 0, 0, 0, 1],
            [0, 0, 0, 1, 0],
            [0, 1, 1, 0, 0]
        ],
        ':' => [
            [0],
            [0],
            [1],
            [0],
            [1],
            [0],
            [0],
        ]
    };

    // Calculates size of dots required for drawing text
    // returns { :x => amount, :y => amount }
    function size(text as String) as Dictionary {
        var chars = text.toCharArray();

        var x = 0;
        var y = 0;

        for (var i = 0; i < chars.size(); i++) {
            var symbol = CHARACTERS[chars[i]];
            
            x += symbol[0].size();
            
            // appends single dot for char spacing
            if (i < chars.size() - 1) { x += 1; }

            if (symbol.size() > y) {
                y = symbol.size();
            }
        }

        return { :x => x, :y => y };
    }

    function print(
        dc as Dc,
        text as String,
        opts as Dictionary
    ) as Void {
        var chars = text.toCharArray();
        var x = opts[:x];
        
        for (var i = 0; i < chars.size(); i++) {
            var symbol = CHARACTERS[chars[i]];
            if (symbol == null) { return; }

            var size = 2 * (opts[:dotRadius] + opts[:dotStride]);

            for (var r = 0; r < symbol.size(); r++) {
                for (var c = 0; c < symbol[r].size(); c++) {
                    if (symbol[r][c] == 0) { continue; }
                    
                    dc.fillCircle(
                        x + c * size, 
                        opts[:y] + r * size, 
                        opts[:dotRadius]
                    );
                }
            }

            // calculate next position for char with spacing
            x += (symbol[0].size() + 1) * size;
        }
    }
}