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
		private var namevec:Vector.<Array> = new Vector.<Array>();
		private var lanmuGroupArr:Vector.<LittleGroupButton> = new Vector.<LittleGroupButton>;
		//保存加载的swf的名称,也是默认主mc类的名称;传递给点击按钮的gameType,然后点击时再传给viewmanager
		//viewmanager根据panelNamevec的字符串对应的索引,找到保存在数组中的view类实例
		//view的panelName == littlebtn.gametype == swf的名称 == 默认主mc类的类名;
		/*private var panelNamevec:Array = 
			["stimliLoad","myui","ziptest","debuglogic","basicutils","loadswf","layout","mvc",
			"servertest","designtest","scenetest","maptest","simplemap",
			"formulatools","sfsserver","jiami","alertComp","chatComp","videoComp","3dTest","lvjingComp","erweimaComp"];*/
		public function UIView()
		{
			panelName = "ui";
			super();
		}
		override protected function render():void
		{
			namevec.push(["资源加载","stimliLoad"],["ui组使用","myui"],["压缩工具","ziptest"],
				["项目日志功能","debuglogic"],["基本工具","basicutils"],["swf加载处理","loadswf"],["层级管理","layout"],
				["MVC","mvc"],["网络通讯方式","servertest"],["数值配置文件使用","designtest"],["摄像头,schedule","scenetest"],
				["地图加载","maptest"],["简单地图加载","simplemap"],["公式模拟","formulatools"],
				["sfsserver","sfsserver"],["加密解密","jiami"],["提示框模块","alertComp"],["聊天模块","chatComp"],["live直播","videoComp"],
				["3d测试","3dTest"],["滤镜","lvjingComp"],["二维码生成","erweimaComp"],["对话引导模块-",""],["战斗模块-",""]
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
				var tempbtn:LittleGroupButton = new LittleGroupButton(content.tabbuttons["btn"+i],namevec[i][0]);
				tempbtn.groupId = namevec[i][1];//panelNamevec[i];
				tempbtn.clickFunc = lanmuClickHandler;
				tempbtn.init();
			}
			ButtonGroupManger.instance.changeState(content.tabbuttons);
		}
		
		private function lanmuClickHandler(littlebtn:LittleGroupButton):void
		{
//			trace(littlebtn.title);
//			trace(ButtonGroupManger.instance.getCurrentButton(content.tabbuttons).title);
			Config.viewManger.showPanel(littlebtn.groupId);
		}
		
		override protected function dispose():void
		{
			
		}
		
	}
}