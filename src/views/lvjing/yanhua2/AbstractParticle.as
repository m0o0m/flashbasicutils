package views.lvjing.yanhua2
{
	public class AbstractParticle
	{
		public var speedX:Number;
		public var speedY:Number;
		public var accelerationY:Number;
		public var rotation:Number;
		public var alpha:Number;
		public var x:Number;
		public var y:Number;
		public var scaleX:Number;
		public var scaleY:Number;
		public var color:Number;
		public function AbstractParticle()
		{
		}
		public function move():void{}
		public function get finished():Boolean{return false;}
	}
}