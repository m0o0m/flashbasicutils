package com.wg.layout
{
//	import com.panels.tip.Tip;
//	import com.seaWarScene.utils.GameMathUtil;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Point;
	/**
	 *层级管理,将不同的元素根据特性添加到不同的层级中,方便管理和操作; 
	 * @author Allen
	 * 
	 */	
    public class Layout extends Sprite
    {
		private var _stage:Stage;
		
//		private var _view:View;
		
		private var _sceneUILayer:LayoutSprite;
		private var _panelLayer:Popup;
		private var _alertLayer:LayoutSprite;
        private var _loadingLayer:LayoutSprite;
		private var _chatLayer:LayoutSprite;
		private var _screenLayer:LayoutSprite;
//		private var _tipLayer:Tip;
		private var _tipLayer:LayoutSprite;
		private var _effectLayer:LayoutSprite; //全屏特效的层
		private var _mouseLayer:LayoutSprite;
		private var _newGuilderLayer:LayoutSprite;
		
        public function init(stage:Stage) : void
        {
			_stage = stage;
//			_view = view;
			
			_sceneUILayer = new LayoutSprite();
			_sceneUILayer.name = "sceneUILayer";
//			_panelLayer = new Popup(view);
			_panelLayer = new Popup(Config.viewManger);
			_panelLayer.name = "panelLayer";
			_loadingLayer = new LayoutSprite();
			_loadingLayer.name = "loadingLayer";
//			_tipLayer = new Tip();
			_tipLayer = new LayoutSprite();
			_tipLayer.name = "tipLayer";
			_alertLayer = new LayoutSprite();
			_alertLayer.name = "alertLayer";
			_mouseLayer = new LayoutSprite();
			_mouseLayer.name ="_mouseLayer";
			_chatLayer = new LayoutSprite();
			_chatLayer.name = "_chatLayer";
			_screenLayer = new LayoutSprite();
			_screenLayer.name = "_screenLayer";
			_effectLayer = new LayoutSprite();
			_effectLayer.name = "effectLayer";
			_newGuilderLayer = new LayoutSprite();
			_newGuilderLayer.name = "_newGuilderLayer";

			
			addChild(_sceneUILayer);
			addChild(_chatLayer);
			addChild(_panelLayer);
			addChild(_alertLayer);
			addChild(_screenLayer);
			addChild(_loadingLayer);
			addChild(_tipLayer);
			addChild(_effectLayer);
			addChild(_newGuilderLayer);
			
			_panelLayer.structure=this;
			
			_mouseLayer.name = "_mouseLayer";
			stage.addChild(_mouseLayer);
//			CursorDecorator.getInstance().setLayer(_mouseLayer);
			
			this._chatLayer.mouseEnabled = false;
			this._tipLayer.mouseEnabled = false;
			this._panelLayer.mouseEnabled = false;
			this.mouseEnabled = false;
        }
		public function showDebug(bln:Boolean):void
		{
			for (var i:int = 0; i < this.numChildren; i++) 
			{
				var temp:* = this.getChildAt(i);
				if(temp is LayoutSprite)
				{
					temp.showPostion(bln);
				}
			}
			_mouseLayer.showPostion(bln);
			
		}
		public function get screenLayer():Sprite
		{
			return _screenLayer;	
		}
		
		public function get sceneUILayer():Sprite
		{
			return _sceneUILayer;
		}
		
		public function get panelLayer() : Popup
		{
			return this._panelLayer;
		}
		
		public function get alertLayer() : Sprite
		{
			return this._alertLayer;
		}

		public function get loadingLayer() : Sprite
		{
			return this._loadingLayer;
		}
		
		public function get chatLayer():Sprite{
			return this._chatLayer;
		}
		
/*		public function get tipLayer() : Tip
		{
			return this._tipLayer;
		}*/
		
		public function get mouseLayer() : Sprite
		{
			return this._mouseLayer;
		}
		
		public function get effectLayer() : Sprite
		{
			return this._effectLayer;
		}
		
		public function get newGuilderLayer():Sprite
		{
			return this._newGuilderLayer;
		}
		
		override public function get stage():Stage
		{
			return this._stage;
		}
		
        public function reposition() : void
        {
//			var offset:Point = stageOffset;
//			this.x = offset.x;
//			this.y = offset.y;
        }
		
        public  function get stageWidth() : Number
        {
//            return Math.max(ClientConstants.STAGE_NORMAL_WIDTH, Math.min(ClientConstants.STAGE_MAX_WIDTH, stage.stageWidth)) - stageClip.x;
//			return GameMathUtil.clamp(stage.stageWidth, ClientConstants.STAGE_MIN_WIDTH, ClientConstants.STAGE_MAX_WIDTH);
			return stage.stageWidth;
        }

        public  function get stageHeight() : Number
        {
//            return Math.max(ClientConstants.STAGE_NORMAL_HEIGHT, Math.min(ClientConstants.STAGE_MAX_HEIGHT, stage.stageHeight)) - stageClip.y;
//			return GameMathUtil.clamp(stage.stageHeight, ClientConstants.STAGE_MIN_HEIGHT, ClientConstants.STAGE_MAX_HEIGHT);
			return stage.stageHeight;
		}

		private var _satgeOffset:Point;
        public function get stageOffset() : Point
        {
//            var tempX:int = 0;
//            var tempY:int = 0;
//			
//            if (stage.stageWidth > ClientConstants.STAGE_MAX_WIDTH)
//            {
//				tempX = int((stage.stageWidth - ClientConstants.STAGE_MAX_WIDTH) * .5);
//            }
//            if (stage.stageHeight > ClientConstants.STAGE_MAX_HEIGHT)
//            {
//				tempY = int((stage.stageHeight -  ClientConstants.STAGE_MAX_HEIGHT) * .5);
//            }
//            return new Point(tempX, tempY);
			
			if(!_satgeOffset) _satgeOffset = new Point();
			return _satgeOffset;
        }

		private var _stageClip:Point;
		
        public  function get stageClip() : Point
        {
			if(!_stageClip) _stageClip = new Point();
			
//            var tempX:int = 0;
//            var tempY:int = 0;
//			
//            if (stage.stageWidth < ClientConstants.STAGE_NORMAL_WIDTH) {
//				tempX =  ClientConstants.STAGE_NORMAL_WIDTH - Math.max( ClientConstants.STAGE_MIN_WIDTH, stage.stageWidth);
//            }
//			
//            if (stage.stageHeight < ClientConstants.STAGE_NORMAL_HEIGHT){
//				tempY = ClientConstants.STAGE_NORMAL_HEIGHT - Math.max(ClientConstants.STAGE_MIN_HEIGHT,stage.stageHeight);
//            }
            return _stageClip;//new Point(tempX, tempY);
        }
		
		public function drawMark() : void
		{
//			drawBlack(-600, -200, 2500, 200);
//			drawBlack(1250, 0, 1000, 1000);
//			drawBlack(-600, 650, 2500, 200);
//			drawBlack(-1000, 0, 1000, 1000);
		}
		
/*		private function drawBlack(poxX:Number, poxY:Number, wid:Number, hei:Number) : void
		{
			//return;//?
			tipLayer.graphics.beginFill(0, 1);
			tipLayer.graphics.drawRect(poxX, poxY, wid, hei);
			tipLayer.graphics.endFill();
		}*/
		
//		public function switchMap(mapType:uint):void
//		{
//			return;
//		}
		//部分界面的render和close会交换_chatLayer和_panelLayer的层级关系，可能会有副作用，所以先注释一下
		public function swapChatPanelLayer():void
		{
			this.swapChildren(_panelLayer, _chatLayer);
		}
    }
}
