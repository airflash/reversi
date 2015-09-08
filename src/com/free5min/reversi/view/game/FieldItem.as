package com.free5min.reversi.view.game {
import com.free5min.reversi.Game;
import com.free5min.reversi.constants.Global;

import starling.display.Image;
import starling.display.Sprite;

public class FieldItem extends Sprite {

    private var black:Image;
    private var white:Image;

    private var _state:String;

    public function FieldItem() {
        _state = "";

        var bg:Image = new Image(Game.assetsManager.getTexture("plate"));
        bg.width = Global.PLATE_SIZE;
        bg.height = Global.PLATE_SIZE;

        addChild(bg);

        black = new Image(Game.assetsManager.getTexture("black"));
        black.x = 2;
        black.y = 2;
        black.width = Global.PLATE_SIZE - 4;
        black.height = Global.PLATE_SIZE - 4;
        black.visible = false;
        addChild(black);

        white = new Image(Game.assetsManager.getTexture("white"));
        white.x = 2;
        white.y = 2;
        white.width = Global.PLATE_SIZE - 4;
        white.height = Global.PLATE_SIZE - 4;
        white.visible = false;
        addChild(white);
    }

    // PUBLIC

    public function setState(value:String):void {
        if (value == "B") {
            black.visible = true;
            white.visible = false;
        }
        if (value == "W") {
            black.visible = false;
            white.visible = true;
        }
    }

    // GETTERS & SETTERS

    public function get state():String {
        return _state;
    }
}
}
