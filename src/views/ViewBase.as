package views
{
	import com.wg.logging.Log;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;

	public class ViewBase extends Sprite
	{
		public static var _stage:Stage;
		public var panelName:String;
		protected var content:MovieClip;
		public var isShowing:Boolean;
		public function ViewBase()
		{
			super();
		}
		public function show(name:String,...args):void
		{
			if(isShowing) return;
			loadPanel(name);
		}
		
		public function close():void
		{
			if(isShowing){
				dispose();
				_stage.removeChild(this);
				isShowing = false;
				trace("关闭面板:"+ this.panelName);
			}
		}
		
		protected function dispose():void
		{
			
		}
		
		protected function reset():void
		{
			
		}
		
		protected function render():void
		{
			respostion();
			ViewBase._stage.addChild(this);
			isShowing = true;
		}
		
		protected function respostion():void
		{
			this.x = (ViewBase._stage.stageWidth - this.width)/2;
			this.y = (ViewBase._stage.stageHeight - this.height)/2;
		}
		
		/**
		 *资源不正确,与代码有冲突,会导致加载不正确显示; 
		 * @param className
		 * @param isShowLoadingProgress
		 * @param keyName
		 * 
		 */
		protected function loadPanel(className:String,isShowLoadingProgress:Boolean = false, keyName:String = ""):void
		{
			trace('***************************************');
			trace('打开面板：' + Config.uri.getPanelURI(className));
			trace('***************************************');
			if (!className) {
				throw new Error("panel name is empty");
			}
			
			var cls:Class = Config.resourceLoader.getClass(className, keyName);
			if (cls != null)
			{
				this.render();
			}
			else 
			{
				load(className,isShowLoadingProgress);
			}
		}
		private function load(className:String,isShowLoadingProgress:Boolean):void
		{
			Log.debug("**load***"+className+"*"+isShowLoadingProgress)
			//是否需要显示loading条;
			if(isShowLoadingProgress)
			{
				Config.resourceLoader.load([Config.resourceLoader.getLoadData(Config.uri.getPanelURI(className), className)], onProgressCallback, render);
			}
			else
			{
				Config.resourceLoader.load([Config.resourceLoader.getLoadData(Config.uri.getPanelURI(className), className)], onProgressCallbackWithout, render)
			}
		}
		
		private function onProgressCallback(path:String, bytesLoaded:uint=1, bytesTotal:uint=1):void
		{
			//如果进度条在显示状态，更新数据
			if(bytesLoaded == 1 && bytesTotal == 1) return;
			trace("加载进度:",bytesLoaded,bytesTotal);
			//			view.miniLoading.changeData(uri.getPanelURI(path),1,1, bytesLoaded, bytesTotal);
		}
		
		private function onProgressCallbackWithout(key:String, bytesLoaded:uint=1, bytesTotal:uint=1):void
		{
			
		}
		
		
	}
}