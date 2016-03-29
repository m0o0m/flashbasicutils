package views
{
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	import br.com.stimuli.loading.loadingtypes.BinaryItem;
	import br.com.stimuli.loading.loadingtypes.URLItem;
	
	import com.wg.assets.TextFieldUtils;
	
	import deng.fzip.FZip;
	import deng.fzip.FZipEvent;
	import deng.fzip.FZipFile;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.Video;
	import flash.net.NetStream;
	import flash.utils.ByteArray;

	public class StimliLoadView extends ViewBase
	{
		public function StimliLoadView()
		{
			panelName = "stimliLoad";
			super();
		}
		override protected function render():void
		{
			if(!content)
			{
				var maincls:Class = Config.resourceLoader.getClass(panelName);
				content = new maincls();
				this.addChild(content);
					
				content.start_btn.addEventListener(MouseEvent.CLICK,startClickHandler);
				initLoading();
			}
			super.render();
			
		}
		
		private function initLoading():void
		{
			content._loadTxt1.text = "";
			content._Tip.text = "";
			
			content.loadBarMask.width = 0;
			content.loadBarMask2.width = 0;
			content._loadBall.x = content.loadBarMask2.width + content.loadBarMask2.x;
			content.jinDuEffMc.x = content.loadBarMask.width + content.loadBarMask.x -2;
		}
		
		private function freshLoading(curProgress:Number, allProgress:Number,desc:String = "desc1", desc2:String = "desc2"):void
		{
			
			var barLen:int = content._loadBar.width * curProgress;
			content.loadBarMask.width = barLen;
			content.jinDuEffMc.x = content.loadBarMask.width + content.loadBarMask.x -2;
			
//			TextFieldUtils.setHtmlTextWidthBold(content._loadTxt1, desc);
//			TextFieldUtils.setHtmlTextWidthBold(content._loadTxt2, desc2);
			content._loadTxt1.text = desc;
			content._loadTxt2.text = desc2;
			
			content.loadBarMask2.width = content._loadBar.width * allProgress;
			content._loadBall.x = content.loadBarMask2.width + content.loadBarMask2.x;
		}
		
		override protected function dispose():void
		{
			if(!loader) return;
			content.video_mc.removeChildren();
			content.pic_mc.removeChildren();
			loader.removeAll();
			loader = null;
			
			initLoading();
		}
		
		private function startClickHandler(e:MouseEvent):void
		{
			SimpleExampleMain();
		}
		
		public var loader:BulkLoader;
		public var v:Video;
		public var counter:int=0;
		private function SimpleExampleMain():void {
			//构建BulkLoader的时候需要给它一个名称 
			if(loader) return;
			loader=new BulkLoader();
			//设置输出日志 
//			loader.logLevel=BulkLoader.LOG_INFO;
			//构建好了以后，通过add方法往队列里添加需要加载的对象 
//			loader.add("photo.png");
			//添加加载对象时候，也可以给它添加一个id，方便以后调用 
			loader.add("assets/stilmiload/bg.jpg", {id:"bg"});
			//还可以通过priority属性调整加载对象的加载顺序，priority值越大，优先权越高，越早加载 
			loader.add("assets/stilmiload/EnterGame.xml", {priority:20, id:"config-xml"});
			//加载一个动画，加载动画的时候可以用pausedAtStart属性暂停播放动画 
			loader.add("assets/stilmiload/caption_video.flv", {maxTries:6, id:"the-video", pausedAtStart:true});
			var videoPath:String = "http://www.helpexamples.com/flash/video/caption_video.flv";

//			loader.add(videoPath, {maxTries:6, id:"the-video", pausedAtStart:true});
			//maxTries属性用于设定加载失败时的重试次数，注意，这里的“id”用了字符串命名 
			loader.add("assets/stilmiload/Kalimba.mp3", {id:"soundtrack", maxTries:1, priority:100});
			//以二进制流形式加载
			loader.add("assets/stilmiload/desginData.zip",{id:"zipdata",type:"binary"});
			//看了最新版本的文档，已经开始支持swf和json，一阵欣喜。
			
			addEvent();
			//队列编辑完毕后用star方法开始加载队列 
			loader.start();
		}
		private function addEvent():void
		{
			//添加一个COMPLETE事件，这个事件会在队列里的所有对象都加载完毕后触发 
			loader.addEventListener(BulkLoader.COMPLETE, onAllItemsLoaded);
			
			//添加一个PROGRESS事件，这个事件会在队列加载时不断触发。通常可以用于监听加载进度。 
			loader.addEventListener(BulkLoader.PROGRESS, onAllItemsProgress);
			
			loader.get("bg").addEventListener(Event.COMPLETE,onBackgroundLoaded) 
			// this will only trigged if the config.xml loading fails: 
			loader.get("assets/stilmiload/EnterGame.xml").addEventListener(BulkLoader.ERROR, onXMLFailed);
			
			
		}
		
		private function onBackgroundLoaded(e:Event):void
		{
			
		}
		private function onXMLFailed(e:BulkLoader):void
		{
			
		}
		private var video : Video = new Video();
		/**
		 *所有的资源保存在 loader.items,以字节数组的形式保存;
		 * loader.items[i].content as ByteArray
		 * 
		 * @param evt
		 * 
		 */
		public function onAllItemsLoaded(evt : Event):void {
			trace("every thing is loaded!");
			//建立一个Video对象 
			
			//从队列里提取刚才加载的视频流 
			var theNetStream:NetStream=loader.getNetStream("the-video");
			content.video_mc.addChild(video);
			video.attachNetStream(theNetStream);
			if(theNetStream) theNetStream.resume();
			//提取图片
			
			//可以直接通过url提取对象 
			var bitmapCats:Bitmap=loader.getBitmap("assets/stilmiload/bg.jpg");
			bitmapCats.width=200;
			bitmapCats.scaleY=bitmapCats.scaleX;
			content.pic_mc.addChild(bitmapCats);
			
			//当然，也可以通过id提取对象 
			/*var bitmapShoes:Bitmap=loader.getBitmap("bg");
			bitmapShoes.width=200;
			bitmapShoes.scaleY=bitmapShoes.scaleX;
			bitmapShoes.x=220;
			addChild(bitmapShoes);*/
			
			/*var theBgBitmap : Bitmap = loader.getContent("bg") as Bitmap;
			// you don't need to keep a reference to the loader intance, you can get it by name:
			var theBgBitmap : Bitmap = BulkLoader.getLoader("main-site").getContent("bg") as Bitmap; 
			// you can also use the conviniece methods to get a typed object:
			var theBgBitmap : Bitmap = loader.getBitmap("bg");
			// grab a BitmapData directly:
			var theBgBitmap : Bitmap = loader.getBitmapData("bg");*/
			
			//提取音频 
			var soundtrack:Sound=loader.getSound("soundtrack");
			soundtrack.play();
			
			//提取一个xml文档 
			var theXML:XML=loader.getXML("config-xml");
			content.xml_ta.text = theXML.toString();
			
			var zip:ByteArray = loader.getContent("zipdata") as ByteArray;

			var fz:FZip = new FZip;
			fz.addEventListener(Event.COMPLETE, 
				function(event:Event):void 
				{
					trace("解析zip成功...");
					var len:int = fz.getFileCount();
					for (var i:int = 0; i < len; i++) 
					{
						var zipfile:FZipFile = fz.getFileAt(i);
						content.zip_ta.appendText(zipfile.filename+"\n");
					}
					
					fz.removeEventListener(Event.COMPLETE, arguments.callee);
				});
			fz.loadBytes(zip );
			
			
			//通过url获取加载的内容的名称
//			BulkLoader.getFileName(assetUrl);
		}
		//通过BulkProgressEvent的loadingStatus方法可以显示加载过程中的所有信息！ 
		public function onAllItemsProgress(evt : BulkProgressEvent):void {
			/*var barTitle:String = StaticUtils.ENTER_GAME_LANG["第一次加载"] + " " +
				(100 * curProgress).toFixed(1) + "%";
			
			var barTitle2:String = StaticUtils.ENTER_GAME_LANG["总进度"] + 
				" (" + (curIndex + 1) + "/" + totalNum + ") " + (100 * allProgress).toFixed(1) + "%";*/
			
//			Object(mAppPreLoaderBar).render(barTitle, barTitle2, curProgress, allProgress);
			freshLoading(evt.weightPercent,evt.weightPercent,evt.currentTarget.items[Math.abs(evt.itemsLoaded-1)].id);
//			trace(evt.loadingStatus());
			trace(evt.currentTarget.items[Math.abs(evt.itemsLoaded-1)].id);
		}
		
		/**
		 *判断是否加载过,没有的话重新加载; 
		 * @param url
		 * 
		 */
		private function getResource(url:String):void
		{
			if (!loader.hasItem(url)) {
				loader.add(url, { type: BulkLoader.TYPE_MOVIECLIP } );
				loader.start();
			}else {
				loader.reload(url);
			}
		}
		private function init():void
		{
			
		}
		
	}
}