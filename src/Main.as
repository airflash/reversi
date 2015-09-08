package {

import com.free5min.reversi.Game;
import com.free5min.reversi.constants.Global;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.geom.Rectangle;

import starling.core.Starling;
import starling.display.Image;
import starling.events.Event;
import starling.textures.Texture;

[SWF(frameRate="60", width="800", height="600", backgroundColor="#000000")]
public class Main extends Sprite {

    [Embed(source="../embeddings/def_x1.jpg")]
    private static var Background:Class;

    private var _backgroundBitmap:Bitmap;
    private var _backgroundClass:Class;

    public function Main() {
        Global.init(800, 600);

        initBackground();
        initStarling();
    }

    private function initBackground():void {
        _backgroundClass = Background;
        _backgroundBitmap = new Background();

        // no longer needed!
        Background = null;

        addChild(_backgroundBitmap);
        _backgroundBitmap.x = Global.centerX - _backgroundBitmap.width / 2;
        _backgroundBitmap.y = Global.centerY - _backgroundBitmap.height / 2;

        Global.backgroundTextureClass = _backgroundClass;
    }

    private function initStarling():void {
        Starling.multitouchEnabled = false;
        Starling.handleLostContext = true;
        var viewPort:Rectangle = new Rectangle(0, 0, Global.screenWidth, Global.screenHeight);
        var starling:Starling = new Starling(Game, stage, viewPort);
        starling.addEventListener(Event.ROOT_CREATED, rootCreated);
        starling.stage.stageWidth = Global.screenWidth;
        starling.stage.stageHeight = Global.screenHeight;
        starling.showStats = false;
        starling.start();
    }

    private function rootCreated(event:Event, game:Game):void {
        removeChild(_backgroundBitmap);
        _backgroundBitmap = null;
    }
}
}
