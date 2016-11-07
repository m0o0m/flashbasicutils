package views.formula.basicAnimate
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;

	public class XuanZhuan extends BasicMC
	{
		private var leftArrow:Boolean, rightArrow:Boolean, upArrow: Boolean;
		public function XuanZhuan()
		{
			super();
		}
		override public function excute(con:MovieClip):void
		{
			super.excute(con);
			MovingCar();
		}
		
		private function MovingCar():void {
			
			// move every frame
			_content.addEventListener(Event.ENTER_FRAME, moveCar);
			
			// respond to key events
			_content.stage.addEventListener(KeyboardEvent.KEY_DOWN,keyPressedDown);
			_content.stage.addEventListener(KeyboardEvent.KEY_UP,keyPressedUp);
		}
		
		// set arrow variables to true
		private function keyPressedDown(event:KeyboardEvent):void {
			if (event.keyCode == 37) {
				leftArrow = true;
			} else if (event.keyCode == 39) {
				rightArrow = true;
			} else if (event.keyCode == 38) {
				upArrow = true;
			}
		}
		
		// set arrow variables to false
		private function keyPressedUp(event:KeyboardEvent):void {
			if (event.keyCode == 37) {
				leftArrow = false;
			} else if (event.keyCode == 39) {
				rightArrow = false;
			} else if (event.keyCode == 38) {
				upArrow = false;
			}
		}
		
		// turn or move car forward
		/**
		 *每帧运动 
		 * @param event
		 * 
		 */
		private function moveCar(event:Event):void {
			if (leftArrow) {
				_content.rotation -= 5;
			}
			if (rightArrow) {
				_content.rotation += 5;
			}
			if (upArrow) {
				moveForward();
			}
		}
		
		// calculate x and y speed and move car
		/**
		 *匀速运动 
		 * 
		 */
		private  function moveForward():void {
			var speed:Number = 5.0;
			var angle:Number = 2*Math.PI*(_content.rotation/360);
			var dx:Number = speed*Math.cos(angle);
			var dy:Number = speed*Math.sin(angle);
			_content.x += dx;
			_content.y += dy;
		}
		override public function destroy():void
		{
			_content.removeEventListener(Event.ENTER_FRAME, moveCar);
			// respond to key events
			_content.stage.removeEventListener(KeyboardEvent.KEY_DOWN,keyPressedDown);
			_content.stage.removeEventListener(KeyboardEvent.KEY_UP,keyPressedUp);
		}
	}
}