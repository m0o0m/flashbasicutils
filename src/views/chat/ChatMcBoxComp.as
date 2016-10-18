package views.chat
{
	
	import com.wg.assets.TextFieldUtils;
	
	import flash.events.MouseEvent;

	public class ChatMcBoxComp extends McBoxBaseComp
	{
		
		private var _mcData:Object;
		private var _isPitch:Boolean = false;
		private var _boxId:int = 0;
		private var _onSendData:Function;
		
		public function ChatMcBoxComp()
		{
			_onSendData = new Function();
			_Name.mouseEnabled = false;
			_Back.addEventListener(MouseEvent.CLICK,backClick);
			_Back.addEventListener(MouseEvent.MOUSE_OVER,backOver);
			_Back.addEventListener(MouseEvent.MOUSE_OUT,backOut);

		}
		
		public function set mcData(param1:Object) : void
		{
			_mcData = param1;

		}
		
		public function set isPitch(param1:Boolean) : void
		{
			_isPitch = param1;
		_Back.gotoAndStop(1);

		}
		
		public function set boxId(param1:int) : void
		{
		_boxId = param1;
			
		}
		
		public function set htmlText(param1:String) : void
		{
		TextFieldUtils.setHtmlText(_Name,param1);
		}
		
		public function set mcWidth(param1:int) : void
		{
			_Back.width = param1;
			_Name.width = param1;
			
		}
		
		public function set mcHeight(param1:int) : void
		{
			_Back.height = param1;
			_Name.height = param1;
		
		}
		
		public function set onSendData(param1:Function) : void
		{
			_onSendData = param1;
			
		}
		
		public function set text(param1:String) : void
		{
			TextFieldUtils.setHtmlText(_Name,param1);
		}
		
		public function clear() : void
		{
		_mcData = null;
		_Back.mouseEnabled = false;
		_Name.mouseEnabled = false;
		_Back.removeEventListener(MouseEvent.CLICK,backClick);
		_Back.removeEventListener(MouseEvent.MOUSE_OVER, backOver);
		_Back.removeEventListener(MouseEvent.MOUSE_OUT,backOut);
		
		}
		
		private function backOver(event:MouseEvent) : void
		{
			_Back.gotoAndStop(2);
		}
		
		private function backOut(event:MouseEvent) : void
		{
			if (_isPitch)
			{
				return;
			}
			_Back.gotoAndStop(1);
		
		}
		
		private function backClick(event:MouseEvent) : void
		{
			if (_isPitch)
			{
				return;
			}
			_isPitch = true;
			if (_mcData)
			{
				_onSendData(_mcData,_boxId);
			}
			if(this.parent!=null){
			this.parent.visible=false;
			}
		}
	}
}