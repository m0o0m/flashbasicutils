package views
{
	import com.wg.ui.button.ButtonGroupManger;
	import com.wg.ui.button.LittleGroupButton;
	
	import flash.display.MovieClip;

	/**
	 *代表一个swf中的显示对象操作者;
	 * 本身也是一个容器; 
	 * @author Administrator
	 * 
	 */
	public class UIView extends ViewBase
	{
		private var namevec:Vector.<String> = new Vector.<String>();
		private var lanmuGroupArr:Vector.<LittleGroupButton> = new Vector.<LittleGroupButton>;
		//保存加载的swf的名称,也是默认主mc类的名称;传递给点击按钮的gameType,然后点击时再传给viewmanager
		//viewmanager根据panelNamevec的字符串对应的索引,找到保存在数组中的view类实例
		//view的panelName == littlebtn.gametype == swf的名称 == 默认主mc类的类名;
		private var panelNamevec:Array = ["stimliLoad","myui","ziptest","debuglogic","basicutils","loadswf","layout","mvc","servertest","designtest","scenetest","maptest","simplemap","formulatools","sfsserver","jiami"];
		public function UIView()
		{
			panelName = "ui";
			super();
		}
		override protected function render():void
		{
			namevec.push("资源加载","ui组使用","压缩工具","项目日志功能","基本工具","swf加载处理","层级管理",
				"MVC","网络通讯方式","数值配置文件使用","摄像头,schedule","地图加载","简单地图加载","公式模拟","sfsserver","加密解密","对话引导模块","战斗模块"
			);
			if(!content)
			{
				var maincls:Class = Config.resourceLoader.getClass(panelName);
				content = new maincls();
				this.addChild(content);
				super.render();	
				init();
			}
		}
		
		private function init():void
		{
			
			for (var i:int = 0; i < namevec.length; i++) 
			{
				var tempbtn:LittleGroupButton = new LittleGroupButton(content.tabbuttons["btn"+i],namevec[i]);
				tempbtn.gameType = panelNamevec[i];
				tempbtn.clickFunc = lanmuClickHandler;
				tempbtn.init();
			}
			ButtonGroupManger.instance.changeState(content.tabbuttons);
		}
		
		private function lanmuClickHandler(littlebtn:LittleGroupButton):void
		{
//			trace(littlebtn.title);
//			trace(ButtonGroupManger.instance.getCurrentButton(content.tabbuttons).title);
			Config.viewManger.showPanel(littlebtn.gameType);
		}
		
		override protected function dispose():void
		{
			
		}
		
	}
}