/*
* Copyright(c) 2011 the original author or authors.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
* either express or implied. See the License for the specific language
* governing permissions and limitations under the License.
*/
package views.live
{
	import com.ql.gameKit.extensions.video.VideoVO;
	
	import flash.media.Video;
	
	/**
	 * 视讯播放设定
	 * @author FF
	 */
	public class VideoSetting
	{
		public function VideoSetting()
		{
		}
		
		private static var _playback:Number=7862400000;//
		private static var _signal:Array=[1,5,10,20];
		private static var _checkSignalTimer:int=3000;
		private static var _checkPlayingTimeout:int=5000;
		private static var _clarityTags:Array=["SD","HD"];
		private static var _delay:Number=1000;
		private static var _hallLive:Vector.<VideoVO>;
		private static var _hallLiveSize:Array=[800,600];
		private static var _bufferTime:Number=0;
		
		/**
		 *object:
		 * {
		 * "bufferTime":0,
		 * "checkPlayingTimeout":8000,
		 * "checkSignalTimer":3000,
		 * "clarityTags":"SD,HD",
		 * "delay":2500,
		 * "hallLiveLine":["rtmp://line4.video.zt008.com/allvideo/1-1"]
		 * "hallLiveSize":"1024,680",
		 * "playback":7862400000,
		 * "signal":50,250,1000,5000
		 * } 
		 * @param data
		 * 
		 */
		public static function setup(data:Object):void
		{
			if (data)
			{
				_delay=Number(data.delay);
				_clarityTags=String(data.clarityTags).split(",");
				_playback=Number(data.playback);
				_signal=String(data.signal).split(",");
				_checkSignalTimer=int(data.checkSignalTimer);
				_checkPlayingTimeout=int(data.checkPlayingTimeout);
				_hallLiveSize=String(data.hallLiveSize).split(",");
				_bufferTime=Number(data.bufferTime);
				//				_hallLive=data.hallLive;
				
				_hallLive = new Vector.<VideoVO>();
				if (data.hallLiveLine) {
					for (var i:int = 0; i<data.hallLiveLine.length; i++) { 
						_hallLive.push(new VideoVO(data.hallLiveLine[i],_bufferTime));
					}
				}
			}
		}
		
		/**视讯回放有效时间（默认7天）*/
		public static function get playback():Number
		{
			return _playback;
		}
		
		/**信号延迟数值列表*/
		public static function get signal():Array
		{
			return _signal;
		}
		
		/**超时数值*/
		public static function get checkPlayingTimeout():int
		{
			return _checkPlayingTimeout;
		}
		
		/**高清标签*/
		public static function getHD():String
		{
			return _clarityTags[1];
		}
		
		/**标清标签*/
		public static function getSD():String
		{
			return _clarityTags[0];
		}
		
		/**延迟开牌*/
		public static function get delay():Number
		{
			return _delay;
		}
		
		/**大厅现场视讯*/
		public static function get hallLive():Vector.<VideoVO>
		{
			return _hallLive;
		}
		
		/**检查信号计时器*/
		public static function get checkSignalTimer():int
		{
			return _checkSignalTimer;
		}
		
		public static function get hallLiveSize():Array
		{
			return _hallLiveSize;
		}
		
		public static function get bufferTime():Number
		{
			return _bufferTime;
		}
		
		
	}
}

