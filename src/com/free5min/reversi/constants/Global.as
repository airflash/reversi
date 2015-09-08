package com.free5min.reversi.constants {

public class Global {

    public static const PLATE_SIZE:int = 75;
    public static var screenWidth:int;
    public static var screenHeight:int;
    public static var centerX:Number;
    public static var centerY:Number;
    public static var userColor:String = "";
    public static var currentColorMove:String;
    public static var backgroundTextureClass:Class;


    public static function init(w:int, h:int) {
        screenWidth = w;
        screenHeight = h;

        centerX = screenWidth / 2;
        centerY = screenHeight / 2;
    }
}
}
