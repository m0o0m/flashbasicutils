package com.wg.ui.list
{
	import com.wg.ui.list.ItemRenderer;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.utils.getDefinitionByName;
	
	/**
	 * 
	 * @author RockyF
	 * E-mail:rockyf@126.com
	 * QQ:137806507
	 * 请保留原作者
	 */	
	public class List extends Sprite
	{
		private var _dataProvider:Array;
		private var itemRenderer:Class;
		
		private var bgPath:String;
		
		private var mWidth:int,mHeight:int;
		
		private var horizontalGap:int,verticalGap:int,rowHeight:int,colWidth:int;
		
		private var irArray:Array = new Array();
		
		public static var index:int = 0;
		
		public function List(dataProvider:Array,itemRenderer:String,bgPath:String = "",horizontalGap:int = 0,verticalGap:int = 0,rowHeight:int = 0, colWidth:int = 0)
		{
			this.horizontalGap = horizontalGap;
			this.verticalGap = verticalGap;
			this.rowHeight = rowHeight;
			this.colWidth = colWidth;
			this.mWidth = 200;
			this.mHeight = 10;
			this.bgPath = bgPath;
			
			this.itemRenderer = getDefinitionByName(itemRenderer) as Class;
			this.dataProvider = dataProvider;
		}

		public function get dataProvider():Array
		{
			return _dataProvider;
		}

		public function set dataProvider(value:Array):void
		{
			_dataProvider = value;
			if(value && itemRenderer != null) render();
		}

		public function render():void{
			drawBg();
			drawItems();
		}
		
		private function drawBg():void{
			/*if(bgPath != ""){
			var bg:Loader = new Loader();
			bg.load(new URLRequest(bgPath));
			this.addChild(bg);
			}*/
			
			graphics.clear();
			graphics.lineStyle(1,0x0);
			graphics.drawRect(0,0,mWidth,mHeight);
		}
		
		private function drawItems():void{
			var len:int = dataProvider.length;
			var ir:ItemRenderer = new itemRenderer(dataProvider,0);
			var col:int = Math.ceil(mWidth / (ir.width + horizontalGap));
			var row:int = Math.ceil(len / col);
			
			var realWidth:int = col * (ir.width + horizontalGap) - horizontalGap + colWidth;
			var realHeight:int = row * (ir.height + verticalGap) - verticalGap + rowHeight;
			
			var hGap:int,vGap:int;
			
			if(mWidth < realWidth){
				mWidth = realWidth;
				drawBg();
			}
			
			if(mHeight < realHeight){
				mHeight = realHeight;
				drawBg();
			}
			
			//移除所有ir
			for each(ir in irArray) this.removeChild(ir);
			irArray = new Array();
			
			for(var r:int = 0; r < row; r++){
				for(var c:int = 0; (c < col) && (r * col + c <= len); c++){
					if(c > 0) vGap = verticalGap; else vGap = 0;
					if(r > 0) hGap = horizontalGap; else hGap = 0;
					
					ir = new itemRenderer(dataProvider,r * col + c);
					ir.addEventListener(ListEvent.MOVE_ON_ITEM,function(event:ListEvent):void{
						var e:ListEvent = new ListEvent(ListEvent.MOVE_ON_ITEM);
						e.index = event.index;
						e.data = event.data;
						dispatchEvent(e);
					});
					ir.addEventListener(ListEvent.SELECTED_ITEM,function(event:ListEvent):void{
						var e:ListEvent = new ListEvent(ListEvent.SELECTED_ITEM);
						e.index = event.index;
						e.data = event.data;
						dispatchEvent(e);
					});
					
					ir.x = c * (ir.width + vGap) + colWidth;
					ir.y = r * (ir.height + hGap) + rowHeight;
					
					this.addChild(ir);
					irArray.push(ir);
				}
			}
		}
	}
}