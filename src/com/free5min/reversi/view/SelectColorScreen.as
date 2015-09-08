package com.free5min.reversi.view {

import com.free5min.reversi.Game;
import com.free5min.reversi.constants.Global;
import com.free5min.reversi.constants.ScreenID;

import feathers.controls.Button;
import feathers.controls.Label;
import feathers.controls.text.TextFieldTextRenderer;
import feathers.core.ITextRenderer;

import flash.text.AntiAliasType;
import flash.text.TextFormat;

import starling.display.Image;
import starling.events.Event;

public class SelectColorScreen extends BaseScreen {

    private var _btnBlack:Button;
    private var _btnWhite:Button;

    private var _label:Label;

    // PUBLIC

    override public function init():void {
        super.init();

        setupBackground("bg");

        createButtons();

        createLabels();
    }

    override public function destroy():void {
        removeChild(_btnBlack);
        _btnBlack = null;

        removeChild(_btnWhite);
        _btnWhite = null;

        removeChild(_label);
        _label = null;

        super.destroy();
    }


    // PRIVATE

    private function createLabels():void {
        _label = new Label();
        _label.text = "Choose you color:";

        _label.textRendererFactory = function ():ITextRenderer {
            var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
            textRenderer.textFormat = new TextFormat("Arial", 24, 0x323232);
            textRenderer.antiAliasType = AntiAliasType.NORMAL;
            return textRenderer;
        };
        _label.x = 300;
        _label.y = 160;

        addChild(_label);
    }

    private function createButtons():void {
       _btnBlack = new Button();

        _btnBlack.defaultSkin = new Image(Game.assetsManager.getTexture('black'));
        _btnBlack.downSkin = new Image(Game.assetsManager.getTexture('black'));

        _btnBlack.addEventListener(Event.TRIGGERED, blackSelectedHandler);
        addChild(_btnBlack);

        _btnBlack.x = 290;
        _btnBlack.y = 200;

        _btnBlack.scaleX = 0.5;
        _btnBlack.scaleY = 0.5;


        _btnWhite = new Button();

        _btnWhite.defaultSkin = new Image(Game.assetsManager.getTexture('white'));
        _btnWhite.downSkin = new Image(Game.assetsManager.getTexture('white'));

        _btnWhite.addEventListener(Event.TRIGGERED, whiteSelectedHandler);
        addChild(_btnWhite);

        _btnWhite.x = 410;
        _btnWhite.y = 200;

        _btnWhite.scaleX = 0.5;
        _btnWhite.scaleY = 0.5;
    }

    private function blackSelectedHandler(event:Event):void {
        Global.userColor = "B";
        switchToScreen(ScreenID.GAME);
    }

    private function whiteSelectedHandler(event:Event):void {
        Global.userColor = "W";
        switchToScreen(ScreenID.GAME);
    }
}
}
