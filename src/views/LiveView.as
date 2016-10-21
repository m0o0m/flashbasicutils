package views
{
	
	import com.ql.gameKit.events.ViewEvent;
	import com.ql.gameKit.manager.PopUpManager;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import views.live.LiveVideo;
	import views.live.VideoSetting;
	import views.live.ZoomLiveVideo;

	public class LiveView extends ViewBase
	{
		/**点击放大按钮，弹出大的视频*/
		public static const ZOOM_LIVE_VIDEO:String="zoomLiveVideo";
		private const ZOOMLIVEVIDEO_TAG:String="ZLV";//弹窗标识
		public function LiveView()
		{
			panelName = "videoComp";
			super();
		}
		override protected function render():void
		{
			if(!content)
			{
				var maincls:Class = Config.resourceLoader.getClass(panelName);
				content = new maincls();
				this.addChild(content);
				
			}
			super.render();
			initVideo();
		}
		private var _liveVideo:LiveVideo;
		private var _zoomLiveVideo:ZoomLiveVideo;
		private function initVideo():void
		{
			// TODO Auto Generated method stub
			//游戏信息初始化
			var obj:Object = 
				{
				bufferTime:"0",
				checkPlayingTimeout:"8000",
				checkSignalTimer:"3000",
				clarityTags:"SD,HD",
				delay:"2500",
				hallLiveLine:["rtmp://line4.video.zt008.com/allvideo/1-1"],
				hallLiveSize:"1024,680",
				playback:"7862400000",
				signal:"50,250,1000,5000"
				};
			VideoSetting.setup(obj);
			PopUpManager.shared().init(this,(content as Sprite),{height:this.height,width:this.width});
			
			
			_liveVideo = new LiveVideo(content.liveVideo_mc);
			_liveVideo.addEventListener(ZOOM_LIVE_VIDEO, onZoomLiveVideo);
			_liveVideo.active();
			content.addChild(_liveVideo);
			//设置live video
			var size:Array=VideoSetting.hallLiveSize;
			_liveVideo.init(VideoSetting.hallLive, "test6", VideoSetting.getHD(),VideoSetting.checkSignalTimer, VideoSetting.checkPlayingTimeout, VideoSetting.signal, size[0], size[1]);
			//VideoVO,"test6",VideoSetting.getHD(),VideoSetting.checkSignalTimer, VideoSetting.checkPlayingTimeout, VideoSetting.signal,1024,680
			_liveVideo.resize();
			
			var zoommcclass:Class = Config.resourceLoader.getClass("LiveVideoMcBig",panelName);
			_zoomLiveVideo=new ZoomLiveVideo(removeZoomLiveVideo,new zoommcclass());
			_zoomLiveVideo.init(VideoSetting.hallLive, "test6", VideoSetting.getHD(),VideoSetting.checkSignalTimer, VideoSetting.checkPlayingTimeout, VideoSetting.signal, size[0], size[1]);
			
		}
		private function onZoomLiveVideo(event:ViewEvent):void
		{
			_liveVideo.deactive();
			
			PopUpManager.shared().popUpCenter(_zoomLiveVideo, true ,ZOOMLIVEVIDEO_TAG, true);
			_zoomLiveVideo.isPlaying = _liveVideo.isPlaying;
			_zoomLiveVideo.currentLine = _liveVideo.currentLine;
			_zoomLiveVideo.active();
		}
		private function removeZoomLiveVideo():void
		{
			PopUpManager.shared().removePopUpByTag(ZOOMLIVEVIDEO_TAG);
			
			if (_zoomLiveVideo) {
				_zoomLiveVideo.deactive();
				_liveVideo.isPlaying = _zoomLiveVideo.isPlaying;
				_liveVideo.currentLine = _zoomLiveVideo.currentLine;
			}
			
			_liveVideo.active();
		}
		override public function close():void
		{
			_liveVideo = null;
			_zoomLiveVideo = null;
			super.close();
		}
	}

}