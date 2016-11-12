package views.formula.basicAnimate
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	public class DrawLine
	{
		public function DrawLine()
		{
		}
		/**
		 *正弦函数 
		 * @param long
		 * @return 
		 * 
		 */
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
		public static function drawSquareWithData(data:Number,drawmc:MovieClip = null):MovieClip
		{
			var width:Number = 5;
			if(!drawmc)
			{
				drawmc = new MovieClip();
				drawmc.graphics.lineStyle(1,0xff0000);
				drawmc.nowPoint = 0;
			}
			drawmc.nowPoint +=width; 
			drawmc.graphics.drawRect(drawmc.nowPoint,0,width,data);
			return drawmc;
			
		}
		private static var  listenerArr:Array = new Array();
		public static function addEventListener(mc:MovieClip,type:String,func:Function):void
		{
			var tempArr:Array = new Array(3);
			tempArr[0] = mc;
			tempArr[1] = type;
			tempArr[2] = func;
			mc.addEventListener(type,func);
			listenerArr.push(tempArr);
		}
		public static function removeAllListener(mc:MovieClip):void
		{
			for(var i:int =0;i<listenerArr.length;i++)
			{
				if(listenerArr[i][0]==mc)
				{
					mc.removeEventListener(listenerArr[i][1],listenerArr[i][2]);
				}
			}
		}
		
		public static function drawSimpleLine(mc:MovieClip):void
		{
			if(!mc.verticalLine){
				var sprite:Sprite = new Sprite();
				sprite.graphics.lineStyle(1,0x00ff00);
				
				sprite.graphics.moveTo(0,-300);
				sprite.graphics.lineTo(0, 300);
				mc.verticalLine  =sprite;
				mc.addChild(sprite);
			}
			addEventListener(mc,Event.ENTER_FRAME,lineFollow);
		}
		
		private static function lineFollow(e:Event):void
		{
			var mc:MovieClip =e.currentTarget as MovieClip; 
			trace("=================================================");
			if(!mc.stage) return;
			var temppoint:Point = mc.globalToLocal(new Point(mc.stage.mouseX,mc.stage.mouseY));
			mc.verticalLine.x = temppoint.x;
			mc.verticalLine.y = temppoint.y;
		}
		
	}
}