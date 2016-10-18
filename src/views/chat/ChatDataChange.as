package views.chat
{
	
	import com.ClientConstants;
	
	import flash.display.Sprite;
	
	public class ChatDataChange extends Object
	{
		private static var _smileys:Array = ["", "Face1", "Face2", "Face3", "Face4", "Face5", "Face6", "Face7", "Face8", "Face9",
			"Face10", "Face11", "Face12", "Face13", "Face14", "Face15", "Face16", "Face17","Face18","Face19","Face20","Face21",
			"Face22","Face23","Face24","Face25","Face26","Face27","Face28","Face29","Face30","Face31","Face32",
			"Face33","Face34","Face35","MaleComp", "Female"];
		/**
		 *保存聊天中所有的符号信息(faceobj对象)
		 *  faceobj.icon[].index:13		符号索引
		 * faceobj.icon[].isLoad true
		 * faceobj.icon[].src Face32
		 * faceobj.icon[].startNum 0
		 */
		private static var _eipList:Array;
		private static var _mainNum:int = 400;
		private static var shieldPlayerList:Array = [];
		private static var _eipBleak:String = " ";
		private static var _spaceStr:String = " 　　 ";
		private static var townMsg:Array;
		private static var isFirst:Boolean=false;
		
		public function ChatDataChange()
		{
		}
		
		/**
		 *处理消息频道 
		 * @param messageList
		 * @param chatType
		 * @return 
		 * 
		 */
		public static function renderMessage(messageList:Array, chatType:int) : Array
		{
			var messageObj:Object = null;
			var isShiled:Boolean = false;
			_eipList = [];
			var len:int = messageList.length;
			var index:int = 0;
			while (index < len)
			{
				
				messageObj = messageList[index];
				messageObj.nameNum = countStr(messageObj.playName);
				switch(messageObj.type)
				{
					case Constants.CHAT_TYPE_CAMP:
					{
						messageObj.chatType = "【" + (Constants.CHAT_TYPE_CAMP) + "】";
						messageObj.typeColor = "#ff00ff";
						break;
					}
					case Constants.CHAT_TYPE_WORLD:
					{
						messageObj.chatType = "【" + (Constants.CHAT_TYPE_WORLD) + "】";
						messageObj.typeColor = "#ffffff";
						break;
					}
					case Constants.CHAT_TYPE_ARMY:
					{
						messageObj.typeColor = "#00D2FF";
						messageObj.chatType = "【" + (Constants.CHAT_TYPE_ARMY) + "】";
						
						break;
					}
					case Constants.CHAT_TYPE_PERSONAL_ADVICE:
					{
						messageObj.chatType = "【" + (Constants.CHAT_TYPE_PERSONAL_ADVICE) + "】";
						messageObj.typeColor = "#ffff00";
						messageObj.playName = "";
						messageObj.showName = "";
						break;
					}
					case Constants.CHAT_TYPE_PUBLIC_ANNOUNCEMENT:
					{
						messageObj.chatType = "【" + (Constants.CHAT_TYPE_PUBLIC_ANNOUNCEMENT) + "】";
						messageObj.typeColor = "#ffff00";
						messageObj.playName = "";
						messageObj.showName = "";
						break;
					}
					case Constants.CHAT_TYPE_PERSONAL_ANNOUNCEMENT:
					{
						messageObj.chatType = "";
						messageObj.typeColor = "";
						messageObj.playName = "";
						messageObj.showName = "";
						break;
					}
					default:
					{
						messageObj.chatType = "【" + (Constants.CHAT_TYPE_WORLD) + "】";
						messageObj.typeColor = "#ffffff";
						break;
					}
				}
				messageObj.eipLive = {};
				//if (messageObj.eipIndex != ""&&messageObj.eipIndex!=undefined )
					if (messageObj.eipIndex != "" )
				{
					renderEip(messageObj);
				}
				renderEipAndStr(messageObj, _mainNum - messageObj.nameNum - 2, 0);
				renderEipList(messageObj);
				index = index + 1;
			}
			townChatInfo(messageList);
			return _eipList;
		}
		
		private static function renderEip(messageObj:Object) : void
		{
			var facePos:int = 0;
			var faceObj:Object = null;
			var faceIndexArr:Array = messageObj.eipIndex.split(",");
			var facePosArr:Array = messageObj.eipNum.split(",");
			var eipLiveObj:Object = messageObj.eipLive;
			var len:int = facePosArr.length;
			var index:int = 0;
			//根据输入符号长度来添加eip资源及位置
			while (index < len)
			{
				facePos = int(facePosArr[index]);
				if (messageObj.eipLive[facePos] == undefined)
				{
					eipLiveObj[facePos] = {};
					eipLiveObj[facePos].eip = [];
				}
				faceObj = {};
				//			test start
				faceObj.index = facePos + messageObj.chatType.length + messageObj.playName.length + 3;
				//				test end
				faceObj.src = _smileys[faceIndexArr[index]];
				faceObj.isLoad = false;
				eipLiveObj[facePos].eip.push(faceObj);
				eipLiveObj[facePos].isAllLoad = false;
				index = index + 1;
			}
		}
		
		private static function countStr(param1:String) : int
		{
			var strNum:int = 0;
			var len:int = param1.length;
			var index:int = 0;
			while (index < len)
			{
				
				if (param1.charCodeAt(index) > 127)
				{
					strNum = strNum + 2;
				}
				else
				{
					strNum = strNum + 1;
				}
				index = index + 1;
			}
			return strNum;
		}
		
		private static function renderEipAndStr(messageObj:Object, endPos:int, startPos:int) : void
		{
			var faceLen:int = 0;
			var i:int = 0;
			var faceMessageObj:Object = null;
			var messageStr:String = messageObj.msgTxt;
			var posIndex:int = startPos;
			var messageInfoStr:String = "";
			var messageStrLen:int = messageStr.length;
			var isMaxLen:Boolean = false;
			var faceObj:Object = {};
			faceObj["icon"] = [];
			faceObj.msgTxt = messageObj.msgTxt;
			faceObj.type=messageObj.type;
			
			var posNow:int = startPos;
			while (posNow < startPos + endPos)
			{
				if (messageObj.eipLive[posIndex] != undefined&&messageObj.eipLive[posIndex].isAllLoad == false)
				{
					faceLen = messageObj.eipLive[posIndex].eip.length;
					i = 0;
					while (i < faceLen)
					{
						
						faceMessageObj = messageObj.eipLive[posIndex].eip[i];
						if (faceMessageObj.isLoad == false)
						{
							faceMessageObj.startNum = startPos;
							faceMessageObj.index = faceMessageObj.index - startPos - 1;
							faceMessageObj.isLoad = true;
							faceObj["icon"].push(faceMessageObj);
							if (i == (faceLen - 1))
							{
								posNow = posNow + 4;
							}
							else
							{
								posNow = posNow + 1;
							}
							if (posNow >= startPos + endPos)
							{
								isMaxLen = true;
								break;
							}
							else
							{
								isMaxLen = false;
							}
						}
						i = i + 1;
					}
					if (isMaxLen == true)
					{
						break;
					}
					messageObj.eipLive[posIndex].isAllLoad = true;
				}
				else
				{
					if (messageStr.charCodeAt(posIndex) > 127)
					{
						posNow = posNow + 1;
					}
					messageInfoStr = messageInfoStr + messageStr.charAt(posIndex);
					posIndex = posIndex + 1;
					if (posIndex > messageStrLen)
					{
						break;
					}
				}
				posNow = posNow + 1;
			}
			faceObj.info = messageInfoStr;
			_eipList.push(faceObj);
			//			一次能显示的最大文字数
			if (posIndex <=messageStrLen)
			{
				renderEipAndStr(messageObj, _mainNum - _spaceStr.length, posIndex);
			}
		}
		
		private static function isEmptyStr(param1:String) : Boolean
		{
			var len:int = param1.length;
			var i:int = 0;
			while (i < len)
			{
				
				if (param1.charAt(i) != " ")
				{
				}
				if (param1.charAt(i) != "　")
				{
					return false;
				}
				i = i + 1;
			}
			return true;
		}
		
		private static function renderEipList(messageObj:Object) : void
		{
			var handlerMessage:Object = null;
			var xml:XML = null;
			var _loc_7:int = 0;
			var myStr:String="";
			var sexStr:String = null;
			var hasSex:Boolean = false;
			var sexIconObj:Object = null;
			var len:int= _eipList.length;
			var index:int = 0;
			while (index < len)
			{
				handlerMessage = _eipList[index];
				xml = <rtf><text></text><sprites></sprites></rtf>;
				if (handlerMessage.icon.length <= 1)
				{
					_eipBleak = "";
				}
				else
				{
					_eipBleak = " ";
				}
				if (index == 0)
				{
					handlerMessage.msgInfo = "<a>"+ "<font color=\"" + messageObj.typeColor + "\">" + //加上链接<a>会导致多一个字符
						messageObj.chatType + "</font>"+"</a>" + "<font color=\"#ffcc99\">" + "<a href = \"event:" + ClientConstants.TEXT_LINK_PLAYER + "," + messageObj.playerId + "," + messageObj.playName + "," + messageObj.sex + "\"><u>"  + messageObj.playName + "</u> </a>";
					
					
					if (messageObj.playName != "")
					{
						handlerMessage.msgInfo = handlerMessage.msgInfo + (":<font color='" + messageObj.typeColor +"'>" + handlerMessage.info + _eipBleak + "</font>");
					}
					else
					{
						handlerMessage.msgInfo = handlerMessage.msgInfo + ("<font color='" + messageObj.typeColor +"'>" + handlerMessage.info + _eipBleak + "</font>");
					}
					_loc_7 = messageObj.chatType.length + messageObj.playName.length + 1;
					hasSex = false;
					if (messageObj.sex == Constants.SEX_MALE)
					{
						sexStr = "Male";
						hasSex = true;
					}
					else if (messageObj.sex == Constants.SEX_FEMALE)
					{
						sexStr = "Female";
						hasSex = true;
					}
					if (hasSex)
					{
						sexIconObj = {index:messageObj.chatType.length, isLoad:true, src:sexStr, startNum:0};
						handlerMessage.icon.unshift(sexIconObj);
					}
					renderXml(xml, handlerMessage.icon, _loc_7, true);
					
				}
				else
				{
					handlerMessage.msgInfo = "<font color=\"#ffffff\">" + _spaceStr + handlerMessage.info + _eipBleak + "</font>";
					renderXml(xml, handlerMessage.icon, _spaceStr.length);
				}
				xml.text[0] = handlerMessage.msgInfo;
				handlerMessage.xmlInfo = xml;
				handlerMessage.type = messageObj.type;
				handlerMessage.playerId = messageObj.playId;
				handlerMessage.playName = messageObj.playName;
				index = index + 1;
			}
		}
		
		private static function renderXml(xml:XML, iconList:Array, param3:int = 0, param4:Boolean = false) : void
		{
			var iconObj:Object = null;
			var len:int = iconList.length;
			var index:int = 0;
			
			while (index <len)
			{
				
				iconObj = iconList[index];
				xml.sprites.appendChild (new XML(<sprite></sprite>));
				xml.sprites.sprite[index].@src = iconObj.src;
				if (index == 0)
				{
				}
				
				if (param4)
				{
					xml.sprites.sprite[index].@index = int(iconObj.index);
					
				}
				else
				{
					xml.sprites.sprite[index].@index = int(iconObj.index) + param3;
				}
				index = index + 1;
			}
		}
		
		/**
		 *将消息转换为xml 
		 * @param messageArr
		 * @return 
		 *  
		 */
		public static function townChatInfo(messageArr:Array) : Array
		{
			var message:Object = null;
			var newMessageObj:Object = null;
			var xml:XML = null;
			var messageStr:String = null;
			townMsg = [];
			var messageArr_Len:int = messageArr.length;
			var index:int = 0;
			while (index < messageArr_Len)
			{
				
				message = messageArr[index];
				newMessageObj = {};
				newMessageObj.iconList = [];
				xml = <rtf><text></text><sprites></sprites></rtf>;
				//if (message.eipIndex != ""&&message.eipIndex!=undefined)
					if (message.eipIndex != "")
				{
					newMessageObj.iconList = renderTownMsgIcon(message);
					renderXml(xml, newMessageObj.iconList);
				}
				messageStr = "<font color=\"#F5E49F\">" + message.msgTxt + "</font>";
				xml.text[0] = messageStr;
				newMessageObj.iconLen = newMessageObj.iconList.length;
				newMessageObj.info = message.msgTxt;
				newMessageObj.msgLen = message.msgTxt.length + newMessageObj.iconLen;
				newMessageObj.playerName = message.playName;
				newMessageObj.type = message.msgType;
				newMessageObj.xmlInfo = xml;
				townMsg.push(newMessageObj);
				index = index + 1;
			}
			return townMsg;
		}
		
		private static function renderTownMsgIcon(param1:Object) : Array
		{
			var _loc_7:Object = null;
			var _loc_2:* = param1.eipIndex.split(",");
			var _loc_3:* = param1.eipNum.split(",");
			var _loc_4:Array = [];
			var _loc_5:* = _loc_2.length;
			var _loc_6:int = 0;
			while (_loc_6 < _loc_5)
			{
				
				_loc_7 = {};
				_loc_7.index = _loc_2[_loc_6];
				_loc_7.src = _smileys[_loc_3[_loc_6]];
				_loc_4.push(_loc_7);
				_loc_6 = _loc_6 + 1;
			}
			return _loc_4;
		}
		
	}
}
