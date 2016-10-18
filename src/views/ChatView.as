package views
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import views.alert.ITip;
	import views.chat.ChatComp;
	import views.chat.DownBox;
	import views.tip.Tip;

	public class ChatView extends ViewBase
	{
		public var _chat:ChatComp;
		private var _tipContent:Sprite =new Sprite();
		private var _checkRankerInfo:Array;
		private var downBox:DownBox = new DownBox();
		private var _ItemLis:Array = [];
//		private var _meleePanel:MeleeTargetTip;
		private var currentPlayerInfo:Array = [];
		private var _shieldList:Array = [];
		
		private var _coinsActionList:Array = [];
		private var _floatRewardTipList:Array = [];
		private var _allItemList:Array = [];
		public function ChatView()
		{
			downBox.boxWidth = 53;
			panelName = "chatComp";
			super();
		}
		override protected function render():void
		{
			if(!content)
			{
				var maincls:Class = Config.resourceLoader.getClass(panelName);
				content = new maincls();
				content.chatbutton.addEventListener(MouseEvent.CLICK,showChat);
				content.sendmsgbutton.addEventListener(MouseEvent.CLICK,chatHander);
				content.sendggbutton.addEventListener(MouseEvent.CLICK,gmMessageHandler);
				this.addChild(content);
				
			}
			super.render();
			
		}
		/**
		 *限制账户发送内容 
		 * @param message
		 * 
		 */
		private function sendChatLimit(message:Object) : void
		{
			trace("发送用户信息");
		}
		
		private function textLinkHandler(textInfo:String):void
		{
			if(!textInfo) return;
			trace("名称点击");			

		}
		private function onLoadLang(str:String):String
		{
			return str;
			//trace(str);
		}
		private function loadLang():Object
		{
			return {
				"综合":("综合"),
					"世界":("世界"),
					"表情过多":("表情过多"),
					"军团":("军团"),
					"系统":("系统"),
					"GM":("GM"),
					"插入表情":("插入表情"),
					"缩放聊天窗":("缩放聊天窗"),
					"发送内容过快":("发送内容过快"),
					"发送内容为空":("发送内容为空"),
					"发送内容含有非法字符":("发送内容含有非法字符"),
					"登陆信息":("登陆信息")
			}
		}
		private function showChat(e:MouseEvent):void
		{
			_checkRankerInfo = [{label:("查看资料")}, {label:("屏蔽发言")},{label:("发送私聊")},{label:("加为好友")}]
			var cls:Class = Config.resourceLoader.getClass("Chat","chatComp");
			
			_chat = new  ChatComp(new cls());
			
			_chat.onLoadLang = onLoadLang;
			//_chat.onGameParam = App.instance.gameParameters;
			_chat.onLang = loadLang();
			_chat.init();
			//			layout.panelLayer.addView(this,_chat);
			content.addChild(_chat);
			//super.reposition(false);
			_chat.tip = iTip;
			_chat.playerId = 666666;
			_chat.nickName = "username";
			_chat.onTextLink = textLinkHandler;
			
			_chat.onSendChat = function (chatMessage:Object) : void
			{
			sendChatLimit(chatMessage);
			}
			_chat.initShowBtn(true);
		}
		
		private function chatHander(e:MouseEvent):void
		{
			var sendMessage:Object = new Object();
			sendMessage.eipIndex = "31,32";
			sendMessage.eipNum = "3,6";
			sendMessage.msgTxt = "圣达菲圣达菲";
			sendMessage.playerId = 666666;
			sendMessage.playName = "第一舰队";
			sendMessage.sex = undefined;
			sendMessage.type = 99;
			_chat.getChatData = [sendMessage];
		}
		
		
		
		private function gmMessageHandler(e:MouseEvent):void
		{
			var gmMessages:Array=new Array();
			var obj1:Object = new Object();
			obj1.message = "这里是公告一";
			obj1.keepSecs = 2;
			gmMessages.push(obj1);
			
			var obj2:Object = new Object();
			obj2.message = "这里是公告er";
			obj2.keepSecs = 10;
			gmMessages.push(obj2);
			this.visibleGmPost = true;
			_chat.visiblePost = true;
			showPostInfo(gmMessages);
		}
		
		private function showPostInfo(infoList:Array) : void
		{
			var len:int = infoList.length;
			if(len == 0)
			{
				visibleGmPost = false;
				_chat.visiblePost = false;
				return;
			}
			for(var i:int=0;i<len;i++)
			{
				var message:Object ={html:infoList[i].message,timeDis:infoList[i].keepSecs};
				infoList[i] = message;
			}
			
			_chat.getReceivePostList = infoList;
		}
		
		
		
		public function hide() : void{
			iTip.hide();
		}
		private var _tip:ITip;
		private var visibleGmPost:Boolean;
		public function get iTip() : ITip{
			if (!_tip){
				_tip = Tip.getInstance();
				_tip.oParent = content;//tip添加的位置影响其它根据tip位置布局的组件
			}
			return _tip;
		}
	}
}