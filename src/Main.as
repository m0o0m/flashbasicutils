package
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.wg.bitmapdataUtils.BitmapDataUtil;
	import com.wg.logging.Log;
	import com.wg.resource.ResourceLoader;
	import com.wg.utils.arrayUtils.ArrayUtil;
	import com.wg.utils.systeminfoUtils.SystemInfos;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import views.DesignTestView;
	import views.ViewBase;
	import views.ViewManager;
	import views.formula.hitest.HitTest_Test;
	import views.formula.hitest.Pointtest;

	[SWF(width=1200,height=900,frameRate='30')]
	/**
	 *每一个板块之间的引用尽量减少到零,方便copy,减少迁移的牵连程度;
	 *每个板块提供使用的api,无需了解内部实现机制,提供使用函数即可; 
	 * @author Administrator
	 * 
	 * 
	 * lib 中是基本的,重复使用的功能,不需要根据项目制定的功能;
	 */
	public class Main extends Sprite
	{
		public function Main()
		{
			super();
			if (CONFIG::debug) {
				trace(CONFIG::version);
			}
			ViewBase._stage = this.stage;
			Config.stage = this.stage;
			Config.resourceLoader = new ResourceLoader();
			Config.uri = new URI();
			Config.viewManger = new ViewManager();
			Context.getInstance().initialize(this,"1.2.3.5000","false","false");
			DesignTestView.ZipLoader();
			Config.viewManger.showPanel("ui",1,2,3);//主界面;只执行一次;
			Config.viewManger.showPanel("stimliLoad");
			this.addEventListener(Event.ADDED_TO_STAGE,function (e:Event):void{
				
			});
			MonsterDebugger.initialize(this);
			MonsterDebugger.trace(this, "Hello Monster dsFlashClient cn");
			SystemInfos._stage = this.stage;
			SystemInfos.showInfo();
			var pointtest:Pointtest = new Pointtest();
			
			
			
			
		}
		
		
	}
}