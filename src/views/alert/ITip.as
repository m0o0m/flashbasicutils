package views.alert
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	public interface ITip
	{
		
		
		function toString() : String;
		
		function get stageOffset() : Point;
		
		function set oParent(parentContainer:Sprite) : void;
		
		function get targets() : Dictionary;
		
		function addChild(childObj:DisplayObject) : DisplayObject;
		
		function addChildAt(childObj:DisplayObject, index:int) : DisplayObject;
		
		function addTarget(button:DisplayObject, tip:* = null, backStatus:Boolean = true) : void;
		
		function addTargetMoreTips(param1:DisplayObject, ... args) : void;
		
		function addFixedTarget(param1:DisplayObject, param2:*, param3:Point, param4:Boolean = true) : void;
		
		function removeTarget(param1:DisplayObject) : void;
		
		function updateTarget(target:DisplayObject = null) : void;
		
		function hide() : void;
		
		function clickToOpen(param1:*, param2:Event = null) : Sprite;
		
		function hideOpened() : void;
		
		function textTip(param1:DisplayObject, param2:String, param3:uint = 16776960) : void;
		
	}
}