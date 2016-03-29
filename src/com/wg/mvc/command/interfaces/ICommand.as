package com.wg.mvc.command.interfaces
{
	public interface ICommand
	{
		function notifyEvent(event:*, data:*=null) : void;
		function excute(data:* = null):void
		function getData():*;
	}
}