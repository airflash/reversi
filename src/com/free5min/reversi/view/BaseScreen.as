package com.free5min.reversi.view {
import com.free5min.reversi.Game;
import com.free5min.reversi.constants.Global;

import org.osflash.signals.ISignal;

import starling.display.Image;
import starling.display.Sprite;

public class BaseScreen extends Sprite {

    private var _switchToScreenSignal:ISignal;
    private var _id:String;

    // PRIVATE

    public function init():void {

    }

    public function destroy():void {

    }

    public function setSwitchScreenSignal(signal:ISignal):void {
        _switchToScreenSignal = signal;
    }

    public function setParams(params:Object):void {

    }

    // PRIVATE

    protected function switchToScreen(screenName:String, params:Object = null):void {
        if (screenName)
            _switchToScreenSignal.dispatch(screenName, params);
        else
            throw new Error("Can'not switch to NULL screen");
    }

    protected function setupBackground(textureName:String):void {
        var image:Image = new Image(Game.assetsManager.getTexture(textureName));
        image.x = Global.centerX - (image.width / 2);
        image.y = Global.centerY - (image.height / 2);
        addChild(image)
    }

    // GETTERS & SETTERS

    public function get id():String {
        return _id;
    }
}
}
