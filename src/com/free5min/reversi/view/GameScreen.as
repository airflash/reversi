package com.free5min.reversi.view {

import com.free5min.reversi.Game;
import com.free5min.reversi.constants.Global;
import com.free5min.reversi.constants.ScreenID;
import com.free5min.reversi.model.FieldModel;
import com.free5min.reversi.view.game.FieldRenderer;
import com.free5min.reversi.view.game.StatsPanel;
import com.greensock.TweenLite;

import feathers.controls.Button;
import feathers.controls.text.TextFieldTextRenderer;
import feathers.core.ITextRenderer;

import flash.text.TextFormat;

import starling.display.Image;
import starling.events.Event;

public class GameScreen extends BaseScreen {

    private var _fieldVis:FieldRenderer;
    private var _fieldModel:FieldModel;

    // PUBLIC

    override public function init():void {
        super.init();

        setupBackground("bg");

        initFieldModel();
        initFieldView();

        var statsPanel:StatsPanel = new StatsPanel(_fieldModel)
        addChild(statsPanel);
        statsPanel.x = 10;
        statsPanel.y = 100;

        var replayButton:Button = new Button();
        replayButton.label = "replay";
        replayButton.addEventListener(Event.TRIGGERED, replayHandler);
        replayButton.defaultSkin = new Image(Game.assetsManager.getTexture("btn"));
        replayButton.x = 20;
        replayButton.y = 500;
        replayButton.width = 120;
        replayButton.height = 60;
        replayButton.labelFactory = function ():ITextRenderer {
            var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
            textRenderer.textFormat = new TextFormat("Arial", 24, 0x323232);
            return textRenderer;
        };

        addChild(replayButton);

        Global.currentColorMove = "B";
        if (Global.userColor == "W") {
            TweenLite.delayedCall(1, _fieldModel.makeAImove)
        }
    }

    override public function destroy():void {
        removeChild(_fieldVis);
        _fieldVis.destroy();
        _fieldVis = null;

        _fieldModel = null;

        super.destroy();
    }

    // PRIVATE

    private function initFieldModel():void {
        _fieldModel = new FieldModel();
        _fieldModel.finalize.add(finalize);
    }

    private function finalize(result:int):void {
        switchToScreen(ScreenID.RESULT, result);
    }

    private function initFieldView():void {
        _fieldVis = new FieldRenderer(_fieldModel);
        addChild(_fieldVis);

        _fieldVis.x = Global.centerX - _fieldVis.width / 2 + 100;
        _fieldVis.y = Global.centerY - _fieldVis.height / 2;
    }

    private function replayHandler(event:Event):void {
        switchToScreen(ScreenID.INTRO);
    }
}
}
