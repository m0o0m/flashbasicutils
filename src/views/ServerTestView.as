package views
{
	import com.wg.error.Err;
	import com.wg.httpRequest.HttpRequest;
	import com.wg.httpRequest.HttpRequestList;
	import com.wg.httpRequest.HttpRequestManager;
	import com.wg.httpRequest.HttpResponseVO;
	import com.wg.httpRequest.command.KaijiangResponseVO;
	import com.wg.socketserver.Server;
	import com.wg.socketserver.messages.Message;
	import myserverMessages.testcommand.TestMessage;
	import myserverMessages.testcommand.TestMessageResponse;
	
	import flash.events.MouseEvent;
	
	public class ServerTestView extends ViewBase
	{
		
		public function ServerTestView()
		{
			panelName = "servertest";
			super();
		}
		
		override protected function render():void
		{
			if(!content)
			{
				var maincls:Class = Config.resourceLoader.getClass(panelName);
				content = new maincls();
				this.addChild(content);
				
				content.socketbtn.addEventListener(MouseEvent.CLICK,socketHandler);
				content.socket_connectbtn.addEventListener(MouseEvent.CLICK,sockeconnecttHandler);
				content.httpbtn.addEventListener(MouseEvent.CLICK,httpHandler);
				
			}
			super.render();
		}
		private function sockeconnecttHandler(e:MouseEvent):void
		{
			if(!server)
			{
				/*Server: {  
				//				host: "192.168.10.65",//release
				//				port: 2002,//release
				host: "127.0.0.1", 
				port: 60000, //trunk
				//				port: 42013,// 耀澜
				//				port: 50013,  //fancy
				//				port: 32002,  //liujie
				proxyPort: 443,
				compress: false
				}*/
				server = new Server({host: "127.0.0.1",port: 60000});
				server.onConnect = function():void
				{
					content.handler_ta.text = "socket 服务器已经连接...";
					if(server)
					{
						server.registerMessageHandler("testsocket",function(message:Message):void{
							trace((message as TestMessageResponse).type);
						});
					}else
					{
						Err.occur(Errno.CLIENT_ERROR,{desc:"socket服务器没有连接"});
					}
				}
				server.onClose = function():void
				{
					content.handler_ta.text = "socket 服务器已经关闭...";
				}
					
				server.onMessageHandled = function(data:String):void
				{
					content.handler_ta.appendText("\n"+data);
				}
				server.connect();
			}
		}
		private function httpHandler(e:MouseEvent):void
		{
			// TODO Auto Generated method stub
			// HttpRequest 根据http请求连接 创建http请求,并保存httprequestmanager 创建 的requestvo 和reponsevo
			//具体是哪两个消息对象,根据httprequestlist配置,通过请求url连接读取;
			HttpRequestManager.instance.send(HttpRequestList.kaijiangrequest,function(repsonse:HttpResponseVO):void{
				trace((repsonse as KaijiangResponseVO).name,{"name":"httpfasong"});
			});
		}
		private var server:Server;
		private function socketHandler(e:MouseEvent):void
		{
			// TODO Auto Generated method stub
			var testmessgae:TestMessage = new TestMessage({name:"hello",age:"23"});
			server.send(testmessgae);
		}
	}
}