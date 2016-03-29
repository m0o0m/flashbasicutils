package com.wg.mvc.view 
{
	import com.wg.logging.Log;
	import com.wg.mvc.MVCManager;
	import com.wg.mvc.SuperBase;
	import com.wg.mvc.SuperSubBase;
	import com.wg.mvc.View;
	
	import flash.display.Stage;
	
	public class ViewSubBase extends SuperSubBase
	{
		private var _view:View;
		
		public var isModal:Boolean;
		
		//在容器管理类中设置;
		public var inStage:Boolean;
		public function ViewSubBase() 
		{
			return;
		}
		
		public function get view():View
		{
			return _view;
		}

		override public function __init(superBase:SuperBase, module:String) : void
		{
			super.__init(superBase, module);
			_view = superBase as View;//组合关系;
			if (_view == null) {
				throwInheritError();
			}
		}

		//show 显示，注册，
		public function show():void
		{
			return;
		}
		
		//UI 和 View 同步
		protected function render():void
		{
			
		}
		
		public function clear():void
		{
			return;			
		}
		
		//清理
		public function close():void
		{
			return;	
		}
		
		public function getInStage(value:*) : Boolean
		{
			return value && value.content && value.content.parent;
		}

		
		/*public function switchSelf() : void
		{
			if (MVCManager.inStage(this as ViewSubBase))
			{
				this["close"]();
			}
			else{
				this["show"]();
			}
		}*/
		
		
		

		
		protected function registerDataEventHandler(event:String, handler:Function) : void
		{
			MVCManager.data.registerEventHandler(event, handler);
		}
		
		protected function cancelDataEventHandler(event:*, handler:Function) : void
		{
			MVCManager.data.cancelEventHandler(event, handler);		
		}
		protected function cancelViewEventHandler(event:*, handler:Function) : void
		{
			view.cancelEventHandler(event, handler);		
		}
		protected function registerViewEventHandler(commandType:String,handler:Function = null):void
		{
			view.registerEventHandler(commandType,handler);
		}
		
		
		
		/**
		 *执行viewEventHandler事件; 
		 * @param event
		 * @param data
		 * 
		 */
		protected function notifyEvent(event:*, data:*=null) : void
		{
			view.notifyEvent(event, data);
		}
		
		protected function loadPanel(className:String,url:String,isShowLoadingProgress:Boolean = false, keyName:String = ""):void
		{
			trace('***************************************');
			trace('打开面板：' + url);
			trace('***************************************');
			if (!className) {
				throw new Error("panel name is empty");
			}

			var cls:Class = MVCManager.resoureloader.getClass(className, keyName);
			if (cls != null)
			{
				/*if(view.miniLoading.inStage
					&&view.miniLoading.onLoadingPath == url)
				{
					view.miniLoading.close();
				}*/
				this.render();
			}
			else 
			{
				if(inStage) return;
				
				//如果需要加载条，并且正在加载
				/*if(view.miniLoading.isLoading && isShowLoadingProgress)
					return;*/
				
				//如果进度条面板没有加载过，先加载进度条面板 
				if (isShowLoadingProgress) 
				{
					var completeCallback:Function = function() : void 
					{
						Log.debug("**completeCallback***"+className)
						load(className,url,true);
					};
					
//					view.miniLoading.startLoadPanel(url,completeCallback);
				}
				else 
				{
					load(className,url,isShowLoadingProgress);
				}
			}
		}
		
		private function load(className:String,url:String,isShowLoadingProgress:Boolean):void
		{
			Log.debug("**load***"+className+"*"+isShowLoadingProgress)
			if(isShowLoadingProgress)
			{
				MVCManager.resoureloader.load([MVCManager.resoureloader.getLoadData(url, className)], onProgressCallback, render);
			}
			else
			{
				MVCManager.resoureloader.load([MVCManager.resoureloader.getLoadData(url, className)], onProgressCallbackWithout, render)
			}
		}
		 
		private function onProgressCallback(path:String, bytesLoaded:uint=1, bytesTotal:uint=1):void
		{
			//如果进度条在显示状态，更新数据
			if(bytesLoaded == 1 && bytesTotal == 1) return;
//			view.miniLoading.changeData(uri.getPanelURI(path),1,1, bytesLoaded, bytesTotal);
		}
		
		private function onProgressCallbackWithout(key:String, bytesLoaded:uint=1, bytesTotal:uint=1):void
		{
			
		}
	}
}
