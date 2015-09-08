package com.free5min.reversi.managers {
import starling.textures.Texture;

public class AssetManager {

    [Embed(source='../../../../../embeddings/textures/black.png')]
    private static var black:Class;

    [Embed(source='../../../../../embeddings/textures/white.png')]
    private static var white:Class;

    [Embed(source='../../../../../embeddings/textures/bg.jpg')]
    private static var bg:Class;

    [Embed(source='../../../../../embeddings/textures/plate.jpg')]
    private static var plate:Class;

    [Embed(source='../../../../../embeddings/textures/greenmark.png')]
    private static var greenmark:Class;

    [Embed(source='../../../../../embeddings/textures/redmark.png')]
    private static var redmark:Class;

    [Embed(source='../../../../../embeddings/textures/btn.png')]
    private static var btn:Class;

    private var _blackTexture:Texture;
    private var _whiteTexture:Texture;
    private var _bgTexture:Texture;
    private var _plateTexture:Texture;
    private var _greenTexture:Texture;
    private var _redTexture:Texture;
    private var _btnTexture:Texture;

    public function AssetManager() {
        _blackTexture = Texture.fromBitmap(new black());
        _whiteTexture = Texture.fromBitmap(new white());
        _bgTexture = Texture.fromBitmap(new bg());
        _plateTexture = Texture.fromBitmap(new plate());
        _greenTexture = Texture.fromBitmap(new greenmark());
        _redTexture = Texture.fromBitmap(new redmark());
        _btnTexture = Texture.fromBitmap(new btn());
    }

    public function getTexture(name:String):Texture {

        if (name == "black")
            return _blackTexture;

        if (name == "white")
            return _whiteTexture;

        if (name == "bg")
            return _bgTexture;

        if (name == "plate")
            return _plateTexture;

        if (name == "greenMark")
            return _greenTexture;

        if (name == "redMark")
            return _redTexture;

        if (name == "btn")
            return _btnTexture;

        return null;
    }
}
}
