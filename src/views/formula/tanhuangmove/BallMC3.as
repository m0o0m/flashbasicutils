package views.formula.tanhuangmove
{
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	public class BallMC3 extends MovieClip
	{
		public static var Ball:Class;
		private var _index:int;//记录显示对象的索引
		private var _content:MovieClip;
		public var currentSpeed:Number = 0;//记录当前运动速度
		public var lastMc:BallMC3;//记录在前面的显示对象
		public var nextMc:BallMC3;//记录在后面的显示对象
		public var direction:Boolean;//记录速度的方向;
		private var lastSpeed:Number = Number.MAX_VALUE;//记录要传递给下一个显示对象的速度;
		private var moveCount:int;
		public function BallMC3()
		{
			super();
			_content  =new Ball();
			this.addChild(_content);
//			_content = this;
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

			if(currentSpeed==0){
				direction = !direction;
				Ydirection=!Ydirection;
			}else if(currentSpeed==2){
				direction = !direction;
			}
			if(index == 0)
			{
				if(currentSpeed>0&&direction)
				{
					currentSpeed -= Tanhuangmanager3.dSpeed;
				}else
				{
					currentSpeed += Tanhuangmanager3.dSpeed;
				}
				currentSpeed = Number(currentSpeed.toFixed(2));
				//trace(Tanhuangmanager3.dSpeed,currentSpeed);
				nextMc.currentSpeed = Tanhuangmanager3.speed - currentSpeed;
			}
			
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
				nextMc.currentSpeed = lastSpeed*(Ydirection?-1:1);
				nextMc.chuandiSpeed();
			}
			//trace(index,y);
		}
		private var Ydirection:Boolean = false;
		public function move():void
		{
			moveCount++;
			if(moveCount%8==0)
			{
				lastSpeed = currentSpeed;
			}
			this.y +=currentSpeed*(Ydirection?1:-1);
			this.x +=currentSpeed*(Ydirection?1:-1);
		}
		

	}
}