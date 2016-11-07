package
{
	import flash.display.*;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import flash.ui.Keyboard;
	import flash.filters.GlowFilter;
	
	public class g extends Sprite
	{
		var per_mc:MovieClip;
		var leftkeyStatus:Boolean;
		var rightkeyStatus:Boolean;
		var bmp:BitmapData;
		var speen:uint = 20;
		public function g()
		{
			var d:Sprite = new dimian(); //加载矢量图片
			bmp = new BitmapData(d.width, d.height, true, 0); //根据矢量图片创建一个空的透明位图数据区
			bmp.draw(d); //在位图区内绘制矢量数据
			var showobj:Bitmap = new Bitmap(bmp); //创建位图
			showobj.smoothing = true
			showobj.filters=[new GlowFilter(0, 1, 2, 2, 8, 1)] 
			addChild(showobj); //显示位图到舞台

			//var t:int = getTimer();
			var step1:Point, step2:Point;
			//var initxy:uint = 696;
			var initxy:uint = 0;
			
			for (var x:uint = 0; x < bmp.width; x += speen){
				for (var y:uint = 0; y < bmp.height; y += 1) {
					if (bmp.getPixel32(x, y) != 0 && bmp.getPixel32(x, y - 1) == 0) {
						if (x == initxy) { step1 = new Point(x, y) }
						if (x == initxy + speen) { step2 = new Point(x, y) }
						//bmp.setPixel32(x, y, 0xFFFF0000);
					}
					if (step1 != null && step2 != null) { break };
				}
				if (step1 != null && step2 != null) { break };
			}
			
			per_mc = new person();
			addChild(per_mc);
			per_mc.gotoAndStop(1);
			per_mc.x = x;
			per_mc.y = y + 2;
			
			var angle = Math.atan2(Math.abs(step1.y - step2.y), Math.abs(step1.x - step2.x)) / Math.PI * 180;
			//如果角度大于水平线上方（开角度从圆点至水平右方向处开角，顺时针）
			if (step1.y > step2.y) { angle = 360 - angle }
			per_mc.rotation = angle;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keydown );
			stage.addEventListener(KeyboardEvent.KEY_UP, keyup);
			addEventListener(Event.ENTER_FRAME, movePerson);
			//trace(angle)
			
			addChild(point1_mc);
			addChild(point2_mc);
		}
		
		function keydown(e:KeyboardEvent) {
			if (e.keyCode == Keyboard.LEFT || e.keyCode == Keyboard.RIGHT) { per_mc.gotoAndStop(2) }
			if (e.keyCode == Keyboard.LEFT) {leftkeyStatus = true; rightkeyStatus = false;}
			if (e.keyCode == Keyboard.RIGHT) {leftkeyStatus = false; rightkeyStatus = true;}
		}
		
		function keyup(e:KeyboardEvent) { 
			if (e.keyCode == Keyboard.LEFT || e.keyCode == Keyboard.RIGHT) { per_mc.gotoAndStop(1) }
			if (e.keyCode == (Keyboard.LEFT)) {leftkeyStatus = false;}
			if (e.keyCode == (Keyboard.RIGHT)) {rightkeyStatus = false;}
		}
		
		function movePerson(e:Event) {
			if (rightkeyStatus) {
				//rightkeyStatus = false;
				//if (per_mc.x + per_mc.width / 2 >= stage.stageWidth) { return }
				var step1:Point = new Point(per_mc.x, per_mc.y-2);
				var step2:Point = new Point(per_mc.x + speen, 0);
				trace(step1,step2);
				point1_mc.x = step1.x;
				point1_mc.y = step1.y;
				
				point2_mc.x = step2.x;
				point2_mc.y = step2.y;
				
				var y:uint
				for (y = 0; y < bmp.height; y += 1) {
					//&& Math.abs()
					if (bmp.getPixel32(step2.x, y) != 0 && bmp.getPixel32(step2.x, y - 1) == 0) {
						step2.y = y;break;
					}
				}
				var angle = Math.atan2(Math.abs(step1.y - step2.y), Math.abs(step1.x - step2.x)) / Math.PI * 180;
				if (step1.y > step2.y) { angle = 360 - angle }

				step2 = new Point(per_mc.x + 2.5, 0);
				for (y= 0; y < bmp.height; y += 1) {
					//&& Math.abs()
					if (bmp.getPixel32(step2.x, y) != 0 && bmp.getPixel32(step2.x, y - 1) == 0) {
						step2.y = y;break;
					}
				}
				per_mc.x = step2.x;
				per_mc.y = step2.y + 2;
				per_mc.rotation = angle*1;
				
				//trace(step1,step2,angle);
				//
			}			
		}
		
	}
}
