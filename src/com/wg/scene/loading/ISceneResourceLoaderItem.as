package com.wg.scene.loading
{
	import flash.events.IEventDispatcher;

	[Event(name="complete ", type="flash.events.Event")]
	public interface ISceneResourceLoaderItem extends IEventDispatcher
	{
		function load(modelURL:String):void;
	}
}