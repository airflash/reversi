package com.free5min.reversi.model {
import com.free5min.reversi.constants.Global;
import com.greensock.TweenLite;

import org.osflash.signals.Signal;

public class FieldModel {

    private var field:Array;
    private var _updated:Signal;
    private var _finalize:Signal;

    public function FieldModel() {
        createField();
        clearField();
        initFileld();

        _updated = new Signal();
        _finalize = new Signal(int);
    }

    // PUBLIC

    public function clearField():void {
        for (var i:int = 0; i < 8; i++) {
            for (var j:int = 0; j < 8; j++) {
                field[i][j] = "";
            }
        }
    }

    public function getFieldState(fx:int, fy:int):String {
        return field[fx][fy];
    }

    public function setFieldState(x:int, y:int):Boolean {
        if (!canSetHere(x, y))
            return false;

        field[x][y] = Global.currentColorMove;

        var targetColor:String = invertColor(Global.currentColorMove);
        raycast(x, y, -1, -1, targetColor, true);
        raycast(x, y, -1, 0, targetColor, true);
        raycast(x, y, -1, 1, targetColor, true);

        raycast(x, y, 0, -1, targetColor, true);
        raycast(x, y, 0, 1, targetColor, true);

        raycast(x, y, 1, -1, targetColor, true);
        raycast(x, y, 1, 0, targetColor, true);
        raycast(x, y, 1, 1, targetColor, true);

        _updated.dispatch();
        return true;
    }

    public function canSetHere(x:int, y:int):Boolean {
        if (field[x][y] != "")
            return false;

        var targetColor:String = invertColor(Global.currentColorMove);

        var sum:Number = 0;

        sum += uint(raycast(x, y, -1, -1, targetColor));
        sum += uint(raycast(x, y, -1, 0, targetColor));
        sum += uint(raycast(x, y, -1, 1, targetColor));

        sum += uint(raycast(x, y, 0, -1, targetColor));
        sum += uint(raycast(x, y, 0, 1, targetColor));

        sum += uint(raycast(x, y, 1, -1, targetColor));
        sum += uint(raycast(x, y, 1, 0, targetColor));
        sum += uint(raycast(x, y, 1, 1, targetColor));

        return (sum > 0);
    }

    public function invertColor(color:String):String {
        if (color == "B")
            return "W";
        if (color == "W")
            return "B";
        return "";
    }

    public function makeAImove():void {
        var i:int;
        var j:int;


        var variants:Array = [];
        for (i = 0; i < 8; i++) {
            for (j = 0; j < 8; j++) {
                if (canSetHere(i, j)) {
                    variants.push([i,j]);
                }
            }
        }

        // randomizng AI move
        if (variants.length > 0) {
            var coord:Array = variants[int(Math.random()*variants.length)];

            if (setFieldState(coord[0], coord[1])) {
                Global.currentColorMove = invertColor(Global.currentColorMove);
                testOnPlayerMovePossibility();
                return;
            }
        }

        Global.currentColorMove = invertColor(Global.currentColorMove);

        for (i = 0; i < 8; i++) {
            for (j = 0; j < 8; j++) {
                if (canSetHere(i, j))
                    return;
            }
        }

        calculateScoreAndFinalize();
    }

    // PRIVATE

    private function testOnPlayerMovePossibility():void {
        var i:int;
        var j:int;

        for (i = 0; i < 8; i++) {
            for (j = 0; j < 8; j++) {
                if (canSetHere(i, j))
                    return;
            }
        }

        Global.currentColorMove = invertColor(Global.currentColorMove);

        for (i = 0; i < 8; i++) {
            for (j = 0; j < 8; j++) {
                if (canSetHere(i, j)) {
                    TweenLite.delayedCall(1, makeAImove);
                    return;
                }
            }
        }

        calculateScoreAndFinalize();
    }

    private function calculateScoreAndFinalize():void {
        var black:int = 0;
        var white:int = 0;
        for (var i:int = 0; i < 8; i++) {
            for (var j:int = 0; j < 8; j++) {
                if (field[i][j] == "B")
                    black++;
                if (field[i][j] == "W")
                    white++;
            }
        }

        if (black == white)
            finalize.dispatch(0);

        if ((Global.userColor == "B" && black > white) || (Global.userColor == "W" && white > black))
            finalize.dispatch(1);
        else
            finalize.dispatch(-1);
    }

    private function initFileld():void {
        field[3][3] = "W";
        field[4][3] = "B";
        field[3][4] = "B";
        field[4][4] = "W";
    }

    private function createField():void {
        field = [];
        for (var i:int = 0; i < 8; i++) {
            field[i] = [];
        }
    }

    private function raycast(x:int, y:int, dx:int, dy:int, targetColor:String, flip:Boolean = false):Number {
        if ((x == 0 && dx == -1) || (y == 0 && dy == -1) || (x == 7 && dx == 1) || (y == 7 && dy == 1)) return -Infinity;

        if (field[x + dx][y + dy] == "")
            return -Infinity;

        // same color
        if (field[x + dx][y + dy] == invertColor(targetColor))
            return 0;

        // opponent color
        if (field[x + dx][y + dy] == targetColor) {
            var v:Number = raycast(x + dx, y + dy, dx, dy, targetColor, flip) + 1;
            if (v > 0 && flip)
                field[x + dx][y + dy] = Global.currentColorMove;
            return v
        }

        return -Infinity;
    }

    // GETTERS & SETTERS

    public function get updated():Signal {
        return _updated;
    }

    public function get finalize():Signal {
        return _finalize;
    }
}
}
