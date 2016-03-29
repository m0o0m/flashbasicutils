package com.wg.scene.avtars.parts
{
	import com.wg.scene.avtars.BasicAvatar;
	import com.wg.schedule.IAnimatedObject;

	public interface IAvatarPart extends IAnimatedObject
	{
		function get owner():BasicAvatar;
		function setOwner(value:BasicAvatar):void;
		
		function get name():String;
		function set name(value:String):void;

		function get type():String;
		function set type(value:String):void;
		
		function get partIndex():int;
		function set partIndex(value:int):void;
		
		function dispose():void;
	}
}