package mymvc.views
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class TestCompent extends Sprite
	{
		private var content:MovieClip;
		public function TestCompent(cont:MovieClip)
		{
			content = cont;
			this.addChild(content);
			super();
		}
	}
}