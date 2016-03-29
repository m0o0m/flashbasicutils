package views
{
	import com.wg.error.Err;
	import com.wg.logging.Log;

	public class DebugTestView extends ViewBase
	{
		public function DebugTestView()
		{
			panelName = "debuglogic";
			super();
		}
		
		override protected function render():void
		{
			if(!content)
			{
				var maincls:Class = Config.resourceLoader.getClass(panelName);
				content = new maincls();
				this.addChild(content);
				//config 模拟:模拟html传过来的数据;有真数据后替换掉;
				var Logs:Object = {
					loggers: [
						{
							name: "TraceLogger",//支持 编译工具 输出log到控制台
							//levels: "trace-debug-warn"   //trace-debug-warn   支持输出某种log;
							levels: "*"
						},
						{
							name: "ConsoleLogger",//支持  运行项目内 console 文本框输出日志;
							levels: "*"
						}
					]
				};
				Log.instance.init(formatLogConfig(Logs));
				Config.debug = new ClientdebugLogic(_stage);
				
				Log.debug("这里是测试说明");
				Log.trace("这里是测试说明");
				Log.warn("这里是测试说明");
				Log.error("这里是测试说明");
				Log.fatal("这里是测试说明");
				Log.profiler("这里是测试说明");
			}
			Err.getInstance().addHandler(Errno.CLIENT_ERROR,function(errno:*,dataObj:Object):void{
				trace(errno,dataObj.desc);
			});
			super.render();
			Err.occur(Errno.CLIENT_ERROR, {
				desc: "design class [" + "designClass" + "] key [" + 46 + "] not found"
			});
		}
		
		private function formatLogConfig(config:*) : *
		{
			if (config != null) {
				for each (var logger:Object in config['loggers']) {
					if (logger['name'] == "ConsoleLogger") {
						logger['params'] = { stage: _stage };
					}
				}
			}
			return config;
		}
	}
}