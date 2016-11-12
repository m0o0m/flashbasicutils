package views.formula.tanhuangmove
{
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	/**
	 *模拟有能量补充的速度模仿(模仿蛇头)
	 * 速度传递的延迟性
	 * 时间的分割性
	 * 数据的跃迁变化
	 * 运动的超前考虑,数据的超前计算,跃迁赋值,然后等待展现; 
	 * @author Administrator
	 * 
	 * 连锁反应:
	 * 将源物体的上一个时间点的数据根据算法,传递给当前时间点的目标物体,并展现;
	 * 
	 * 运动的阶段性,重复性,区域性;
	 */
	public class BallMC2 extends MovieClip
	{
		public static var Ball:Class;
		private var _index:int;//记录显示对象的索引
		private var _content:MovieClip;
		public var currentSpeed:Number = 0;//记录当前运动速度
		public var lastMc:BallMC2;//记录在前面的显示对象
		public var nextMc:BallMC2;//记录在后面的显示对象
		public var direction:Boolean;//记录速度的方向;
		private var lastSpeed:Number = Number.MAX_VALUE;//记录要传递给下一个显示对象的速度;
		private var moveCount:int;
		public function BallMC2()
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

			
				//运动速度在0-2之间,但有加速和减速两个阶段;
				if(currentSpeed<=0||currentSpeed>=2){//如果超过这个范围,改变方向;
					direction = !direction;
				}
				if(direction)
				{
					currentSpeed -= Tanhuangmanager2.dSpeed;
				}else
				{
					currentSpeed += Tanhuangmanager2.dSpeed;
				}
				currentSpeed = Number(currentSpeed.toFixed(2));
				trace(Tanhuangmanager2.dSpeed,currentSpeed);
				nextMc.currentSpeed = Tanhuangmanager2.speed - currentSpeed;
			
			chuandiSpeed();
			
		}
		/**
		 *确定传递速度,传递前一帧的速度还是传递n帧前的速度; 
		 * 
		 */
		public function chuandiSpeed():void
		{
			if(!nextMc) return;
			if(lastSpeed!=Number.MAX_VALUE)
			{
				nextMc.currentSpeed = lastSpeed;
				nextMc.chuandiSpeed();
			}
			trace(index,x);
		}
		
		public function move():void
		{
			moveCount++;
			if(moveCount%8==0)
			{
				lastSpeed = currentSpeed;
			}
			this.x +=currentSpeed;
		}
		

	}
}