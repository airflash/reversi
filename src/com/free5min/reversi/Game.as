package com.free5min.reversi {
import com.free5min.reversi.constants.ScreenID;
import com.free5min.reversi.managers.AssetManager;
import com.free5min.reversi.managers.ScreenManager;

import starling.display.Sprite;

public class Game extends Sprite {

    public static var assetsManager:AssetManager;

    public function Game() {
        addChild(_screenManager = new ScreenManager());

        assetsManager = new AssetManager();

        _screenManager.switchToScreen(ScreenID.INTRO);
    }
    private var _screenManager:ScreenManager;
}
}
