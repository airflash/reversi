package com.free5min.reversi.managers {
import com.free5min.reversi.constants.ScreenID;
import com.free5min.reversi.view.BaseScreen;
import com.free5min.reversi.view.GameScreen;
import com.free5min.reversi.view.IntroScreen;
import com.free5min.reversi.view.ResultScreen;
import com.free5min.reversi.view.SelectColorScreen;

import org.osflash.signals.ISignal;
import org.osflash.signals.Signal;

import starling.display.Sprite;

public class ScreenManager extends Sprite {

    private var _currentScreen:BaseScreen;
    private var _switchToScreenSignal:ISignal;

    public function ScreenManager() {
        _switchToScreenSignal = new Signal(String, Object);
        _switchToScreenSignal.add(switchToScreen);
    }

    public function switchToScreen(screen:String, params:Object = null):void {
        var newScreen:BaseScreen;
        switch (screen) {
            case ScreenID.GAME:
                newScreen = new GameScreen();
                break;
            case ScreenID.INTRO:
                newScreen = new IntroScreen();
                break;
            case ScreenID.SELECT_COLOR:
                newScreen = new SelectColorScreen();
                break;
            case ScreenID.RESULT:
                newScreen = new ResultScreen();
                break;
            default:
                return;
        }

        if (_currentScreen) {
            removeChild(_currentScreen);
            _currentScreen.destroy();
        }
        newScreen.setSwitchScreenSignal(_switchToScreenSignal);
        _currentScreen = newScreen;
        addChild(_currentScreen);
        _currentScreen.init();
        _currentScreen.setParams(params);
    }
}
}
