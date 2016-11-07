package views.utils
{
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.events.MouseEvent;

	public class Tuozhuai extends MovieClip
	{
		private var vase:MovieClip;//花瓶
		private var desk:MovieClip;//桌子
		/**
		 *拖拽 操作
		 * startDrag(false,rect);设定拖拽范围和拖拽物品的坐标是否跟鼠标一致
		 */		
		public function Tuozhuai()
		{
			super();
			vase.addEventListener(MouseEvent.MOUSE_DOWN,dragVase);
			vase.addEventListener(MouseEvent.MOUSE_UP,dropVase);
			desk.addEventListener(MouseEvent.MOUSE_DOWN,dragBoth);
			desk.addEventListener(MouseEvent.MOUSE_UP,dropBoth);
		}
		
		//这个自定义函数用来输出每个对象所在的位置。
		private function showPosition():void {
			trace("花瓶的位置是："+int(vase.x)+","+int(vase.y));
			trace("桌子的位置是："+int(desk.x)+","+int(desk.y));
			trace("桌子和花瓶的位置是："+int(x)+","+int(y));
		}
		private function dragVase(evt:MouseEvent):void {
			var rect:Rectangle=
				new Rectangle(desk.x+vase.width/2,desk.y,
					desk.width-vase.width,0)
			vase.startDrag(false,rect);
		}
		private function dropVase(evt:MouseEvent):void {
			vase.stopDrag();
			showPosition();
		}
		private function dragBoth(evt:MouseEvent):void {
			this.startDrag();
		}
		private function dropBoth(evt:MouseEvent):void {
			this.stopDrag();
			showPosition();
		}
		
	}
}