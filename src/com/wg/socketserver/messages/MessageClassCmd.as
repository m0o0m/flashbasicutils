package com.wg.socketserver.messages	
{
	import com.wg.error.Err;
	import myserverMessages.testcommand.TestMessage;
	import myserverMessages.testcommand.TestMessageResponse;


	/**
	 *生成工具根据配置生成这里的 数据; 
	 * @author Administrator
	 * 
	 */
	public class MessageClassCmd
	{	
		private var _classToCmd:Object = {};
		private var _cmdToClass:Object = {};
		
		public function MessageClassCmd()
		{	
			_classToCmd[TestMessage] = 257;
			_classToCmd[TestMessageResponse] = 258;
			
			_cmdToClass[257] = TestMessage;
			_cmdToClass[258] = TestMessageResponse;
		}
		
		public function getCmd(classObj:Class) : uint
		{
			var cmd:* = _classToCmd[classObj];
			if (cmd == null) {
				Err.occur(Errno.CLIENT_ERROR, {
					desc: "message class [" + classObj + "] not found cmd"
				});
				return null;
			}
			return cmd;						
		}
		
		public function getClass(cmd:uint) : Class
		{
			var classObj:* = _cmdToClass[cmd];
			if (classObj == null) {
				Err.occur(Errno.CLIENT_ERROR, {
					desc: "message cmd [" + cmd + "] not found class"
				});
				return null;
			}
			return classObj;			
		}		
	}
}