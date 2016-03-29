package com.wg.ui.list
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class ItemRenderer extends Sprite
	{
		private var dataSource:Array;
		private var _data:Object;
		private var index:int;
		public var mWidth:int,mHeight:int;
		
		public function ItemRenderer(dataSource:Array,index:int)
		{
			this.index = index;
			this.dataSource = dataSource;
			this.data = dataSource[index];
			
			addEventListener(MouseEvent.ROLL_OVER,onMouseMove);
			addEventListener(MouseEvent.CLICK,onMouseClick);
		}
		
		private function onMouseMove(event:Event):void{
			var e:ListEvent = new ListEvent(ListEvent.MOVE_ON_ITEM);
			e.index = index;
			e.data = data;
			this.dispatchEvent(e);
		}
		
		private function onMouseClick(event:Event):void{
			var e:ListEvent = new ListEvent(ListEvent.SELECTED_ITEM);
			List.index = index;
			e.index = List.index;
			e.data = data;
			this.dispatchEvent(e);
		}

		public function get data():Object
		{
			return _data;
		}

		public function set data(value:Object):void
		{
			_data = value;
			
			if(data) render();
		}
		
		public function render():void{
			drawBg();
			drawItems();
		}
		
		public function drawBg():void{
			graphics.beginFill(0x0,0);
			graphics.drawRect(0, 0, mWidth, mHeight);
			graphics.endFill();
		}
		
		public function drawItems():void{
		}
	}
}