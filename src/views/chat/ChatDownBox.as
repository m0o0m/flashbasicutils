package views.chat
{
	
	import flash.display.MovieClip;
	
	public class ChatDownBox extends MovieClip
	{
		
		private var _onSendData:Function;
		private var _onPlayerData:Object;
		private var _boxWidth:int = 86;
		private var _mcBox:ChatMcBoxComp;
		private var _mcBoxList:Array;
		
		public function ChatDownBox() : void
		{
			_onSendData = new Function();
		}
		
		public function set onSendData(param1:Function) : void
		{
			this._onSendData = param1;
		}
		
		public function set onPlayerData(param1:Object) : void
		{
			this._onPlayerData = param1;
		}
		
		public function set getBoxList(param1:Array) : void
		{
			this.renderBox(param1);
		}
		
		public function set boxWidth(param1:int) : void
		{
			this._boxWidth = param1;
		}
		
		private function renderBox(param1:Array) : void
		{
			var obj:Object;
			var list:Array = param1;
			this.clearBox();
			this._mcBoxList = [];
			var len:int = list.length;
			var i:int;
			while (i < len)
			{
				
				obj = list[i];
				_mcBox = new ChatMcBoxComp();
				_mcBox.text = obj.label;
				_mcBox.mcData = obj;
				_mcBox.mcWidth = _boxWidth;
				_mcBox.buttonMode = true;
				_mcBox.boxId = i;
				_mcBox.y = i * _mcBox.height;
				_mcBox.x = 0.5;
				_mcBoxList.push(_mcBox);
				addChild(_mcBox);
				this._mcBox.onSendData = function (param1:Object, param2:int) : void
				{
					_onSendData(param1, _onPlayerData);
					_mcBoxList[param2].isPitch = false;
					return;
				}
				i = (i + 1);
			}
		}
		
		private function clearBox() : void
		{
			if (this._mcBoxList == null)
			{
				return;
			}
			var len:int = this._mcBoxList.length;
			var _loc_2:int = 0;
			while (_loc_2 < len)
			{
				
				this._mcBoxList[_loc_2].clear();
				removeChild(this._mcBoxList[_loc_2]);
				this._mcBoxList[_loc_2] = null;
				_loc_2 = _loc_2 + 1;
			}
			this._mcBoxList = null;
		}
		
		public function clear() : void
		{
			this.clearBox();
			this._onPlayerData = null;
		}
	}
}