package views
{
	import com.wg.utils.mathUtils.MathUtil;
	import com.wg.utils.stringUtils.StringUtil;
	import com.wg.utils.timeUtils.Daojishi;
	import com.wg.utils.timeUtils.Jishiqi;
	import com.wg.utils.timeUtils.TimeUtil;
	
	import flash.events.Event;
	
	import views.utiltest.SFSCodeTransportComp;

	public class UtilsTestView extends ViewBase
	{
		public function UtilsTestView()
		{
			panelName = "basicutils";
			super();
		}
		override protected function render():void
		{
			if(!content)
			{
				var maincls:Class = Config.resourceLoader.getClass(panelName);
				content = new maincls();
				this.addChild(content);
				trace("中文字转拼音",StringUtil.chinese2Py("中文字转拼音"));
				trace("adf-df=adf5dfsf8afdfsa3".split(/\W+/).toString());
				
				
				trace(TimeUtil.yearAnimals(int(TimeUtil.currentYear())));
				//测试计时器
				var jishiqi:Jishiqi = new Jishiqi();
				 	//jishiqi.addEventListener(Jishiqi.RESULT, hello2);
					//jishiqi.timeStart(1000);
					function hello2(event:Event):void
					{
						    trace(jishiqi.resultNum);
							jishiqi.timeStop();
					}
					//测试倒计时
					var daojishi:Daojishi = new Daojishi();
						//daojishi.timeStart(1, 2, 00, 00, ":");
						//daojishi.eventDispatcher.addEventListener(Daojishi.RESULT, hello);
						function hello(event:Event):void
						{
							trace(daojishi.result);
						}
				
				trace(MathUtil.getRandomNumArr(1,100,20).toString());
				trace(MathUtil.getIntFromString("sfdadffd123sf123ffs454323dfs2df").toString());
				//var tempcls:Class = Config.resourceLoader.getClass("SFSCode",panelName);
				var sfscode:SFSCodeTransportComp = new SFSCodeTransportComp(content.sfs_mc);
			}
			super.render();
		}
		
		
	}
}