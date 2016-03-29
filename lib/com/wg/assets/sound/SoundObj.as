package com.wg.assets.sound
{
	import flash.media.Sound;

	public class SoundObj extends Object
	{
		public var soundName:String;
		private var _sound:Sound;
		public function SoundObj(name:String,sound:Sound)
		{
			soundName = name;
			_sound = sound;
		}
	}
}