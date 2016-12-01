package views
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import views.lvjing.Juanji;
	import views.lvjing.yanhua.Yanhua;
	import views.lvjing.yanhua2.Fireworks;
	import views.lvjing.yanhua3.Fireworks3;
	import views.lvjing.yanhua4.Fireworks4;

	public class LvJingView extends ViewBase
	{
		public function LvJingView()
		{
			panelName = "lvjingComp";
			super();
		}
		override protected function render():void
		{
			if(!content)
			{
				var maincls:Class = Config.resourceLoader.getClass(panelName);
				content = new maincls();
				this.addChild(content);
				content.mc1.visible = false;
			}
			content.btn1.addEventListener(MouseEvent.CLICK,juanjiHandler);
			content.btn2.addEventListener(MouseEvent.CLICK,yanhuaHandler);
			content.btn3.addEventListener(MouseEvent.CLICK,yanhua2Handler);
			content.btn4.addEventListener(MouseEvent.CLICK,yanhua3Handler);
			super.render();
			
		}
		
		private var juanji:Juanji;
		protected function juanjiHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			reset();
			if(!juanji) juanji = new Juanji(content);
		}
		private var yanhua:Yanhua;
		protected function yanhuaHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			reset();
			if(!yanhua) yanhua = new Yanhua(content.scene_mc);
		}
		private var yanhua2:Fireworks4;
		protected function yanhua2Handler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			reset();
			if(!yanhua2) yanhua2 =new Fireworks4(content.scene_mc);
		}
		
		private var yanhua3:Fireworks3;
		protected function yanhua3Handler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			reset();
			if(!yanhua3) yanhua3 = new Fireworks3(content.scene_mc);
		}
		private function reset():void
		{
			if(juanji)
			{
				juanji.reset();
				juanji = null;
			}
			if(yanhua)
			{
				yanhua.reset();
				yanhua = null;
			}
			if(yanhua2)
			{
				yanhua2.reset();
				yanhua2 = null;
			}
			
			if(yanhua3)
			{
				yanhua3.reset();
				yanhua3 = null;
			}
			content.scene_mc.removeChildren();
		}
		
		override protected function dispose():void
		{
			
			content.btn1.removeEventListener(MouseEvent.CLICK,juanjiHandler);
			content.btn2.removeEventListener(MouseEvent.CLICK,yanhuaHandler);
			content.btn3.removeEventListener(MouseEvent.CLICK,yanhua2Handler);
			content.btn4.removeEventListener(MouseEvent.CLICK,yanhua3Handler);
		}
	}
	
}