package com.free5min.reversi.view.game {
import com.free5min.reversi.Game;
import com.free5min.reversi.constants.Global;
import com.free5min.reversi.model.FieldModel;
import com.greensock.TweenLite;

import flash.display.Bitmap;
import flash.display.BitmapData;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.textures.Texture;

public class FieldRenderer extends Sprite {

    private var _items:Vector.<Vector.<FieldItem>>;
    private var _model:FieldModel;
    private var greenMark:Image;
    private var redMark:Image;

    public function FieldRenderer(model:FieldModel) {
        _items = new Vector.<Vector.<FieldItem>>();
        _model = model;

        for (var i:int = 0; i < 8; i++) {
            _items[i] = new Vector.<FieldItem>();
            for (var j:int = 0; j < 8; j++) {
                _items[i][j] = new FieldItem();
                _items[i][j].x = i * Global.PLATE_SIZE;
                _items[i][j].y = j * Global.PLATE_SIZE;
                addChild(_items[i][j]);
            }
        }

        model.updated.add(updateField);
        updateField();

        greenMark = new Image(Game.assetsManager.getTexture("greenMark"));
        greenMark.visible = false;
        addChild(greenMark);

        redMark = new Image(Game.assetsManager.getTexture("redMark"));
        redMark.visible = false;
        addChild(redMark);

        addClickSurface();
    }

    // PUBLIC

    public function destroy():void {

    }

    public function updateField():void {
        for (var i:int = 0; i < 8; i++) {
            for (var j:int = 0; j < 8; j++) {
                var s:String = _model.getFieldState(i, j);

                if (s != "")
                    _items[i][j].setState(s);
            }
        }
    }

    // PRIVATE

    private function addClickSurface():void {
        var bitmap:Bitmap = new Bitmap(new BitmapData(600, 600, true, 0x00000000));
        var texture:Texture = Texture.fromBitmap(bitmap);
        var image:Image = new Image(texture);

        addChild(image);

        image.addEventListener(TouchEvent.TOUCH, touchEventHandler);
    }

    private function touchEventHandler(event:TouchEvent):void {
        if (Global.currentColorMove != Global.userColor)
            return;

        if (event.touches.length > 0) {
            var fx:int = int((event.touches[0].globalX - 200) / Global.PLATE_SIZE);
            var fy:int = int(event.touches[0].globalY / Global.PLATE_SIZE);

            if (fx > 7 || fy > 7 || fx < 0 || fy < 0)
                return;

            if (event.touches[0].globalX < 200) {
                redMark.visible = false;
                greenMark.visible = false;
            }

            var item:FieldItem = _items[fx][fy];
        } else {
            return;
        }

        if (event.getTouch(this, TouchPhase.HOVER)) {
            if (_model.canSetHere(fx, fy)) {
                greenMark.visible = true;
                redMark.visible = false;
                greenMark.x = item.x + item.width / 2 - greenMark.width / 2;
                greenMark.y = item.y + item.height / 2 - greenMark.height / 2;
            }
            else {
                greenMark.visible = false;
                if (_model.getFieldState(fx, fy) == "") {
                    redMark.visible = true;
                    redMark.x = item.x + item.width / 2 - redMark.width / 2;
                    redMark.y = item.y + item.height / 2 - redMark.height / 2;
                }
            }
        }

        if (event.getTouch(this, TouchPhase.BEGAN)) {

            if (_model.setFieldState(fx, fy)) {
                greenMark.visible = false;
                // change move
                Global.currentColorMove = _model.invertColor(Global.currentColorMove);
                TweenLite.delayedCall(1, _model.makeAImove);
            }
        }
    }
}
}
