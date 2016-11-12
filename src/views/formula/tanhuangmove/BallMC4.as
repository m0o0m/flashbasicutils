package views.formula.tanhuangmove
{
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	import views.formula.basicAnimate.DrawLine;
	
	/**
	 *
	 * 通过距离的测量,确定速度;然后通过速度的变化和运行,影响距离;
	 * 但是实际情况应该是,只有速度的传递,距离只是一种速度传递的表现;
	 * 
	 * 在不同的距离范围内,斥力和引力的大小是不同的,两个物体间的距离不会小于0,也不会大于某个临界值;
	 * 
	 * 速度传递是一个累积过程;一个物体的速度累积增大,那么另外一个物体则累积减小
	 */
	public class BallMC4 extends MovieClip
	{
		public static var Ball:Class;
		private var _index:int;//记录显示对象的索引
		private var _content:MovieClip;
		public var currentSpeed:Number = 0;//记录当前运动速度
		public var lastMc:BallMC4;//记录在前面的显示对象
		public var nextMc:BallMC4;//记录在后面的显示对象
		public var direction:Boolean;//记录速度的方向;
		private var lastSpeed:Number = Number.MAX_VALUE;//记录要传递给下一个显示对象的速度;
		private var moveCount:int;
		public function BallMC4()
		{
			super();
			_content  =new Ball();
			this.addChild(_content);
		}
		

		public function get distance2():Number
		{
			return _distance2;
		}

		/**
		 * 
		 */
		public function get distance1():Number
		{
			return _distance1;
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
		private function changeDirection():void
		{
			//运动速度在0-2之间,但有加速和减速两个阶段;初始值是1.99;direction=false;
			if(lastSpeed!=Number.MAX_VALUE)
			{
				var temps:Number = (currentSpeed-lastSpeed);
				if(currentSpeed>2&&temps>0 || currentSpeed<-2&&temps<0)
				{
					direction = !direction;
					trace("mc1.direction:",direction);
				}
			}
		}
		/**
		 *
		 * @param dx
		 * 
		 */
		public function change(dx:Number):void
		{

			
			
			var point1:Point = new Point(this.x,this.y);
			var point2:Point = new Point(nextMc?nextMc.x:-1,nextMc?nextMc.y:-1);
			var distance1:Number =(Point.distance(point1, point2) - Tanhuangmanager4.distance);
				changeDirection();
				//Tanhuangmanager4.distance 在这个位置时,速度必然为零;
				currentSpeed += (distance1)*Tanhuangmanager4.dSpeed;
				//currentSpeed = Number(currentSpeed.toFixed(2));
				trace(Tanhuangmanager4.dSpeed,currentSpeed);
			
			chuandiSpeed();
		}
		private var _distance1:Number;
		private var _distance2:Number;
		public function chuandiSpeed():void
		{
			//move();
			if(nextMc)
			{
				var point0:Point = new Point(lastMc?lastMc.x:-1,lastMc?lastMc.y:-1);
				var point1:Point = new Point(this.x,this.y);
				var point2:Point = new Point(nextMc?nextMc.x:-1,nextMc?nextMc.y:-1);
				var point3:Point = new Point(nextMc.nextMc?nextMc.nextMc.x:-1,nextMc.nextMc?nextMc.nextMc.y:-1);
				
				_distance1 = -(Point.distance(point1, point2) - Tanhuangmanager4.distance);
				_distance2 = (Point.distance(point2, point3) - Tanhuangmanager4.distance);
				//distance1 = Number(distance1.toFixed(2));
				//distance2 = Number(distance2.toFixed(2));
				//画出第四个球的运动轨迹
				
				if(point3.x==-1)
				{
					
//					if(lastSpeed!=Number.MAX_VALUE)
					{
						nextMc.currentSpeed += (distance1)*Tanhuangmanager4.dSpeed;
					}
				}else
				{
//					if(lastSpeed!=Number.MAX_VALUE)
					{
						nextMc.currentSpeed +=  distance1*Tanhuangmanager4.dSpeed+distance2*Tanhuangmanager4.dSpeed;
					}
				}
				//nextMc.currentSpeed = Tanhuangmanager4.speed - nextMc.currentSpeed;
				//nextMc.currentSpeed =  Number(nextMc.currentSpeed.toFixed(2));
				nextMc.chuandiSpeed();
				//trace(index,x);
			}
			
		}
		
		public function move():void
		{
			moveCount++;
			//if(moveCount%8==0)
			{
				lastSpeed = currentSpeed;
			}
			this.x +=currentSpeed;
		}
		public function dispose():void
		{
		}
		
	}
}