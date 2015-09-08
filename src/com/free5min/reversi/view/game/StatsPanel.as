package com.free5min.reversi.view.game {
import com.free5min.reversi.Game;
import com.free5min.reversi.model.FieldModel;

import feathers.controls.Label;
import feathers.controls.text.TextFieldTextRenderer;
import feathers.core.ITextRenderer;

import flash.text.TextFormat;

import starling.display.Image;
import starling.display.Sprite;

public class StatsPanel extends Sprite {

    private var _model:FieldModel;
    private var lblBlack:Label;
    private var lblWhite:Label;

    public function StatsPanel(model:FieldModel) {
        super();
        _model = model;
        _model.updated.add(updateStats);

        initImages();
        initLabels();

        updateStats();
    }

    // PRIVATE

    private function initImages():void {
        var imgBlack:Image = new Image(Game.assetsManager.getTexture("black"));
        imgBlack.x = 0;
        imgBlack.y = 0
        imgBlack.width = 40;
        imgBlack.height = 40;
        addChild(imgBlack)

        var imgWhite:Image = new Image(Game.assetsManager.getTexture("white"));
        imgWhite.x = 0;
        imgWhite.y = 45
        imgWhite.width = 40;
        imgWhite.height = 40;
        addChild(imgWhite)
    }

    private function initLabels():void {
        lblBlack = new Label();
        lblWhite = new Label();

        lblBlack.textRendererFactory = lblWhite.textRendererFactory = function ():ITextRenderer {
            var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
            textRenderer.textFormat = new TextFormat("Arial", 24, 0x323232);
            return textRenderer;
        };

        lblBlack.x = 50;
        lblBlack.y = 5;

        lblWhite.x = 50;
        lblWhite.y = 50;

        addChild(lblBlack)
        addChild(lblWhite)
    }

    private function updateStats():void {
        var black:int = 0;
        var white:int = 0;
        for (var i:int = 0; i < 8; i++) {
            for (var j:int = 0; j < 8; j++) {
                if (_model.getFieldState(i, j) == "B")
                    black++;
                if (_model.getFieldState(i, j) == "W")
                    white++;
            }
        }

        lblBlack.text = ": " + black.toString();
        lblWhite.text = ": " + white.toString();
    }
}
}
