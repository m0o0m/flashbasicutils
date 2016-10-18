package views.chat
{
	import flash.display.DisplayObject;

	public interface IBoxUpdateUI
	{
		public function IBoxUpdateUI();
		
		function set updateVisible(param1:Boolean) : void;
		
		function set onUpdate(param1:Function) : void;
		
		function get btnUpdate() : DisplayObject;
	}
}