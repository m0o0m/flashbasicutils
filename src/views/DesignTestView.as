package views
{
	import com.wg.design.Design;
	
	import deng.fzip.FZip;
	import deng.fzip.FZipEvent;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import mydesigndatas.logic.ErrorLang;
	import mydesigndatas.logic.Npc;

	public class DesignTestView extends ViewBase
	{
//		private var design:Design;
		private var _files:Vector.<Loader>;
		private var _zip:FZip;
		private var design:Design;
		public function DesignTestView()
		{
			panelName = "designtest";
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
			ZipLoader();
			super.render();
		}
		public function ZipLoader():void {
			_files = new Vector.<Loader>();
			_zip = new FZip();
			_zip.addEventListener(FZipEvent.FILE_LOADED, onZipLoading);
			_zip.addEventListener(Event.COMPLETE, onZipComplete);
			_zip.load(new URLRequest("assets/data/desginData.zip"));
		}
		
		private function onZipLoading(event : FZipEvent) : void {
			trace("名称:"+event.file.filename)//"\n内容:"+event.file.content+"\n");
			if(event.file.filename == "Npc.json") trace("\n内容:"+event.file.content+"\n");
		}
		
		private function onZipComplete(event : Event) : void {
			trace("加载ZIP完成");
			trace("ZIP文件中文件总数：" + _zip.getFileCount());
			if(!design) design = new Design(new URI(),null,_zip);
			Config.design = design;
			var npc:Npc = design.load(mydesigndatas.logic.Npc,830001);
			content.info_ta.text = npc.toString();
		}
		
		override protected function dispose():void
		{
			_files = null;
			_zip.close();
			_zip = null;
			super.dispose();
		}
		
	}
}