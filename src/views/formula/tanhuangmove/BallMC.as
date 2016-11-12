package views.formula.tanhuangmove
{
	import com.adobe.tvsdk.mediacore.ABRControlParameters;
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	public class BallMC extends MovieClip
	{
		public static var Ball:Class;
		private var _index:int;
		private var _content:MovieClip;
		public var currentSpeed:Number = 0;
		public var lastMc:BallMC;
		public var nextMc:BallMC;
		public var direction:int;
		public function BallMC()
		{
			super();
			_content  =new Ball();
			this.addChild(_content);
		}
		

		public function get index():int
		{
			return _index;
		}

		public function set index(value:int):void
		{
			_index = value;
			_content.txt.text = _index.toString();
		}
		
		public function change(dx:Number):void
		{
			var point0:Point = new Point(lastMc?lastMc.x:-1,lastMc?lastMc.y:-1);
			var point1:Point = new Point(this.x,this.y);
			var point2:Point = new Point(nextMc?nextMc.x:-1,nextMc?nextMc.y:-1);
			
			var distance1:Number = Point.distance(point0, point1);
			var distance2:Number = Point.distance(point1, point2);
			
			if(point0.x==-1&&point0.y ==-1)
			{
				distance1 = -1;
			}
			
			if(point2.x==-1&&point2.y ==-1)
			{
				distance2 = -1;
			}
			trace(distance1,distance2);
			var tempSpeed:Number = 0;
			//算法有问题,不能模拟
			var tempbili:Number = (distance1 - Tanhuangmanager.distance)/(Math.abs(distance2 - Tanhuangmanager.distance)+Math.abs(distance1 - Tanhuangmanager.distance));
			if(distance1>0)
			{
				if(distance1>Tanhuangmanager.distance)
				{
					currentSpeed += 0-(distance1 - Tanhuangmanager.distance)/Tanhuangmanager.zhendongDistance*Tanhuangmanager.speed;
					lastMc.currentSpeed += -currentSpeed*Math.abs(tempbili);
				}
				
				if(distance1<Tanhuangmanager.distance)
				{
					currentSpeed += -(distance2 - Tanhuangmanager.distance)/Tanhuangmanager.zhendongDistance*Tanhuangmanager.speed;
					if(nextMc)nextMc.currentSpeed += -currentSpeed*Math.abs(1-tempbili);
				}
				
			}
			if(distance2>111111110)
			{
				if(distance2>Tanhuangmanager.distance)
				{
					
				}
				if(distance2<Tanhuangmanager.distance)
				{
					currentSpeed += -(distance2 - Tanhuangmanager.distance)/Tanhuangmanager.zhendongDistance*Tanhuangmanager.speed;
					nextMc.currentSpeed += -currentSpeed*Math.abs(1-tempbili);
				}
			}
			
			/*if(distance1>0)
			{
				tempSpeed = -(distance1 - Tanhuangmanager.distance)*Tanhuangmanager.dSpeed/2;
			}
			if(distance2>0)
			{
				tempSpeed =tempSpeed + (distance2 - Tanhuangmanager.distance)*Tanhuangmanager.dSpeed/2;
			}*/
			
			//在距离之间只有推和拉之间的区别,距离的大小不影响传送的速度是恒定的;
			/*if(distance1>0)//
			{
				if(distance1>Tanhuangmanager.distance)
				{
					tempSpeed = tempSpeed - dx;//-(tempSpeed+distance1 - Tanhuangmanager.distance)/Tanhuangmanager.zhendongDistance;
				}else if(distance1<Tanhuangmanager.distance){
					tempSpeed =tempSpeed+dx; //(tempSpeed+distance1 - Tanhuangmanager.distance)/Tanhuangmanager.zhendongDistance;
				}
			}else{
//				distance1 = dx;
			}
			
			if(distance2>0)//
			{
				if(distance2>Tanhuangmanager.distance)
				{
					tempSpeed = tempSpeed + dx;//-(tempSpeed+distance1 - Tanhuangmanager.distance)/Tanhuangmanager.zhendongDistance;
				}else{
					tempSpeed =tempSpeed - dx; //(tempSpeed+distance1 - Tanhuangmanager.distance)/Tanhuangmanager.zhendongDistance;
				}
			}*/
			
			//currentSpeed = tempSpeed;
		}
		
		public function move():void
		{
			this.x +=currentSpeed;
		}
		

	}
}