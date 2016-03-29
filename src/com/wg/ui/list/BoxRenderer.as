package com.wg.ui.list
{
	import com.wg.ui.list.ItemRenderer;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;

	public class BoxRenderer extends ItemRenderer
	{
		public function BoxRenderer(dataSource:Array,index:int)
		{
			this.mWidth = 50;
			this.mHeight = 50;
			
			super(dataSource,index);
		}
		
		override public function drawItems():void{
			var bg:Loader = new Loader();
			bg.load(new URLRequest("assets/list/item2_single_bg.png"));
			addChild(bg);
			bg.contentLoaderInfo.addEventListener(Event.COMPLETE,function(event:Event):void{
			});
			
			var image:Loader = new Loader();
			image.load(new URLRequest("assets/list/icons/" + data.imgPath));
			image.contentLoaderInfo.addEventListener(Event.COMPLETE,function(event:Event):void{
				image.x = (width - image.content.width) / 2;
				image.y = (height - image.content.height) / 2;
				addChild(image);
			});
		}
	}
}