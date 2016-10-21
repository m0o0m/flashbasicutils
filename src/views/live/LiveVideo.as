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
	import com.ql.gameKit.events.ViewEvent;
	import com.ql.gameKit.extensions.customLoader.CustomLoader;
	import com.ql.gameKit.extensions.customLoader.LoaderFileType;
	import com.ql.gameKit.extensions.customLoader.LoaderVO;
	import com.ql.gameKit.extensions.debug.Logger;
	import com.ql.gameKit.extensions.video.VideoPlayer;
	import com.ql.gameKit.extensions.video.VideoVO;
	import com.ql.gameKit.manager.AssetManager;
	import com.ql.vgame.common.data.Resource;
	import com.ql.vgame.common.data.Web;
	import com.ql.vgame.common.data.setting.VideoSetting;
	import com.ql.vgame.hall.events.HallViewEvents;
	import com.ql.vgame.hall.view.skin.HallSkin;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLStream;
	import flash.utils.ByteArray;


	/**
	 * 现场视频
	 * @author FF
	 */
	public class LiveVideo extends Sprite
	{
		public var isPlaying:Boolean;
		public var currentLine:int;
		
		protected var targetMc:MovieClip;

		private var _clarity:String;//清晰度
		private var _signalRange:Array;//信号范围（配置的）
		private var _videoPlayer:VideoPlayer;
		private var _videoLines:int;
		protected var _content:MovieClip;
		/**点击放大按钮，弹出大的视频*/
		public static const ZOOM_LIVE_VIDEO:String="zoomLiveVideo";
		public function LiveVideo(con:MovieClip)
		{
			_content = con;
			draw();
		}

		private function draw():void
		{
			targetMc=_content;//getAsset();
			targetMc.loadingMc.mouseEnabled = false;
			targetMc.loadingMc.mouseChildren = false;
			targetMc.lineMc.mouseEnabled = false;
			targetMc.lineMc.mouseChildren = false;
			addChild(targetMc);
			stop();
			
//			loadVideoBG(Web.data.videobg);
			loadVideoBG("hall_video_bg.jpg?t=1512041556");
		}

/*		protected function getAsset():MovieClip
		{
			return AssetManager.shared().getMovieClip(Resource.HALL, HallSkin.LIVEVIDEOMC);
		}*/
		
		
		private var _url:String;
		private var _avatar:Loader;
		private function loadVideoBG(vidoeBGURL:String):void //加载二维码
		{
			if (_url == vidoeBGURL) {
				return;
			}
			else {
				if (_avatar) {
					if (_avatar.content && _avatar.content.parent) {
						_avatar.content.parent.removeChild(_avatar.content);
					}
					_avatar.unloadAndStop();
					_avatar=null;
				}
				
				if (vidoeBGURL) {
					_url = vidoeBGURL;
					
					_avatar=new Loader();
					var webpath:String = "file:///F|/workspace/VGameClient%5Fv2.0%5Ftest/bin%2Ddebug/extension/";
					trace(Context.getInstance().getPath()+"/assets/live/"+vidoeBGURL);
					//var videobgurl:String = "hall_video_bg.jpg?t=1512041556";
					var loader:CustomLoader=new CustomLoader(new LoaderVO("",Context.getInstance().getPath()+"assets/live/"+vidoeBGURL,LoaderFileType.STREAM,false,function(id:String,content:URLStream):void{
						if (content) {
							if (_avatar) {
								_avatar.contentLoaderInfo.addEventListener(Event.COMPLETE,function(event:Event):void{
									event.currentTarget.removeEventListener(event.type, arguments.callee);
									event.currentTarget.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, arguments.callee);
									try {
										(_avatar.content as Bitmap).smoothing=true;
									}
									catch(error:Error) { }
									if(targetMc.videoBgHoldMc){
										targetMc.videoBgHoldMc.addChild(_avatar.content);
									}
								});
								var data:ByteArray=new ByteArray();
								content.readBytes(data,0, data.bytesAvailable);
								_avatar.loadBytes(data);
							}
						}
					}));
					loader.start();
				}
			}
		}

		public function init(cfg:Vector.<VideoVO>, player:String, clarity:String, checkDelayTimer:int,checkPlayingTimeout:int, signalRange:Array, videoW:Number, videoH:Number):void
		{
			
			_clarity=clarity;
			_signalRange=signalRange;

			if (cfg && cfg.length > 0) { 
				_videoLines = cfg.length;
				if (!_videoPlayer) {
					_videoPlayer=new VideoPlayer();
					targetMc.videoHolder.addChild(_videoPlayer);
					_videoPlayer.init(videoW, videoH, cfg,false,updateSingal,checkDelayTimer,player,displayLoading,checkPlayingTimeout);
				}
				
				if (_videoLines == 1) {
					targetMc.opBarMc.lineBtn.visible = false;
					if (targetMc.opBarMc.bgMc) { 
						targetMc.opBarMc.bgMc.width -= targetMc.opBarMc.lineBtn.width;
					}
				}
			} 
		}
		
		public function resize():void
		{
			if (_videoPlayer) { 
				_videoPlayer.scaleX = _videoPlayer.scaleY = 0.65;
			}
		}

		//更新视讯播放信号
		private function updateSingal(value:int):void
		{
			if (value>=0) {
				var index:int;
				var count:int=_signalRange.length;
				
				for (var i:int=0; i<count; i++) {
					if (value <= _signalRange[i]) {
						index=i;
						break;
					}
				}

				//信号太差，重新播放
				if (index>=count-1) {
					play();
				}
			}

			Logger.log("Hall video delay:"+value,this);
		}

		private function displayLoading(isHide:Boolean, ...args):void
		{
			if (isHide) {
				targetMc.loadingMc.visible=false;
				targetMc.loadingMc.animateMc.stop();
			} else {
				targetMc.loadingMc.visible=true;
				targetMc.loadingMc.animateMc.play();
			}
		}

		protected function stop():void
		{
			if (_videoPlayer) {
				_videoPlayer.stopVideo();
				_videoPlayer.visible = false;
			}

			displayLoading(true);
			targetMc.switchMc.gotoAndStop(1);
			targetMc.switchMc.visible = true;
			targetMc.opBarMc.visible = false;
			targetMc.lineMc.visible = false;
		}

		protected function play():void
		{
			if (_videoPlayer) {
				_videoPlayer.play(currentLine,_clarity);
				_videoPlayer.visible=true;
			}

			targetMc.switchMc.visible = false;
			targetMc.switchMc.gotoAndStop(2);
			targetMc.opBarMc.visible = true;
			displayLoading(false);
			
			if (_videoLines > 0) {
				targetMc.lineMc.txt.text = "video-"+(currentLine+1);
				targetMc.lineMc.visible = true;
			}
		}

		public function active():void
		{
			targetMc.switchBtn.addEventListener(MouseEvent.ROLL_OVER, onOver);
			targetMc.switchBtn.addEventListener(MouseEvent.ROLL_OUT, onOut);
			targetMc.switchBtn.addEventListener(MouseEvent.CLICK, onClick);
			if (isPlaying) {
				play();
			}

			updateOPBtn();
		}
		
		public function deactive():void
		{
			targetMc.removeEventListener(MouseEvent.ROLL_OVER, onOver);
			targetMc.removeEventListener(MouseEvent.ROLL_OUT, onOut);
			targetMc.switchMc.removeEventListener(MouseEvent.CLICK, onClick);
			stop();
			updateOPBtn();
		}

		protected function onClick(event:MouseEvent):void
		{
			isPlaying=!isPlaying;
			if (!isPlaying) {
				stop();
			} else {
				play();
			}

			updateOPBtn();
		}

		protected function onOver(event:MouseEvent):void
		{
			if (isPlaying) {
				targetMc.switchMc.visible=true;
			}
		}

		protected function onOut(event:MouseEvent):void
		{
			if (isPlaying) {
				targetMc.switchMc.visible=false;
			}
		}

		protected function updateOPBtn():void
		{
			if (isPlaying) {
				targetMc.opBarMc.visible = true;;
				if (!targetMc.opBarMc.hasEventListener(MouseEvent.CLICK)) {
					targetMc.opBarMc.addEventListener(MouseEvent.CLICK, onClickOPBtn);
				}
			} else {
				targetMc.opBarMc.visible = false;
				targetMc.opBarMc.removeEventListener(MouseEvent.CLICK, onClickOPBtn);
			}
		}

		private function onClickOPBtn(event:MouseEvent):void
		{
			if (event.target.name == "refreshBtn") {
				isPlaying=true;
				play();
			}
			else if (event.target.name == "zoomBtn") {
				dispatchEvent(new ViewEvent(ZOOM_LIVE_VIDEO,null,true));
			}
			else if (event.target.name == "stopBtn") {
				onClick(null);
			}
			else if (event.target.name == "lineBtn") {
				if (++currentLine >= _videoLines) { 
					currentLine = 0;
				}
				isPlaying=true;
				play();
			}
		}
	}
}

