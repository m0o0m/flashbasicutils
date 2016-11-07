package views.formula.basicAnimate
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class BasicAnmateMC
	{
		public var content:MovieClip;
		private var _currentAnim:BasicMC;
		public function BasicAnmateMC(con:MovieClip)
		{
			content = con;
			init();
		}
		private function init():void
		{
			content.btns_mc.addEventListener(MouseEvent.CLICK,onClickHander);
		}
		private function onClickHander(e:MouseEvent):void
		{
//			trace(e.target.label);
			if(_currentAnim) _currentAnim.destroy();
			switch(e.target.label)
			{
				case "旋转":
					_currentAnim = new XuanZhuan();
					break;
				case "抛物线":
					var mc:Sprite = DrawLine.DrawFreefallLine();
					mc.y = 100;
					content.addChild(mc);
					break;
			}
			if(_currentAnim) _currentAnim.excute(content.car);
		}
	}
}