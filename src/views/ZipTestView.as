package views
{
	import deng.fzip.FZip;
	import deng.fzip.FZipEvent;
	
	import fl.controls.TextArea;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;

	public class ZipTestView extends ViewBase
	{
		public function ZipTestView()
		{
			panelName = "ziptest";
			super();
		}
		private var shuoming_ta:TextArea;
		private var show_ta:TextArea;
		private var _zip : FZip;
		private var _files : Vector.<Loader>;
		override protected function render():void
		{
			if(!content)
			{
				var maincls:Class = Config.resourceLoader.getClass(panelName);
				content = new maincls();
				this.addChild(content);
				shuoming_ta = content.shuoming_ta;
				show_ta = content.show_ta;
				shuoming_ta.htmlText = "com.probertson.utils 中解压缩操作扩展的是 桌面应用程序,fzip 是针对as3 程序做处理," +
					"<br/>更多压缩类库说明:<a href='http://ch-kexin.iteye.com/blog/1914908'>http://ch-kexin.iteye.com/blog/1914908</a>" +
					"<br/>fzip使用文档 <a href='http://codeazur.com.br/lab/fzip/docs/deng/fzip/package-detail.html'>http://codeazur.com.br/lab/fzip/docs/deng/fzip/package-detail.html</a>" +
					"<br/> 文件加载完毕后 保存为ByteArray,具体解析成什么格式,可以根据名称,自定义选择加载的类;";
			content.start_btn.addEventListener(MouseEvent.CLICK,startHandler);
			}
			super.render();
		}
		
		private function startHandler(e:MouseEvent):void
		{
			// TODO Auto Generated method stub
			
			if(!_files) ZipLoader();
		}
		
		public function ZipLoader():void {
			_files = new Vector.<Loader>();
			_zip = new FZip();
			_zip.addEventListener(Event.OPEN, onZipOpen);
			_zip.addEventListener(FZipEvent.FILE_LOADED, onZipLoading);
			_zip.addEventListener(Event.COMPLETE, onZipComplete);
			_zip.load(new URLRequest("assets/zip/desginData.zip"));
		}
		
		private function onZipOpen(event : Event) : void {
			trace("打开ZIP文件");
		}
		
		private function onZipLoading(event : FZipEvent) : void {
			show_ta.appendText("名称:"+event.file.filename+"\n内容:"+event.file.content+"\n");
			
			//图片的处理,读进来的都是字节,解析方式可以自定义;
			if((event.file.filename).indexOf("jpg")!=-1)
			{
				var pngLoader : Loader = new Loader();
				pngLoader.loadBytes(event.file.content);
				_files.push(pngLoader);
			}
			
		}
		
		private function onZipComplete(event : Event) : void {
			trace("加载ZIP完成");
			trace("ZIP文件中文件总数：" + _zip.getFileCount());
			for(var index : uint = 0;index < _files.length ;index++) {
				var png : Loader = _files[index];
//				png.x += index * 30;
//				png.width = content.pic_mc.width;
//				png.height = content.pic_mc.height;
				content.pic_mc.addChild(png);
				content.pic_mc.width = 200;
				content.pic_mc.height = 100;
			}
		}
	}
}