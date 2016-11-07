package com.wg.utils.systeminfoUtils
{
	import flash.display.Stage;
	import flash.system.ApplicationDomain;
	import flash.system.Capabilities;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.system.SecurityDomain;

	public class SystemInfos
	{
		public static var _stage:Stage;
		public function SystemInfos()
		{
			
		}
		public static function showInfo():void {
			var output:String = "";
			output += "stageWidth: "+_stage.stageWidth+"\n";
			output += "stageHeight: "+_stage.stageHeight+"\n";
			output += "playerType: "+Capabilities.playerType+"\n";
			output += "language: "+Capabilities.language+"\n";
			output += "os: "+Capabilities.os+"\n";
			output += "screenResolutionX: "+Capabilities.screenResolutionX+"\n";
			output += "screenResolutionY: "+Capabilities.screenResolutionY+"\n";
			output += "version: "+Capabilities.version+"\n";
			output += "serverString: "+Capabilities.serverString+"\n";
			trace(output);
		}
		public static function requestSWFLoaderContext(isCurAppDomain:Boolean = false, isCurSecDomain:Boolean = true):LoaderContext
		{
			var loaderContext:LoaderContext = new LoaderContext();
			
			loaderContext.checkPolicyFile = isCurSecDomain;
			loaderContext.applicationDomain = isCurAppDomain ? ApplicationDomain.currentDomain : null;
			
			if(Security.sandboxType == Security.REMOTE)
			{
				loaderContext.securityDomain = isCurSecDomain ? SecurityDomain.currentDomain : null;
			}
			
			return loaderContext;
		}
		
		public static function parentSecDomainAllowNoneHttpsChildSecDomain(parentHtppsDomainURL:String):void
		{
			if(Security.sandboxType == Security.REMOTE)
			{
				if(parentHtppsDomainURL.indexOf("https") != -1)
				{
					var arr:Array = parentHtppsDomainURL.split("/");
					var domain:String = arr[2];
					
					Security.allowInsecureDomain(domain);
				}
			}
		}
	}
}