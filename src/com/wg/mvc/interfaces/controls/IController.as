package com.wg.mvc.interfaces.controls
{

	public interface IController
	{
		function registerMessageHandler(event:String, handler:Function = null) : void;
		function registerDataEventHandler(event:String, handler:Function) : void;
		function registerViewEventHandler(event:String, handler:Function = null) : void;
		function excute(commandname:String,data:* = null):void;
	}
}