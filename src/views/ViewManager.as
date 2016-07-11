package views
{
	import com.wg.utils.timeUtils.GlobalTimer;
	
	import flash.utils.Dictionary;

	public class ViewManager
	{
		private var viewvector:Vector.<ViewBase>;
		private var dic:Dictionary;
		private var _frameProcessList:Object;
		public function ViewManager()
		{
			viewvector = new Vector.<ViewBase>();
			dic = new Dictionary();
			_frameProcessList = {};
			GlobalTimer.instance.pushFunc(frameProcess,10);
			init();
		}
		private function init():void
		{
			//枚举;初始化即开始加载;
			viewvector[0] = new UIView();
			dic[viewvector[0].panelName] = 0;
			
			viewvector[1] = new StimliLoadView();
			dic[viewvector[1].panelName] = 1;
			
			viewvector[2] = new MyUIView();
			dic[viewvector[2].panelName] = 2;
			
			viewvector[3] = new ZipTestView();
			dic[viewvector[3].panelName] = 3;
			
			viewvector[4] = new DebugTestView();
			dic[viewvector[4].panelName] = 4;
			
			viewvector[5] = new UtilsTestView();
			dic[viewvector[5].panelName] = 5;
			
			viewvector[6] = new LoadSwfView();
			dic[viewvector[6].panelName] = 6;
			
			viewvector[7] = new LayoutView();
			dic[viewvector[7].panelName] = 7;
			
			viewvector[8] = new MvcTestView();
			dic[viewvector[8].panelName] = 8;
			
			viewvector[9] = new ServerTestView();
			dic[viewvector[9].panelName] = 9;
			
			viewvector[10] = new DesignTestView();
			dic[viewvector[10].panelName] = 10;
			
			viewvector[11] = new SceneTestView();
			dic[viewvector[11].panelName] = 11;
			
			viewvector[12] = new MapTestView();
			dic[viewvector[12].panelName] = 12;
			
			viewvector[13] = new SimpleSceneTestView();
			dic[viewvector[13].panelName] = 13;
			
			viewvector[14] = new FormulaView();
			dic[viewvector[14].panelName] = 14;
			
			viewvector[15] = new SFSServerView();
			dic[viewvector[15].panelName] = 15;
			
			viewvector[16] = new JiaMiView();
			dic[viewvector[16].panelName] = 16;
		}
		
		/**
		 *需要添加面板共存规则,创建层级概念; 
		 * @param str
		 * @param args
		 * 
		 */
		public function showPanel(str:String,...args):void
		{
			
			for (var i:int = 0; i < viewvector.length; i++) 
			{
				if(dic[str]==i){
					viewvector[dic[str]].show(str,args);
				}else if(viewvector[i].panelName!="ui"&&viewvector[i].isShowing)
				{
					viewvector[i].close();
				}
			}
			
			
			
		}
		public function getPanelWithName(name:String):*
		{
			return viewvector[dic[name]];
		}
		public function closePanel(str:String):void
		{
			viewvector[dic[str]].close();
		}
		
		public function addToFrameProcessList(handlerName:String, handler:Function) : void
		{
			_frameProcessList[handlerName] = handler;
		}
		public function frameProcess() : void
		{
			for (var handlerName:String in _frameProcessList) {
				_frameProcessList[handlerName]();
			}
		}
	}
}