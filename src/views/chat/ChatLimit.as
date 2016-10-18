package views.chat
{
	
	public class ChatLimit extends Object
	{
		private static var shieldChat:Array = ["①", "②", "③", "④", "⑤", "⑥", "⑦", "⑧", "⑨", "⑩", "㈠", "㈡", "㈢", "㈣", "㈤", "㈥", "㈦", "㈧", "㈨", "㈩", "⑴", "⑵", "⑶", "⑷", "⑸", "⑹", "⑺", "⑻", "⑽", "⑼", "⒇", "⒆", "⒅", "⒄", "⒃", "⒂", "⒁", "⒀", "⑿", "⑾", "⒈", "⒒", "⒔", "⒓", "⒉", "⒊", "⒋", "⒕", "⒖", "⒌", "⒍", "⒗", "⒘", "⒎", "⒏", "⒙", "⒚", "⒐", "⒑", "⒛", "零", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖", "拾", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "１", "２", "３", "４", "５", "６", "７", "８", "９", "０", "❶", "❷", "❸,", "❹", "❺", "❻", "❼", "❽", "❾", "⒈", "⒉", "⒊", "⒋", "⒍", "⒌", "⒎", "⒏", "⒐"];
		
		public function ChatLimit()
		{
			return;
		}
		
		public static function isSendTrue(message:Object, param2:int, param3:int) : Boolean
		{
			var shieldChatArr_Index:int = 0;
			var messageStr:String = message.message;
			var messageStrLen:int = messageStr.length;
			var repeatChatNum:int = 0;
			var shieldChatArr:Array = shieldChat;
			var shieldChatArr_Len:int = shieldChatArr.length;
			var index:int = 0;
			while (index < messageStrLen)
			{
				
				shieldChatArr_Index = 0;
				while (shieldChatArr_Index < shieldChatArr_Len)
				{
					
					if (messageStr.charAt(index) == shieldChatArr[shieldChatArr_Index])
					{
						repeatChatNum = repeatChatNum + 1;
						if (repeatChatNum >= param3)
						{
							return false;
						}
					}
					shieldChatArr_Index = shieldChatArr_Index + 1;
				}
				index = index + 1;
			}
			return true;
		}
		
		public static function wordsLimit(param1:Object) : Boolean
		{
			var _loc_6:String = null;
			var _loc_2:* = param1.message;
			var len:int = _loc_2.length;
			var _loc_4:String = "";
			var index:int = 0;
			while (index < len)
			{
				
				_loc_6 = _loc_2.charAt(index);
				if (_loc_6 != " ")
				{
				}
				if (_loc_6 != "　")
				{
					_loc_4 = _loc_4 + _loc_6;
				}
				index = index + 1;
			}
			return /壹|贰|叁|肆|伍|陆|柒|捌|玖|拾|佰|仟|①|②|③|④|⑤|⑥|⑦|⑧|⑨|⑩|㈠|㈡|㈢|㈣|㈤|㈥|㈦|㈧|㈨|㈩|⑴|⑵|⑶|⑷|⑸|⑹|⑺|⑻|⑼|⑽|叄|泗|汣|氿|叭|扒|妧|貦|萬|贎|莞|圆|圜|賲|宝|寳|圜寳|窷|聨|聫|聯|芫|架q|扣扣|蔻蔻|参参|送万寿无疆|\+飞仙|\+VIP满级|飞仙\+VIP|万寿无疆\+|\+万寿无疆|飞仙\+|送飞仙|送VIP|送vip|q:|送紫色装备|霖|億|蔻|疆|源|飛|q\+""壹|贰|叁|肆|伍|陆|柒|捌|玖|拾|佰|仟|①|②|③|④|⑤|⑥|⑦|⑧|⑨|⑩|㈠|㈡|㈢|㈣|㈤|㈥|㈦|㈧|㈨|㈩|⑴|⑵|⑶|⑷|⑸|⑹|⑺|⑻|⑼|⑽|叄|泗|汣|氿|叭|扒|妧|貦|萬|贎|莞|圆|圜|賲|宝|寳|圜寳|窷|聨|聫|聯|芫|架q|扣扣|蔻蔻|参参|送万寿无疆|\+飞仙|\+VIP满级|飞仙\+VIP|万寿无疆\+|\+万寿无疆|飞仙\+|送飞仙|送VIP|送vip|q:|送紫色装备|霖|億|蔻|疆|源|飛|q\+/i.test(_loc_4);
		}
		
	}
}