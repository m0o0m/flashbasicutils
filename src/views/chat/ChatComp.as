package views.chat
{
	import com.wg.assets.TextFieldUtils;
	import com.wg.ui.text.RichTextField;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.events.TimerEvent;
	import flash.filters.BlurFilter;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import views.alert.ITip;
	
	public class ChatComp extends MovieClip 
	{
		private var _content:MovieClip;
		
		public var allBtn:MovieClip;
		public var worldBtn:MovieClip;
		public var campBtn:MovieClip;
		public var factionBtn:MovieClip;
		public var gmBtn:MovieClip;
		public var backGround:MovieClip;
		public var sizeBtn:SimpleButton;
		public var sendBtn:SimpleButton;
		public var chatTypeBtn:MovieClip;
		public var faceBtn:MovieClip;
		public var _PostBox:MovieClip;
		public var hideBtn:SimpleButton;
		public var showBtn:SimpleButton;
		
		
		private var _systemChatInfo:String;
		private var _downBoxInfoList:Array;
		private var _onTextLink:Function = new Function();
		private var _chatMc:MovieClip;//盛放所显示文字的容器
		private var _btnList:Array;
		private var _allType:int=99;
		private var _chatShow:int = 99;
		private var _messageType:int=99;//记录当前所选聊天类型
		private var _allList:Array = [];
		private var _worldList:Array = [];	//记录世界聊天窗口的数据
		private var _factionList:Array = [];	//记录帮派聊天窗口的数据
		private var _campList:Array = [];	//记录阵营聊天窗口的数据
		private var _sendChatList:Array = [];
		private var _gotoMc:MovieClip;	//记录上一所选按钮的影片剪辑
		private var _chatTxt:RichTextField;//聊天记录框
		private var _sendTxt:RichTextField;
		private var _textFormat:TextFormat;
		private var _sendTextFormat:TextFormat;
		private var _timer:Timer;//控制聊天时间间隔
		private var _timerNum:int=0;
		private var _isSendEvent:Boolean = false;//用来控制响应文本的次数
		private var _sendChatId:int = 0;
		private var _eipDataId:Object;
		private var _onSendChat:Function = new Function();
		public var _showChatScale:int = 1;//记录输出窗口的当前大小
		private var _scrollbar:ScrollBar;
		private var _eipBar:EipBar;
		private var _isIntoEip:Boolean = true;//表情是否可输入
		private var sendStr:String="";
		private var _downBox:ChatDownBox;//下拉盒子
		private var _isClosePost:Boolean = false;
		private var _isMainPostShow:Boolean = false;
		private var _postTimerNum:int = 600;
		private var _postHideTime:int = 0;
		private var _postTimeDis:int = 10;
		private var _postTimer:Timer;
		private var _teceivePostList:Array;
		private var _isEmptyStr:Boolean = false;
		private var _stageClip:Point;
		private var _xy:Array;
		private var _postXY:Array;
		private var w:int=0;
		private var _playerId:int = 0;
		private var _nickName:String = "";
		private var _onOpenGm:Function = new Function();
		private var _townFormat:TextFormat;
		private var _tip:ITip;
		private var _factionChatInfo:String
		private var _worldChatInfo:String;
		private var _tipContent:Sprite;
		private var _broadcastInfoList:Array = [];
		private var _meleePanel:Function;
		private var _meleePanelTipMove:Function;
		private var _meleePanelTipReMove:Function;
		private var _lang:Object;
		private var _preSelect:int;
		private var _gameParam:Object;
		private var _onLoadLang:Function;
//		private var _view:View;
		
		public function ChatComp(content:MovieClip,view:* = null)
		{
//			_view = view;
			_content = content;
			this.addChild(_content);
			allBtn = content.allBtn;
			worldBtn = content.worldBtn;
			campBtn = content.campBtn;
			factionBtn = content.factionBtn;
			gmBtn = content.gmBtn;
			backGround = content.backGround;
			sizeBtn = content.sizeBtn;
			sendBtn = content.sendBtn;
			chatTypeBtn = content.chatTypeBtn;
			faceBtn = content.faceBtn;
			_PostBox = content._PostBox;
			hideBtn = content.hideBtn;
			showBtn = content.showBtn;
			backGround.alpha = 0;
		}
		
		public function set onLang(value:Object):void
		{
			_lang = value;
		}
		
		public function init():void
		{
			_systemChatInfo = _lang["登陆信息"];
			_systemChatInfo = _systemChatInfo.replace("\\n","\n");
			_systemChatInfo = _systemChatInfo.replace("\\n","\n");
			_systemChatInfo = _systemChatInfo.replace("\\n","\n");
			_systemChatInfo = _systemChatInfo.replace("\\n","\n");
			allBtn.mouseChildren=false;
			worldBtn.mouseChildren=false;
			campBtn.mouseChildren=false;
			factionBtn.mouseChildren=false;
			gmBtn.mouseChildren=false;
			gmBtn.visible = false;
			chatTypeBtn.mouseChildren=false;
			gmBtn.gotoAndStop(2);
			gmBtn.buttonMode=true;
			_PostBox.visible=false;
			_timer = new Timer(1000);
			_postTimer = new Timer(30);
			_chatShow = _allType;
			_postXY = [321, -315];
			_xy = [0, 392];
			x = _xy[0];
			y = _xy[1];
			
			showBtn.x=340;
			showBtn.y=15;
			hideBtn.x=340;
			hideBtn.y=15;
			
			_btnList = [{name:"all", type:_allType, list:_allList}, {name:"world", type:Constants.CHAT_TYPE_WORLD, list:_worldList}, {name:"camp", type:Constants.CHAT_TYPE_PERSONAL_ANNOUNCEMENT, list:_campList}, {name:"faction", type:Constants.CHAT_TYPE_ARMY, list:_factionList}, {name:"gm", type:"GM"}];
			_downBoxInfoList = [{label:_lang["世界"], type:Constants.CHAT_TYPE_WORLD},{label:_lang["军团"], type:Constants.CHAT_TYPE_ARMY}];
			
			_PostBox.postContent.mask =_PostBox._PostMiddleMask;
			_PostBox.postContent._PostInfo.autoSize = TextFieldAutoSize.LEFT
			addEvent();
			createScorllbar();
			addMc();
			addBoxData();
			addInputFile();
			defaultInfo();
			addFilters();
			addEipBar();
			addCountenance();
			//scrollbarTxt();
			addSendFile();
			
		}
		
		public function initShowBtn(show:Boolean =false):void
		{
			if(show)
			{
				hideBtn.visible = true;
				showBtn.visible = false;
			}else{
				toShowChatHandler();
				hideBtn.visible = false;
				showBtn.visible = false;
			}
		}
		
		private function addFilters() : void
		{
			var wordFilter:DropShadowFilter = new DropShadowFilter();
			wordFilter.blurX = 3;
			wordFilter.blurY = 3;
			wordFilter.distance = 0;
			wordFilter.alpha = 0.6;
			wordFilter.strength = 10;
			wordFilter.color = 0;
			wordFilter.quality = 1;
			_chatTxt.textfield.filters = [wordFilter];
		}
		
		private function addEvent():void
		{
			chatTypeBtn.buttonMode=true;
			chatTypeBtn.addEventListener(MouseEvent.CLICK,chatTypeHandler);
			addEventListener(MouseEvent.MOUSE_OVER,overHandler);
			addEventListener(MouseEvent.ROLL_OUT,outHandler);
			sizeBtn.addEventListener(MouseEvent.CLICK,sizeHandler);
			sendBtn.addEventListener(MouseEvent.CLICK,sendHandler);
			faceBtn.addEventListener(MouseEvent.CLICK,faceHandler);
			_timer.addEventListener(TimerEvent.TIMER,timerEvent);
			showBtn.addEventListener(MouseEvent.CLICK,toShowChatHandler);
			hideBtn.addEventListener(MouseEvent.CLICK,toHideChatHandler);
			
			
			faceBtn.buttonMode=true;
			renderBtn();
		}
		
		private function defaultInfo() : void
		{
			directlyChatData(_systemChatInfo,Constants.CHAT_TYPE_WORLD, true);
			var messageList:Array = chatDataToList(_onLoadLang("欢迎登陆"), Constants.CHAT_TYPE_ARMY);
			renderAll(messageList[0],_factionList,Constants.CHAT_TYPE_ARMY);
			_allList.pop();
		} 
		
		public function directlyChatData(startTxt:String, chatType:int, isAutoBottom:Boolean) : void
		{
			var messageList:Array = chatDataToList(startTxt, chatType);
			autoChatData(messageList, isAutoBottom);
		}
		
		private function autoChatData(messageList:Array, isAutoBottom:Boolean) : void
		{
			var chatMessage:Object = null;
			var len:int = messageList.length;
			var index:int = 0;
			while (index < len)
			{
				chatMessage = messageList[index];
				renderChat(chatMessage, isAutoBottom);
				index = index + 1;
			}
		}
		
		private function chatDataToList(str:String, type:int) : Array
		{
			var xml:XML= <rtf><text></text><sprites></sprites></rtf>;
			xml.text[0] = str;
			var message:Object = {};
			message.type = type;
			message.xmlInfo = xml;
			return [message];
		}
		
		private function addSendFile() : void
		{
			_sendTxt = new RichTextField();
			_sendTxt.x = 70;
			_sendTxt.y = 140;
			_sendTxt.setSize(210, 30);
			_sendTxt.type = RichTextField.INPUT;
			_sendTxt.focusRect = false;
			_sendTxt.textfield.multiline = false;
			_sendTextFormat= new TextFormat(TEXT_FONT_NAME, 15, 16777215);
			_sendTxt.defaultTextFormat = _sendTextFormat;
			addChild(_sendTxt);
			_sendTxt.addEventListener(MouseEvent.CLICK, sendTextClick);
			
			_sendTxt.addEventListener(FocusEvent.FOCUS_IN, onFocusInHandler);
			_sendTxt.addEventListener(FocusEvent.FOCUS_OUT, onFocusOutHandler);
			
			_sendTxt.addEventListener(MouseEvent.CLICK,onClickHandler);
		}
		
		private function onClickHandler(event:MouseEvent):void
		{
			if(stage.focus == _sendTxt.textfield) return;
			stage.focus = _sendTxt.textfield;
			
		}
		
		public function set sendFocus(value:Boolean):void
		{
			if(value){
				stage.focus = _sendTxt.textfield;
			}else{
				stage.focus = stage;
			}
		}
		
		public function get hasFocus():Boolean
		{
			if(stage.focus == _sendTxt.textfield)
			{
				return true;
			}else
			{
				return false;
			}
		}
		
		private function sendTextClick(event:MouseEvent) : void
		{
			if (_isSendEvent == false)
			{
				stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUpHandler);
				stage.addEventListener(MouseEvent.MOUSE_DOWN, stageMouseDown);
				_sendTxt.addEventListener(Event.CHANGE, sendTextChange);
				_isSendEvent = true;
			}
		}
		/**
		 *控制输入文本的长度，包括表情的个数 
		 */		
		private function sendTextChange(event:Event) : void
		{
			StaticUtils.INPUT_STATUS = false;
			//trace("面板" + StaticUtils.INPUT_STATUS);
			var xml:XML=_sendTxt.exportXML();
			var message:String = xml.text[0];
			var len:int = sendStr.length;
			var faceLen:int = xml.sprites.sprite.length();
			var messageLen:int= countStr(message);
			//控制输入框可以输入多少文本
			if (messageLen >= 60)
			{
				_sendTxt.textfield.maxChars = len;
			}
			else
			{
				_sendTxt.textfield.maxChars = 60;
				sendStr = message;
			}
			//表情多于十个 无法输入
			if (faceLen >= 10)
			{
				_isIntoEip = false;
			}
			else
			{
				_isIntoEip = true;
			}
		}
		
		private function countStr(str:String) : int
		{
			var strLen:int = 0;
			var len:int = str.length;
			var index:int = 0;
			while (index < len)
			{
				
				if (str.charCodeAt(index) > 127)
				{
					strLen = strLen + 2;
				}
				else
				{
					strLen = strLen + 1;
				}
				index = index + 1;
			}
			return strLen;
		}
		
		private function createScorllbar() : void
		{	
			_scrollbar = new ScrollBar();
		}
		
		private function stageMouseDown(event:MouseEvent) : void
		{
			if (!sendBtn.hitTestPoint(stage.mouseX, stage.mouseY))
			{
				clearSendTestEvent();
				stage.focus = null;
				_isSendEvent = false;
			}
		}
		
		private function clearSendTestEvent() : void
		{
			stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUpHandler);
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, stageMouseDown);
			_sendTxt.removeEventListener(Event.CHANGE, sendTextChange);
		}
		
		private function onKeyUpHandler(event:KeyboardEvent) : void
		{
			if (event.keyCode == 13)
			{
				//sendChatData(); 
				return;
			}
			if (_sendChatList.length <= 0)
			{
				return;
			}
			if (event.keyCode == Keyboard.UP)
			{
				_sendTxt.clear();
				_sendChatId--;
				limitNum();
				_sendTxt.importXML(_sendChatList[_sendChatId]);
				_sendTxt.caretIndex = _sendTxt.textfield.length;
			}
			if (event.keyCode == Keyboard.DOWN)
			{
				_sendTxt.clear();
				_sendChatId++;
				limitNum();
				_sendTxt.importXML(_sendChatList[_sendChatId]);
				_sendTxt.caretIndex = _sendTxt.textfield.length;
			}
		}
		
		
		public function sendChatData() : void
		{
			var xml:XML = <rtf><text></text><sprites></sprites></rtf>;
			var obj:Object = {};
			obj.type = _chatShow;
			obj.xmlInfo = xml;
			
			if (_sendTxt.textfield.text.length <= 0)
			{
				xml.text[0] = _lang["发送内容为空"];
				renderChat(obj, false, true);
			}
			else if (_timerNum > 0)
			{
				xml.text[0] = _lang["发送内容过快"];
				renderChat(obj, false, true);
				return;
			}
			//_timerNum = _gameParam.chatWorldCDTime;
			//_timer.start();
			renderSendData();
			
		}
		
		
		private function renderSendData() : void
		{
			var xml:XML = _sendTxt.exportXML();
			var message:String = xml.text[0];
			var len:int = xml.sprites.sprite.length();
			var faceIdArr:Array = [];
			var facePosArr:Array = [];
			var index:int = 0;
			while (index < len)
			{
				//			推断为此数组里存得是表情数据
				faceIdArr.push(_eipDataId[xml.sprites.sprite[index].@src].id);
				facePosArr.push(xml.sprites.sprite[index].@index);
				index = index + 1;
			}
			var faceId:String = faceIdArr.join(",");
			var facePos:String= facePosArr.join(",");
			var chatSendMessage:Object = {};
			if(faceId != "")
			{
				message = message + Constants.CHAT_MESSAGE_SEPARATOR1 + Constants.CHAT_MESSAGE_SEPARATOR1 + faceId + Constants.CHAT_MESSAGE_SEPARATOR1 + facePos;
			}
			chatSendMessage.type = _messageType;
			chatSendMessage.message = message;
			chatSendMessage.eipNum = faceId;//表示的是哪个表情排在哪个位置
			chatSendMessage.eipIndex = facePos;//表示的是排分别在哪个位置
			_onSendChat(chatSendMessage);
			_sendTxt.clear();
			_sendChatList.push(xml);
			if (_sendChatList.length > 10)
			{
				_sendChatList.splice(0, 1);
			}
			trace("message:"+message);
			sendSelf = chatSendMessage;
		}
		
		/**
		 *控制字数数量的函数 
		 */		
		private function limitNum() : void
		{
			var len:int =_sendChatList.length - 1;
			if (_sendChatId > len)
			{
				_sendChatId = 0;
			}
			if (_sendChatId < 0)
			{
				_sendChatId = len;
			}
		}
		
		/**
		 *显示聊天框里的内容 
		 */		
		private function renderChat(chatMessage:Object, isAutoBottom:Boolean, isInAllChat:Boolean = false) : void
		{
			
			switch(_chatShow)
			{
				case _allType:
				{
					renderAll(chatMessage,_allList,_allType);
					break;
				}
				case Constants.CHAT_TYPE_WORLD:
				{
					renderAll(chatMessage, _worldList, Constants.CHAT_TYPE_WORLD);
					break;
				}
				case Constants.CHAT_TYPE_PERSONAL_ANNOUNCEMENT:
				{
					renderAll(chatMessage, _campList,Constants.CHAT_TYPE_PERSONAL_ANNOUNCEMENT);
					break;
				}
				case Constants.CHAT_TYPE_PERSONAL_ANNOUNCEMENT:
				{
					renderAll(chatMessage, _campList,Constants.CHAT_TYPE_PERSONAL_ANNOUNCEMENT);
					break;
				}
				case Constants.CHAT_TYPE_ARMY:
				{
					renderAll(chatMessage, _factionList, Constants.CHAT_TYPE_ARMY);
					break;
				}
				default:
				{
					break;
				}
					
			}
			
		}
		
		private function renderAll(obj:Object, messageList:Array, type:int,isBottom:Boolean = true,isNewShow:Boolean = true) : void
		{
			if(_showChatScale==1)
			{
				_chatMc.y=-43;
			}
			else if(_showChatScale==2)
			{
				_chatMc.y=-210;
			}
			var index:int;
			var isNew:Boolean;
			if (isNewShow)
			{
				if(obj.type == Constants.CHAT_TYPE_WORLD){
					_allList.push(obj);
					_worldList.push(obj);
					if (_worldList.length > 40)
					{
						_worldList.splice(0,20);
					}
				}else if(obj.type == Constants.CHAT_TYPE_ARMY){
					_allList.push(obj);
					_factionList.push(obj);	
					if (_factionList.length > 40)
					{
						_factionList.splice(0,20);
					}
				}else if(obj.type == Constants.CHAT_TYPE_PERSONAL_ANNOUNCEMENT){
					_campList.push(obj);
					if (_campList.length > 40)
					{
						_campList.splice(0,20);
					}
				}else{
					_allList.push(obj);
				}
				
				if (_allList.length > 40)
				{
					_allList.splice(0,20);
				}
				/*trace("当前数组" + messageList);
				trace("全部" + _allList);
				trace("世界"  + _worldList);
				trace("军团" + _factionList);
				trace("系统" + _campList);*/
				//==========================================
				if (messageList.length > 40)
				{
					index = 0;
					while (index < 20)
					{		
						messageList.shift();
						index = index + 1; 
					}
					var xml:XML= <rtf><text></text><sprites></sprites></rtf>;
					var obj:Object = {};
					obj.type = type;
					obj.xmlInfo = xml;
					messageList.unshift(obj);
					isNew = true;
				}
				else
				{
					isNew = false;
				}
			}
			if(((_chatShow == _allType) && (type != Constants.CHAT_TYPE_PERSONAL_ANNOUNCEMENT)) || ( _chatShow == type))
			{
				if (isNewShow)
				{
					if (isNew == false)//是否将以前的聊天数据处理了
					{
						_chatTxt.importXML(obj.xmlInfo);
						renderChatData(messageList);
					}
					else
					{
						renderChatData(messageList);
					}
				}
				else
				{
					renderChatData(messageList);
				}
				
				_chatTxt.textfield.height = _chatTxt.textfield.textHeight + 3;
				_chatTxt.setSize(260,_chatTxt.textfield.height);
				_scrollbar.upData();
			}
		}
		
		
		private function timerEvent(event:TimerEvent) : void
		{
			if (_timerNum <= 0)
			{
				_timer.stop();
			}
			else
			{
				_timerNum=_timerNum-1;
			}
		}
		
		//影藏显示界面
		private function toShowChatHandler(e:MouseEvent =null):void
		{
			showBtn.mouseEnabled = false;
			TweenX.to(this,0).complete = tweenComplete;
		}
		
		private function toHideChatHandler(e:MouseEvent):void
		{
			hideBtn.mouseEnabled = false;
			TweenX.to(this,-340).complete = tweenComplete;
		}
		
		private function tweenComplete():void
		{
			if(!showBtn.mouseEnabled)
			{
				showBtn.mouseEnabled = true;
				showBtn.visible = false;
				hideBtn.visible = true;
			}else{
				hideBtn.mouseEnabled = true;
				hideBtn.visible = false;
				showBtn.visible = true;
			}
			
		}
		
		
		protected function faceHandler(event:MouseEvent):void
		{
			renderEipBar();
		}
		
		/**
		 *渲染表情符号的框 
		 * 处理框的显示位置
		 */
		private function renderEipBar() : void
		{
			var newPoint:Point;
			var handler:Function;
			//newPoint = localToGlobal(new Point(faceBtn.x,faceBtn.y));
			newPoint = new Point(faceBtn.x,faceBtn.y);
			if (_eipBar.parent)
			{
				handler = function () : void
				{
					_tipContent = _tip.clickToOpen(_eipBar);
					_tipContent.x = newPoint.x - _tip.stageOffset.x;
					_tipContent.y = newPoint.y - _eipBar.height - 10 - _tip.stageOffset.y;
					_eipBar.visible = true;
				}
				setTimeout(handler, 10);
			}
		}
		
		//		chatMc为显示聊天内容的容器
		private function addMc() : void
		{
			_chatMc = new MovieClip();
			_chatMc.y = -43;
			_chatMc.x = 25;
			addChild(_chatMc);
		}
		
		private function addInputFile():void
		{
			_textFormat = new TextFormat("Verdana", 13);
			_textFormat.leading = 5;
			
			_chatTxt = new RichTextField();
			_chatTxt.textfield.selectable = false;
			_chatTxt.textfield.autoSize =TextFieldAutoSize.LEFT;
			_chatTxt.placeholderMarginH = 1;
			_chatTxt.textfield.textColor = 16777215;
			_chatTxt.textfield.mouseWheelEnabled = false;
			_chatTxt.html = true;
			_chatTxt.mouseEnabled = false;
			_chatTxt.defaultTextFormat = _textFormat;
			_chatTxt.type=RichTextField.DYNAMIC;
			_chatTxt.autoScroll=true;
			_chatMc.addChild(_chatTxt);
			_chatTxt.addEventListener(TextEvent.LINK,textLink);	
			_scrollbar.STarget(350,149,_chatTxt);
			_chatMc.addChild(_scrollbar);
			_scrollbar.x = - 20;
			
		}
		
		private function onFocusInHandler(eventHandler:FocusEvent):void
		{
			StaticUtils.CHAT_FOCUS_STATUS = true;
		}
		
		private function onFocusOutHandler(eventHandler:FocusEvent):void
		{
			StaticUtils.CHAT_FOCUS_STATUS = false;
			
			this.sendFocus = false;
		}
		
		private function textLink(event:TextEvent) : void
		{
			var str:String = event.text;
			if (/^player|^item|^Soul|^openui/.test(str))
			{
				_onTextLink(event.text);
			}
			else
			{
				changeChatType(int(str));
			}
		}
		
		private function renderBtn() : void
		{
			var obj:Object = null;
			var len:int = _btnList.length;
			var index:int = 0;
			while (index < len)
			{
				
				obj = _btnList[index];
				obj.btn = this[obj.name+"Btn"];
				obj.handler = btnClick(obj);
				obj.btn.addEventListener(MouseEvent.CLICK, obj.handler);
				
				if (obj.type != _lang["GM"])
				{
					obj.btn.buttonMode = true;
					obj.btn._ShowBtn.alpha = 0;
					obj.btn._ShowBtn.mouseEnabled = false;
					obj.btn.txt.mouseEnabled=false;
					
					if (obj.type != _allType)
					{
						obj.btn.gotoAndStop(2);
					}
					else
					{
						_gotoMc = obj.btn;
					}
				}
				index = index + 1;
				
			}
			changeBtnTxtColor();
		}
		private function btnClick(data:Object) : Function
		{
			var func:Function = function (event:MouseEvent) : void
			{
				if (data.type != _lang["GM"])
				{
					changeChatType(data.type);
				}
				else
				{
					_onOpenGm();
				}
			}
			return func;
		}
		
		private function changeChatType(type:int,isDownBox:Boolean = false) : void
		{
			if(isDownBox)
			{
				switch(type)
				{
					case Constants.CHAT_TYPE_WORLD:
					{
						_messageType = Constants.CHAT_TYPE_WORLD;
						TextFieldUtils.setHtmlText(chatTypeBtn._Type.showTxt,_onLoadLang("世界"));
						break;
					}
					case Constants.CHAT_TYPE_ARMY:
					{
						_messageType = Constants.CHAT_TYPE_ARMY;
						TextFieldUtils.setHtmlText(chatTypeBtn._Type.showTxt,_onLoadLang("军团"));
						break;
					}
						
				}
				return;
			}
			if (_chatShow == type)
			{
				return;
			}
			_chatShow = type;
			
			_gotoMc._ShowBtn.alpha = 0;
			_gotoMc.gotoAndStop(2);
			setFontColor();
			switch(type)
			{
				case Constants.CHAT_TYPE_WORLD:
				{
					_messageType = Constants.CHAT_TYPE_WORLD;
					TextFieldUtils.setHtmlText(chatTypeBtn._Type.showTxt,_onLoadLang("世界"));
					_gotoMc.gotoAndStop(2);
					_gotoMc = worldBtn;
					worldBtn.gotoAndStop(1);
					renderChatData(_worldList);
					break;
				}
				case Constants.CHAT_TYPE_ARMY:
				{
					_messageType = Constants.CHAT_TYPE_ARMY;
					TextFieldUtils.setHtmlText(chatTypeBtn._Type.showTxt,_onLoadLang("军团"));
					_gotoMc = factionBtn;
					factionBtn.gotoAndStop(1);
					renderChatData(_factionList);
					break;
				}
				case Constants.CHAT_TYPE_PERSONAL_ANNOUNCEMENT:
				{
					_gotoMc = campBtn;
					campBtn.gotoAndStop(1);
					renderChatData(_campList);
					break;
				}
				case _allType:
				{
					_messageType = _allType;
					TextFieldUtils.setHtmlText(chatTypeBtn._Type.showTxt,_onLoadLang("世界"));
					_gotoMc = allBtn;
					allBtn.gotoAndStop(1);
					renderChatData(_allList);
					break;
				}
				default:
				{
					break;
				}
			}
			
			changeBtnTxtColor();
			
		}
		
		private function changeBtnTxtColor():void{
			TextField(_gotoMc.txt).textColor = 0xFFFF00;
		}
		
		private function setFontColor():void{
			TextFieldUtils.setHtmlText(allBtn.txt,"<font color='#FFFFFF'>" + _onLoadLang("综合") + "</font>",false,"",12); 
			TextFieldUtils.setHtmlText(worldBtn.txt,"<font color='#FFFFFF'>" + _onLoadLang("世界") + "</font>",false,"",12);
			TextFieldUtils.setHtmlText(factionBtn.txt,"<font color='#FFFFFF'>" + _onLoadLang("军团") + "</font>",false,"",12);
			TextFieldUtils.setHtmlText(gmBtn.txt,"<font color='#FFFFFF'>" + _onLoadLang("GM") + "</font>",false,"",12);
			TextFieldUtils.setHtmlText(campBtn.txt,"<font color='#FFFFFF'>" + _onLoadLang("系统") + "</font>",false,"",12);
			TextFieldUtils.setHtmlText(chatTypeBtn._Type.showTxt,_onLoadLang("世界"),false,"",12);
		}
		
		/**
		 *
		 * @param arr
		 * 
		 */
		private function renderChatData(arr:Array) : void
		{
			_chatTxt.clear();
			var len:int = arr.length;
			var index:int = 0;
			while (index < len)
			{
				_chatTxt.importXML(arr[index].xmlInfo);
				index = index + 1;
			}
			_chatTxt.setSize(260,_chatTxt.textfield.height);
			_scrollbar.upData();
		}
		
		protected function chatTypeHandler(event:MouseEvent):void
		{
			if (chatTypeBtn.buttonMode == false)
			{
				return;
			}
			if (factionBtn.visible)
			{
				renderBoxData("showType", _downBoxInfoList);
			}
		}
		
		private function renderBoxData(type:String, list:Array) : void
		{
			var newPoint:Point;
			var handler:Function;
			_downBox.y=50;
			_downBox.boxWidth = 50;
			_downBox.getBoxList = list;
			newPoint = localToGlobal(new Point(chatTypeBtn.x,chatTypeBtn.y));
			newPoint.y = newPoint.y - (_downBox.height + 10);
			if (_downBox.parent)
			{
				handler = function () : void
				{
					_tipContent = _tip.clickToOpen(_downBox);
					_tipContent.x = newPoint.x - _tip.stageOffset.x;
					_tipContent.y = newPoint.y - _tip.stageOffset.y;
					_downBox.visible = true;
				}
				setTimeout(handler, 10);
			}
		}
		
		protected function sendHandler(event:MouseEvent):void
		{
			sendChatData();
		}
		
		protected function sizeHandler(event:MouseEvent):void
		{
			_showChatScale = _showChatScale+1
			if (_showChatScale >2)
			{
				_showChatScale=0;
				changeShowChat();
			}
			changeShowChat();	
		}
		
		private function changeShowChat() : void
		{
			if (_showChatScale == 0)
			{
				_scrollbar.visible = false;
				_chatMc.visible = false;
				backGround.height = 0;
				backGround.y = 181;
				_meleePanelTipMove(2);
			}
			else if (_showChatScale == 1)
			{
				_scrollbar.visible = true;
				_chatMc.visible = true;
				backGround.height = 220;
				backGround.y = -55;
				_chatMc.y = -40;
				_scrollbar.setMask(300,150);
				_scrollbar.upData();
				_meleePanelTipMove(0);
			}
			else if (_showChatScale == 2)
			{
				backGround.height = 400;
				backGround.y = -218;
				_chatMc.y = -210;
				_scrollbar.setMask(300,320);
				_scrollbar.upData();
				_meleePanelTipMove(1);
			}
			
		}
		
		protected function outHandler(event:MouseEvent):void
		{
			backGround.alpha=0;
		}
		
		protected function overHandler(event:MouseEvent):void
		{
			backGround.alpha=1;
		}
		
		public function set playerId(value:int):void
		{
			_playerId = value;
		}
		
		public function set nickName(name:String):void
		{
			_nickName = name;
		}
		
		public function get content():Sprite
		{
			return this;
		}
		
		public function set tip(value:ITip):void
		{
			_tip = value;
			_tip.addTarget(sizeBtn, _lang["缩放聊天窗"]);
			_tip.addTarget(faceBtn, _lang["插入表情"]);
			_tip.addTarget(allBtn, _lang["综合"]);
			_tip.addTarget(worldBtn, _lang["世界"]);
			_tip.addTarget(factionBtn, _lang["军团"]);
			_tip.addTarget(campBtn, _lang["系统"]);
			_tip.addTarget(gmBtn, _lang["GM"]);
		}
		
		public function set onOpenGm(func:Function):void
		{
			_onOpenGm = func;
		}
		
		public function clear():void
		{
			clearSendTestEvent();
			clearFile();
			clearSendFile();
			clearScrollbar();
			clearScrollberTxt();
			clearMc();
			clearBox();
			_tip.removeTarget(sizeBtn);
			_tip.removeTarget(faceBtn);
			_tip.removeTarget(allBtn);
			_tip.removeTarget(worldBtn);
			_tip.removeTarget(factionBtn);
			_tip.removeTarget(campBtn);
			_tip.removeTarget(gmBtn);
			sizeBtn.removeEventListener(MouseEvent.CLICK,sizeHandler);
			sendBtn.removeEventListener(MouseEvent.CLICK, sendHandler);
			chatTypeBtn.removeEventListener(MouseEvent.CLICK,chatTypeHandler);
			faceBtn.removeEventListener(MouseEvent.CLICK,faceHandler);
			removeEventListener(MouseEvent.MOUSE_OVER, overHandler);
			removeEventListener(MouseEvent.MOUSE_OUT, outHandler);
			clearBtn();
		}
		
		private function clearBtn() : void
		{
			var btnObj:Object = null;
			var len:int = _btnList.length;
			var index:int = 0;
			while (index < len)
			{
				
				btnObj = _btnList[index]; 
				btnObj.btn.removeEventListener(MouseEvent.CLICK, btnObj.handler);
				index = index + 1;
			}
		}
		
		private function clearMc() : void
		{
			if (_chatMc != null&&_chatMc.parent)
			{
				_chatMc.parent.removeChild(_chatMc);
				_chatMc = null;
			}
		}
		
		private function clearScrollbar() : void
		{
			if (_scrollbar != null)
			{
				_scrollbar = null;
			}
		}
		
		private function clearSendFile() : void
		{
			if (_sendTxt != null && _sendTxt.parent)
			{
				_sendTextFormat = null;
				_sendTxt.removeEventListener(MouseEvent.CLICK, sendTextClick);
				_sendTxt.parent.removeChild(_sendTxt);
				_sendTxt = null;
			}
		}
		
		private function clearFile() : void
		{
			if (_chatTxt != null && _chatTxt.parent)
			{
				_chatTxt.clear();
				_chatTxt.parent.removeChild(_chatTxt);
				_chatTxt = null;
				_textFormat = null;
			}
		}
		
		public function set sendSelf(meMessage:Object):void
		{
			var messageStr:String=meMessage.message
			//dfsf/^/^32,34/^4,4 截取表情符号的各种信息
			//文字 	符号代码       各个符号位置
			var sendMessage:Object = {};
			var messageArr:Array=messageStr.split("/^")
			sendMessage.eipIndex = messageArr[2];
			sendMessage.eipNum = messageArr[3];
			sendMessage.msgTxt = messageArr[0];
			sendMessage.type = _messageType;
			sendMessage.playerId = _playerId;
			sendMessage.playName =_nickName;
			sendMessage.sex = meMessage.sex;
			this.getChatData = [sendMessage];
		}
		
		public function set changeChat(param1:int):void
		{
			changeChatType(param1);
		}
		
		/**
		 *将本地的object类型的聊天数据,转换为richtextfield接收的xml数据  
		 * 
		 * @param arr
		 * renderChatMessages[].xmlInfo
<rtf>
  <text>
    &lt;a&gt;&lt;font color="#ffffff"&gt;【1】&lt;/font&gt;&lt;/a&gt;&lt;font color="#ffcc99"&gt;&lt;a href = "event:player,666666,username,undefined"&gt;&lt;u&gt;username&lt;/u&gt; &lt;/a&gt;:&lt;font color='#ffffff'&gt;12312阿大声道撒的范德萨 &lt;/font&gt;
  </text>
  <sprites>
    <sprite src="Face31" index="18"/>
    <sprite src="Face19" index="22"/>
  </sprites>
</rtf>
		 */
		public function set getChatData(arr:Array):void
		{
			var renderChatMessages:Array = ChatDataChange.renderMessage(arr, _chatShow);
			/*	if(arr[0].type != _chatShow && _chatShow != _allType)
			{
			renderAll(renderChatMessages[0],seekMsgList(renderChatMessages[0].type),arr[0].type);
			}else */
			if(_chatShow != _allType){
				renderAll(renderChatMessages[0],seekMsgList(_chatShow),arr[0].type);
			}else
			{
				renderAll(renderChatMessages[0],seekMsgList(_chatShow),arr[0].type);
				//				autoChatData(renderChatMessages, false);//第二个函数控制是否自动滚动到显示的底部
			}
		}
		
		private function seekMsgList(type:int):Array
		{
			if(type == Constants.CHAT_TYPE_WORLD)
			{
				return _worldList;
			}else if(type == Constants.CHAT_TYPE_ARMY)
			{
				return _factionList;
			}else if(type == Constants.CHAT_TYPE_PERSONAL_ANNOUNCEMENT)
			{
				return _campList;
			}else
			{
				return _allList
			}
		}
		
		public function set onSendChat(func:Function):void
		{
			_onSendChat = func;
		}
		
		public function set onTextLink(func:Function) : void
		{
			_onTextLink = func;
		}
		
		public function set visibleFunction(value:int):void
		{
			_PostBox.visible = false;
			allBtn.visible = false;
			worldBtn.visible = false;
			factionBtn.visible = false;
			campBtn.visible = false;
			gmBtn.visible = false;
			sizeBtn.visible = false;
			if (value == 0)
			{
				TextFieldUtils.setHtmlText(chatTypeBtn._Type.showTxt,_onLoadLang("世界"));
			}
			_chatMc.y =-43;
			chatTypeBtn.mouseEnabled = false;
			chatTypeBtn.buttonMode = false;
			chatTypeBtn._Down.visible = false;
		}
		
		/**
		 * 设置顶部广播信息框的内容
		 */		
		public function set getReceivePostList(postList:Array):void
		{
			if (_teceivePostList == null)
			{
				_teceivePostList = postList;
			}else{
				_teceivePostList = _teceivePostList.concat(postList);
			}
			
			_isClosePost = false;
			
			if(_isOnRolling==0)
			{
				scrollbarTxt();
			}
			renderPostTxt();
		}
		
		public function set visiblePost(value:Boolean):void
		{
			_isMainPostShow = value;
			showPost();
		}
		
		public function reposition(stageWidNormal:int, stageHeiNormal:int, stageWidMax:int, stageHeiMax:int, clipPoint:Point,wid:int,hei:int):void
		{
			
			w = Math.max(stageWidNormal, Math.min(stageWidMax, stage.stageWidth));
			_stageClip = clipPoint;
			x=0
			y = Math.max(_xy[1] - clipPoint.y, Math.min(stageHeiMax, stage.stageHeight) - (stageHeiNormal - _xy[1]));
			var _loc_6:int = y - _xy[1];
			_PostBox.x = (w - _stageClip.x - _PostBox._PostMiddle.width) / 2;
			_PostBox.y = _postXY[1] - _loc_6+15;/// - 60;
		}
		
		private function renderEipData() : void
		{
			_eipDataId = {};
			var index:int = 1;
			while (index <= 35)
			{
				_eipDataId["Face" + index] = {};
				_eipDataId["Face" + index].id = index;
				index = index + 1;
			}
			
		}
		
		private function addEipBar() : void
		{
			renderEipData();//给每个表情复制id
			_eipBar = new EipBar();
			addChild(_eipBar);
			_eipBar.visible = false;
			_eipBar.onSendEip = function (param1:Object) : void
			{
				var xml:XML = null;
				var _loc_3:Object = null;
				if (_isIntoEip == true)//可以输入表情
				{
					_sendTxt.insertSprite(param1.name, _sendTxt.textfield.caretIndex);
					_sendTxt.caretIndex =	_sendTxt.caretIndex+1;//调节闪动条的位置
				}
				else
				{
					xml = <rtf><text></text><sprites></sprites></rtf>;
					_loc_3 = {};
					_loc_3.type = _chatShow;
					_loc_3.xmlInfo = xml;
					xml.text[0] = _lang["表情过多"];
					renderChat(_loc_3, false, true);
				}
				
			}
		}
		
		private function addBoxData() : void
		{
			_downBox = new ChatDownBox();
			addChild(_downBox);
			_downBox.onSendData = function (messageData:Object, playerData:Object) : void
			{
				_messageType = messageData.type;
				changeChatType(messageData.type,true);
			}
			_downBox.visible = false;
		}
		
		private function scrollbarTxt() : void
		{
			//			_PostBox.postContent._PostInfo.autoSize = TextFieldAutoSize.LEFT;
			//			_PostBox.postContent._PostClose.addEventListener(MouseEvent.CLICK,postCloseHandler);
			_postTimer.addEventListener(TimerEvent.TIMER,postTimerEvent);
			_postTimer.start();
		}
		
		private function postTimerEvent(event:TimerEvent) : void
		{
			if(_isOnRolling==1)
			{
				if(_PostBox.postContent.x<=-_PostBox.postContent.width)
				{
					_isOnRolling= 2;
				}else{
					_PostBox.postContent.x -=1;
				}
			}
			
			if(!_teceivePostList) return;
			
			if(_isOnRolling==2)
			{
				if( _teceivePostList.length<=0)
				{
					postCloseHandler(null);
				}else{
					renderPostTxt();
				}
			}
			
		}
		
		/**
		 *0、表示没有值、刚开始，1、表示正在移动，2、表示移动结束
		 */		
		private var _isOnRolling:int= 0;
		private var TEXT_FONT_NAME:String = "Verdana";
		private function renderPostTxt() : void
		{
			var _loc_5:int = 0;
			if (_teceivePostList[0] == null)
			{
				_isEmptyStr = true;
				showPost();
				return;
			}
			if (_teceivePostList.length<=0)
			{
				return;
			}
			var postInfoItem:Object =_teceivePostList.shift();
			_postTimeDis = postInfoItem.timeDis; 
			var htmlReg:RegExp = /<a""<a/;
			var isHtml:Boolean = htmlReg.test(postInfoItem.html);
			var postInfoStr:String = "";
			_isEmptyStr = isEmptyStr(postInfoItem.html);
			showPost();
			//			postInfoItem.html = "<b>" + postInfoItem.html + "</b>";
			if (isHtml == false)
			{
				postInfoStr = "<b>" + postInfoItem.html + "</b>";
			}
			else
			{
				postInfoStr = "<u><b>" + postInfoItem.html + "</b></u>";
			}
			
			_PostBox.postContent.x = _PostBox._PostMiddleMask.width;
			
			TextFieldUtils.setHtmlText(_PostBox.postContent._PostInfo,postInfoStr,false,"",14);
			
			_isOnRolling = 1;
			trace(_PostBox.x,_PostBox.parent,_PostBox.visible,_PostBox.alpha);
		}
		
		private static function isEmptyStr(param1:String) : Boolean
		{
			var len:int = param1.length;
			var index:int = 0;
			while (index < len)
			{
				
				if (param1.charAt(index) != "　")
				{
					return false;
				}
				index = index + 1;
			}
			return true;
		}
		
		private function postCloseHandler(event:MouseEvent) : void
		{
			_isOnRolling =0;
			_PostBox.visible = false;
			if(hideBtn.visible) hideBtn.mouseEnabled = true;
			if(showBtn.visible) showBtn.mouseEnabled = true;
			_isClosePost = true;
			_teceivePostList =null;
			
			clearScrollberTxt();
			showPost();
		}
		
		private function clearScrollberTxt() : void
		{
			//			_PostBox.postContent._PostClose.removeEventListener(MouseEvent.CLICK, postCloseHandler);
			_postTimer.removeEventListener(TimerEvent.TIMER, postTimerEvent);
			_postTimer.stop();
		}
		
		private function showPost() : void
		{
			if (_isClosePost)
			{
				_PostBox.visible = false;
				if(hideBtn.visible) hideBtn.mouseEnabled = true;
				if(showBtn.visible) showBtn.mouseEnabled = true;
				return;
			}
			if (_isMainPostShow)
			{
				_PostBox.visible = true;
				if(hideBtn.visible) hideBtn.mouseEnabled = false;
				if(showBtn.visible) showBtn.mouseEnabled = false;
			}
			else
			{
				_PostBox.visible = false;
				if(hideBtn.visible) hideBtn.mouseEnabled = true;
				if(showBtn.visible) showBtn.mouseEnabled = true;
			}
		}
		/**
		 * 外面控制收起
		 */		
		public function rolling():void{
			hideBtn.mouseEnabled = false;
			showBtn.mouseEnabled = true;
			TweenX.to(this,-340).complete = tweenComplete;
		}
		
		public function opening():void{
			showBtn.mouseEnabled = false;
			hideBtn.mouseEnabled = true;
			TweenX.to(this,0).complete = tweenComplete;
		}
		
		private function clearBox() : void
		{
			if (_downBox.parent)
			{
				_downBox.clear();
				_downBox.parent.removeChild(_downBox);
				_downBox = null;
			}
		}
		
		private function addCountenance() : void
		{
			var female:Female=new Female();
			var male:Male=new Male();
			var face1:Face1=new Face1();
			var face2:Face2=new Face2();
			var face3:Face3=new Face3();
			var face4:Face4=new Face4();
			var face5:Face5=new Face5();
			var face6:Face6=new Face6();
			var face7:Face7=new Face7();
			var face8:Face8=new Face8();
			var face9:Face9=new Face9();
			var face10:Face10=new Face10();
			var face11:Face11=new Face11();
			var face12:Face12=new Face12();
			var face13:Face13=new Face13();
			var face14:Face14=new Face14();
			var face15:Face15=new Face15();
			var face16:Face16=new Face16();
			var face17:Face17=new Face17();
			var face18:Face18=new Face18();
			var face19:Face19=new Face19();
			var face20:Face20=new Face20();
			var face21:Face21=new Face21();
			var face22:Face22=new Face22();
			var face23:Face23=new Face23();
			var face24:Face24=new Face24();
			var face25:Face25=new Face25();
			var face26:Face26=new Face26();
			var face27:Face27=new Face27();
			var face28:Face28=new Face28();
			var face29:Face29=new Face29();
			var face30:Face30=new Face30();
			var face31:Face31=new Face31();
			var face32:Face32=new Face32();
			var face33:Face33=new Face33();
			var face34:Face34=new Face34();
			var face35:Face35=new Face35();
		}
		
		public function onMove(value:Function):void
		{
			_meleePanelTipMove = value;
		}
		
		public function reMove(value:Function):void
		{
			_meleePanelTipReMove = value;
		}
		
		public function set onGameParam(value:Object):void
		{
			_gameParam = value;
		}
		
		public function set onLoadLang(value:Function):void
		{
			_onLoadLang = value;
			setFontColor();
		}
		
		public function openChatFunc(openNum:int):void
		{
			//var posList:Array = [114.9,170.35];
			if(openNum == 1)
			{
				factionBtn.visible = true;
				//factionBtn.x = posList[0];
				//campBtn.x = posList[1];
			}else
			{
				factionBtn.visible = false;
				//campBtn.x = posList[0];
			}
		}
		
	}
}