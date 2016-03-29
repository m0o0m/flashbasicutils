package com.wg.ui.list
{
	import flash.events.Event;
	
	public class ListEvent extends Event
	{
		public static const MOVE_ON_ITEM:String = "MOVE_ON_ITEM";
		public static const SELECTED_ITEM:String = "SELECTED_ITEM";
		
		public var index:int;
		public var data:Object;
		
		public function ListEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}