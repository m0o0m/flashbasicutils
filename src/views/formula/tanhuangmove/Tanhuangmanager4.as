package views.formula.tanhuangmove
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.clearInterval;
	import flash.utils.clearTimeout;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import views.formula.basicAnimate.DrawLine;

	public class Tanhuangmanager4 extends MovieClip
	{
		private var ballArr:Array;
		public static var distance:Number = 100;//静止距离;
		public static var zhendongDistance:Number = 40;
		private var timer:Timer ;
		public static var speed:Number = 2;
		/**
		 *在 zhendongDistance的距离内,将speed减到0的平均值,speed是运动的每次时间间隔的平局值;
		 * dSpeed也是speed在每次时间间隔内减少或增加的平均值;在距离上,则是每次时间间隔在减少或增加;//加速度,相当于阻力或是推力;
		 */
		public static var dSpeed:Number;
		public static var dTime:Number = 20;
		private var dx:Number ;
		private var settime:uint;
		public static var ballNum:int = 5;
		public function Tanhuangmanager4()
		{
			super();
			ballArr = new Array();
			addBalls();
			dSpeed = speed/(zhendongDistance);//确定在zhendongDistance距离内将速度减为0;
			timer = new Timer(dTime);
			timer.addEventListener(TimerEvent.TIMER,enterframeHandler);
			//this.addEventListener(Event.ENTER_FRAME,enterframeHandler);
		}
		
		
		public function addBalls():void
		{
			for(var i:int = 0;i<=ballNum;i++)
			{
				var mc:BallMC4 = new BallMC4();
				mc.index = i;
				mc.y = 100;
				mc.x = i*distance;
				this.addChild(mc);
				ballArr.push(mc);
				
			}
			
			for(var j:int = 0;j<ballArr.length;j++)
			{
				if(j==0)
				{
					ballArr[j].lastMc = null;
					ballArr[j].nextMc = ballArr[j+1];
				}else if(j==ballArr.length-1)
				{
					ballArr[j].lastMc = ballArr[j-1];
					ballArr[j].nextMc = null;
				}else
				{
					ballArr[j].lastMc = ballArr[j-1];
					ballArr[j].nextMc = ballArr[j+1];
				}
			}
			trace(ballArr);
		}
		
		public function startMove():void
		{
			ballArr[0].currentSpeed = 20;
			ballArr[0].x +=0;
			timer.start();
		}
		public function enterframeHandler(e:TimerEvent):void
		{
			ballArr[0].change(speed);
			
			for(var i:int = 0;i<ballArr.length;i++)
			{
				ballArr[i].move();
			}
			drawData(ballArr[3]);
		}
		private  var  drawmc:MovieClip;
		private  var  drawmc2:MovieClip;
		/**
		 *画出某个球的运动数据; 
		 * @param mc
		 * 
		 */
		public function drawData(mc:MovieClip):void
		{
			//if(mc.index==3)
			{
				if(!drawmc){
					drawmc = DrawLine.drawSquareWithData(mc.distance1);
					drawmc.y = 300;
					mc.parent.addChild(drawmc);
				}else
				{
					DrawLine.drawSquareWithData(mc.distance1,drawmc);
				}
			}
			//if(mc.index==3)
			{
				if(!drawmc2){
					drawmc2 = DrawLine.drawSquareWithData(mc.distance2);
					drawmc2.y = 600;
					mc.parent.addChild(drawmc2);
					DrawLine.drawSimpleLine(drawmc2);
				}else
				{
					DrawLine.drawSquareWithData(mc.distance2,drawmc2);
				}
			}
		}
		public function dispose():void
		{
			// TODO Auto Generated method stub
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER,enterframeHandler);
			
			DrawLine.removeAllListener(drawmc);
			DrawLine.removeAllListener(drawmc2);
			
			drawmc = null;
			drawmc2 = null;
			this.removeChildren();
		}
	}
}