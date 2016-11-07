package views.formula.hitest
{
	import flash.display.MovieClip;
	
	import views.formula.basicAnimate.BasicMC;

	public class HittestMC
	{
		public var content:MovieClip;
		private var _currentAnim:BasicMC;
		public function HittestMC(con:MovieClip)
		{
			content = con;
			init();
		}
		
		private function init():void
		{
			// TODO Auto Generated method stub
			var hittest:HitTest_Test = new HitTest_Test();
			content.addChild(hittest);
		}
	}
}