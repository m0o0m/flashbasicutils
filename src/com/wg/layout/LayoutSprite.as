package com.wg.layout
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class LayoutSprite extends Sprite implements ISprite
	{
		private var _debugShow:Boolean;
		private var txt:TextField;
		private var index:int;
		public function LayoutSprite()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,addToStageHandler);
		}
		
		protected function addToStageHandler(event:Event):void
		{
			// TODO Auto-generated method stub
			index = this.parent.getChildIndex(this);
			createDisplyText();
		}
		
		public function get debugShow():Boolean
		{
			return _debugShow;
		}

		public function drawBg():void
		{
			
		}
		
		/**
		 * 显示位置;
		 * 
		 */
		public function showPostion(bln:Boolean):void
		{
			_debugShow = bln;
			txt.visible = _debugShow;
		}
		
		private function createDisplyText():void
		{
			if(txt)
			{
				return;
			}
			txt = new TextField();
			var textformat:TextFormat = new TextFormat();
			textformat.color = 0x000000;
			textformat.size = 16;
			txt.setTextFormat(textformat);
			txt.border = true;
			txt.background = true;
			txt.backgroundColor = 0xffffff;
			txt.text = "name:"+this.name+"  postion:"+index +" parent:"+this.parent.name;
//			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.width = txt.textWidth+5;
			txt.height = 70;
			txt.y = index*50;
			this.addChild(txt);
			txt.visible = _debugShow;
		}
	}
}