package com.free5min.reversi.view {
import com.free5min.reversi.Game;
import com.free5min.reversi.constants.Global;
import com.free5min.reversi.constants.ScreenID;
import com.greensock.TweenLite;

import feathers.controls.Button;
import feathers.controls.text.TextFieldTextRenderer;
import feathers.core.ITextRenderer;

import flash.text.TextFormat;

import starling.display.Image;

public class ResultScreen extends BaseScreen {

    private var btn:Button;

    // PUBLIC

    override public function init():void {
        super.init();

        btn = new Button();
        btn.defaultSkin = new Image(Game.assetsManager.getTexture("btn"));
        btn.labelFactory = function ():ITextRenderer {
            var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
            textRenderer.textFormat = new TextFormat("Arial", 24, 0x323232);
            return textRenderer;
        };

        btn.width = 300;
        btn.height = 140;

        btn.x = Global.centerX - (btn.width / 2);
        btn.y = Global.centerY - (btn.height / 2);

        addChild(btn);
    }

    override public function destroy():void {
        removeChild(btn)
        btn = null;

        super.destroy();
    }

    override public function setParams(params:Object):void {
        if (params == 0)
            btn.label = "draw";
        if (params == 1)
            btn.label = "You win!";
        if (params == -1)
            btn.label = "You lose!";
        TweenLite.delayedCall(3, switchToScreen, [ScreenID.INTRO]);
    }
}
}
