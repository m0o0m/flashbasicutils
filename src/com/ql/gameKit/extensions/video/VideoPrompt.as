package com.ql.gameKit.extensions.video
{
    import flash.display.*;
    import flash.text.*;

    public class VideoPrompt extends Sprite
    {
        private const MESSAGES:Array =[["连接中...", "連接中...", "connect...", "กำลังเชื่อมต่อ..."], ["停止", "停止", "stop", "หยุด"], ["没有信号", "沒有信號", "no signal", "ไม่มีสัญญาณ"]];
        private var _txtMessage:TextField;
        private var _width:Number;
        private var _height:Number;
        private var _lang:int;

        public function VideoPrompt(width:Number, height:Number, lang:int = 1)
        {
            _lang = lang - 1;
            _width = width;
            _height = height;
            viewDidLoad();
            return;
        }// end function

        private function viewDidLoad() : void
        {
            var _loc_1:* = new Sprite();
            _loc_1.graphics.beginFill(0);
            _loc_1.graphics.drawRect(0, 0, _width, _height);
            _loc_1.graphics.endFill();
            addChild(_loc_1);
            var _loc_2:* = new TextFormat("Arial", 24);
            _txtMessage = new TextField();
            _txtMessage.textColor = 16777215;
            _txtMessage.y = _height / 2 - 20;
            _txtMessage.defaultTextFormat = _loc_2;
            addChild(_txtMessage);
            return;
        }// end function

        public function connecting() : void
        {
            _txtMessage.x = _width / 2 - 50;
            _txtMessage.text = MESSAGES[0][_lang];
            return;
        }// end function

        public function stop() : void
        {
            _txtMessage.x = _width / 2 - 30;
            _txtMessage.text = MESSAGES[1][_lang];
            return;
        }// end function

        public function noSignal() : void
        {
            _txtMessage.x = _width / 2 - 50;
            _txtMessage.text = MESSAGES[1][_lang];
            return;
        }// end function

    }
}
