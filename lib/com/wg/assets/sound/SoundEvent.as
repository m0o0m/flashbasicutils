package com.wg.assist.sound
{
	import flash.events.Event;
	
	public static const SOUND_COMPLETE:String = "soundcomplete";
	public class SoundEvent extends Event
	{
		public function SoundEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}