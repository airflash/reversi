package com.free5min.reversi.view {
import com.free5min.reversi.constants.Global;
import com.free5min.reversi.constants.ScreenID;
import com.greensock.TweenLite;

import starling.display.Image;
import starling.textures.Texture;

public class IntroScreen extends BaseScreen {

    private var _logoImage:Image;

    // PUBLIC

    override public function init():void {
        super.init();

        _logoImage = new Image(Texture.fromEmbeddedAsset(Global.backgroundTextureClass, false, false));
        addChild(_logoImage);

        TweenLite.delayedCall(1, switchToScreen, [ScreenID.SELECT_COLOR]);
    }

    override public function destroy():void {
        removeChild(_logoImage);
        _logoImage = null;

        super.destroy();
    }
}
}
