package com.wg.assets.sound
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;

	public class SoundManager
	{
		private static var _instance:SoundManager;
		/**
		 *加入sound对象后不删除; 
		 */
		private var soundArr:Array;
		private var soundNameArr:Array;
		public function SoundManager()
		{
			if(!_instance)
			{
				
			}else
			{
				throw new Error("只有一个实例...");
			}
			init();
			
		}
		public static function get instance():SoundManager
		{
			if(!_instance)
			{
				_instance = new SoundManager();
			}
			return _instance;
		}
		
		private function init():void
		{
			channelDic = new Dictionary();
			soundArr = new Array();
			soundNameArr = new Array();
		}
		
		/**
		 *存储回调函数的字典; 
		 */
		private var channelDic:Dictionary;
		/**
		 *播放一次,播放完毕执行回调函数; 
		 * @param resource
		 * @param soundName
		 * @param func
		 * 
		 */
		public function playSound(resource:Sound,soundName:String,func:Function = null):void
		{
			soundNameArr[soundNameArr.length] = soundName;
			var soundChannel:SoundChannel = resource.play();
			soundArr[soundName] = [resource,soundChannel];
			channelDic[soundChannel] = func;
			if(soundChannel) soundChannel.addEventListener(Event.SOUND_COMPLETE,onSoundComplete);
		}
		
		public function removeSound(soundName:String):void
		{
			if(soundArr[soundName]&&soundArr[soundName][1])
			{
				(soundArr[soundName][1] as SoundChannel).removeEventListener(Event.SOUND_COMPLETE,onSoundComplete);
				delete  channelDic[soundArr[soundName][1]];
				soundArr[soundName] = null;
			}
			
		}
		/**
		 *循环播放; 
		 * @param soundName
		 * 暂无回调函数;
		 */		
		public function play(soundName:String):void
		{
			if(soundArr[soundName]&&soundArr[soundName][0])
			{
				soundArr[soundName][1] = (soundArr[soundName][0] as Sound).play();
				soundArr[soundName][1].addEventListener(Event.SOUND_COMPLETE,onSoundrepeatComplete);
			}
		}
		protected function onSoundrepeatComplete(event:Event):void
		{
			(event.target as SoundChannel).removeEventListener(Event.SOUND_COMPLETE,onSoundComplete);
//			delete  channelDic[event.target];
			
			for (var i:int = 0; i < soundNameArr.length; i++) 
			{
				if(soundArr[soundNameArr[i]][1] == event.target)//如果能将声音名称传入,更加方便,不用再遍历;
				{
					soundArr[soundNameArr[i]][1] = (soundArr[soundNameArr[i]][0] as Sound).play();
					soundArr[soundNameArr[i]][1].addEventListener(Event.SOUND_COMPLETE,onSoundrepeatComplete);
				}
			}
			
		}
		
		protected function onSoundComplete(event:Event):void
		{
			// TODO Auto-generated method stub
			if(channelDic[event.target]) channelDic[event.target](); 
			(event.target as SoundChannel).removeEventListener(Event.SOUND_COMPLETE,onSoundComplete);
			delete  channelDic[event.target];
		}
		
		public function stopSound(soundName:String):void
		{
			if(soundArr[soundName]&&soundArr[soundName][1])
			{
				(soundArr[soundName][1] as SoundChannel).stop();
			}
		}
		
		/**
		 *设置某个声音的音量大小; 
		 * @param soundName
		 * @param nums  0--1;
		 * 
		 */
		public function soundVolume(soundName:String,nums:int):void
		{
			if(soundArr[soundName]&&soundArr[soundName][1])
			{
				var soundtrs:SoundTransform = (soundArr[soundName][1] as SoundChannel).soundTransform;
				soundtrs.volume = nums;
			}
		}
		
		/**
		 *设置全局的声音音量; 
		 * @param nums
		 * 
		 */
		public function globalSoundVolume(nums:int):void
		{
			var soundTrans:SoundTransform = new SoundTransform();
			
			
			soundTrans.volume = nums;
			SoundMixer.soundTransform = soundTrans;
		}
	}
}