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

	public class Tanhuangmanager3 extends MovieClip
	{
		private var ballArr:Array;
		public static var distance:Number = 8;//静止距离;
		public static var zhendongDistance:Number = 40;
		private var timer:Timer ;
		public static var speed:Number = 2;
		public static var dSpeed:Number;
		public static var dTime:Number = 20;
		private var dx:Number ;
		private var settime:uint;
		public function Tanhuangmanager3()
		{
			super();
			ballArr = new Array();
			addBalls();
			dSpeed = speed/(zhendongDistance);//确定在zhendongDistance距离内将速度减为0;
			timer = new Timer(dTime);
			timer.addEventListener(TimerEvent.TIMER,enterframeHandler);
			//this.addEventListener(Event.ENTER_FRAME,enterframeHandler);
			startMove();
		}
		
		
		public function addBalls():void
		{
			for(var i:int = 0;i<80;i++)
			{
				var mc:BallMC3 = new BallMC3();
				mc.index = i;
				mc.y = 100;
				mc.x = i*distance+20;
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
			ballArr[0].currentSpeed = speed;
			//settime = setInterval(stopPower,dTime);
			timer.start();
		}
		private var jishi:int = 0;
		private function stopPower():void
		{
			jishi++;
			if(jishi>zhendongDistance/speed)
			{
				clearInterval(settime);
			}
			var ball:BallMC2 = ballArr[0];
			ball.currentSpeed = speed;
			ball.x +=speed;
		}
		public function enterframeHandler(e:TimerEvent):void
		{
			for(var i:int = 0;i<ballArr.length;i++)
			{
				ballArr[i].change(speed);
			}
			
			for(var i:int = 0;i<ballArr.length;i++)
			{
				ballArr[i].move();
			}
		}
	}
}