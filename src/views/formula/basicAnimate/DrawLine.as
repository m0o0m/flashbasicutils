package views.formula.basicAnimate
{
	import flash.display.Sprite;
	import flash.events.Event;

	public class DrawLine
	{
		public function DrawLine()
		{
		}
		public static function DrawSinLine(long:Number = 360):Sprite
		{
			var sprite:Sprite = new Sprite();
			var x:Number = 0;
			var y:Number = 0;
			sprite.graphics.lineStyle(1,0xff0000);
			sprite.graphics.moveTo(x,y);
			sprite.addEventListener(Event.ENTER_FRAME,drawLineHandler);
			
			
			return sprite;
			
			static function drawLineHandler(e:Event):void
			{
				sprite.graphics.moveTo(x,y);
				x = x+10;//画线的细腻程度
				y = Math.sin(x*(Math.PI/180))*50;//振幅
				sprite.graphics.lineTo(x,y);
				if(x>=long)
				{
					sprite.removeEventListener(Event.ENTER_FRAME,drawLineHandler);
				}
			}
		}
		public static function DrawPaowuLine(long:Number =100):Sprite
		{
			var sprite:Sprite = new Sprite();
			var x:Number = 0;
			var y:Number = 0;
			var a:Number = 0.1;//a > 0时开口向上 a < 0时开口向下  a不等于0;
			var b:Number = 2;//b = 0时抛物线对称轴为y轴
			var c:Number = 0;//c = 0时抛物线经过原点 
			var d:Number = 0;//(x - d)²
			//顶点计算 x = -b/2a; y=(4ac-b²)/(4a); 
			sprite.graphics.lineStyle(1,0xff0000);
			sprite.graphics.moveTo(x,y);
			sprite.addEventListener(Event.ENTER_FRAME,drawLineHandler);
			return sprite;
			
			static function drawLineHandler(e:Event):void
			{
				sprite.graphics.moveTo(x,y);
				x = x+1;//画线的细腻程度
				y = a*Math.pow(x,2)+b*x+c;//
				sprite.graphics.lineTo(x,y);
				if(x>=long)
				{
					sprite.removeEventListener(Event.ENTER_FRAME,drawLineHandler);
				}
			}
		}
		public static function DrawFreefallLine(long:Number = 60):Sprite
		{
			var sprite:Sprite = new Sprite();
			var x:Number = 0;
			var y:Number = 0;
			var v:Number = 20;//水平移动速度
			var g:Number = 0.98;//加速度
			var h:Number = 0;//下落高度
			var runTime:Number = 0;
			sprite.graphics.lineStyle(1,0xff0000);
			sprite.graphics.moveTo(x,y);
			sprite.addEventListener(Event.ENTER_FRAME,drawLineHandler);
			
			
			return sprite;
			
			static function drawLineHandler(e:Event):void
			{
				runTime++;
				sprite.graphics.moveTo(x,y);
				x = x+v;
				y = h = g*Math.pow(runTime,2)/2;
				sprite.graphics.lineTo(x,y);
				if(runTime>=long)
				{
					sprite.removeEventListener(Event.ENTER_FRAME,drawLineHandler);
				}
			}
		}
		
	}
}