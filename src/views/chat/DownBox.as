package views.chat
{
	import flash.display.Sprite;
	import com.panels.faction.McBox;
	
	public class DownBox extends Sprite
	{
		private var _onSendData:Function;
		private var _boxWidth:int = 86;
		private var _mcBox:McBox;
		private var _mcBoxList:Array;
		
		public function DownBox() : void
		{
			_onSendData = new Function();
		}
		
		public function set onSendData(value:Function) : void
		{
			_onSendData = value;
		}
		
		public function set getBoxList(value:Array) : void
		{
			renderBox(value);
		}
		
		public function set boxWidth(value:int) : void
		{
			_boxWidth = value;
		}
		
		private function renderBox(value:Array) : void
		{
			if(!value) return;
			var obj:Object;
			var list:Array = value;
			clearBox();
			_mcBoxList = [];
			var len:int = list.length;
			var i:int;
			while (i < len)
			{
				
				obj = list[i];
				_mcBox = new McBox();
				_mcBox.text = obj.label;
				_mcBox.mcData = obj;
				_mcBox.mcWidth = _boxWidth;
				_mcBox.boxId = i;
				_mcBox.y = i * _mcBox.height;
				_mcBox.x = 0.5;
				_mcBoxList.push(_mcBox);
				addChild(_mcBox);
				_mcBox.onSendData = function (param1:Object) : void
				{
					_onSendData(param1);
				}
				i = (i + 1);
			}
		}
		
		private function clearBox() : void
		{
			if (_mcBoxList == null)
			{
				return;
			}
			var mcBox:McBox = null;
			var len:int = _mcBoxList.length;
			var index:int = 0;
			while (index < len)
			{
				
				mcBox = _mcBoxList[index];
				mcBox.clear();
				removeChild(mcBox);
				mcBox = null;
				index = index + 1;
			}
			_mcBoxList = null;
		}
		
		public function clear() : void
		{
			clearBox();
		}
	}
}