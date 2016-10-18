package views.chat
{
	
	import com.wg.assets.TextFieldUtils;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class McBox extends Sprite implements IBoxUI,IBoxUpdateUI
	{
		private var _mcData:Object;
		private var _boxId:int = 0;
		private var _onSendData:Function;
		private var _black:Sprite;
		private var _file:TextField;
		
		public function McBox()
		{
			this._onSendData = new Function();
			this.drawBlack();
			this.addFile();
			this.addEventListener(MouseEvent.CLICK, this.backClick);
			this.addEventListener(MouseEvent.MOUSE_OVER, this.backOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, this.backOut);
		}
		
		public function set mcData(param1:Object) : void
		{
			this._mcData = param1;
		}
		public function set mergeShow(p_boo:Boolean):void{
		}
		public function set showMergeComp(p_fun:Function):void{
		}
		public function set boxId(param1:int) : void
		{
			this._boxId = param1;
		}
		
		public function set htmlText(param1:String) : void
		{
			TextFieldUtils.setHtmlText(_file,param1);
		}
		
		public function set mcWidth(param1:int) : void
		{
			this._black.width = param1;
			this._file.width = param1;
		}
		public function get button():SimpleButton{
			return null;
		}
		public function set mcHeight(param1:int) : void
		{
			this._black.height = param1;
			this._file.height = param1;
		}
		
		public function set onSendData(param1:Function) : void
		{
			this._onSendData = param1;
		}
		
		public function set text(param1:String) : void
		{
			TextFieldUtils.setHtmlText(_file,param1);
		}
		
		public function clear() : void
		{
			this.clearFile();
			this.removeEventListener(MouseEvent.CLICK, this.backClick);
			this.removeEventListener(MouseEvent.MOUSE_OVER, this.backOver);
			this.removeEventListener(MouseEvent.MOUSE_OUT, this.backOut);
		}
		
		private function drawBlack() : void
		{
			this._black = new Sprite();
			this._black.graphics.beginFill(6113324);
			this._black.graphics.drawRect(0, 0, 50, 20);
			this._black.graphics.endFill();
			this._black.mouseEnabled = false;
			this._black.alpha = 0;
			addChild(this._black);
		}
		
		private function addFile() : void
		{
			this._file = new TextField();
			this._file.textColor = 16777215;
			this._file.selectable = false;
			this._file.autoSize = TextFieldAutoSize.LEFT;
			addChild(this._file);
		}
		
		private function clearFile() : void
		{
			if (this._file != null)
			{
			}
			if (this._file.parent)
			{
				this._file.parent.removeChild(this._file);
				this._file = null;
			}
			if (this._black != null)
			{
			}
			if (this._black.parent)
			{
				_black.parent.removeChild(this._black);
				_black = null;
			}
		}
		
		private function backOver(event:MouseEvent) : void
		{
			_black.alpha = 1;
		}
		
		private function backOut(event:MouseEvent) : void
		{
			_black.alpha = 0;
		}
		
		private function backClick(event:MouseEvent) : void
		{
			trace("��������ѡ��")
			this._onSendData(this._mcData);
		}
		
		public function set id(param1:int) : void{};
		
		public function get icon() : Sprite{
			return null
		};
		
		public function set lock(param1:Boolean) : void{};
		
		public function set num(param1:String) : void{};
		
		public function set itemName(param1:String) : void{};
		
		public function set itemPrice(param1:String) : void{};
		
		public function set lockLight(param1:Boolean) : void{};
		
		public function set light(param1:Boolean) : void{};
		
		public function set updateVisible(param1:Boolean) : void{};
		
		public function set onUpdate(param1:Function) : void{};
		
		public function get btnUpdate() : DisplayObject{
			return null
		};
		
		public function get content() : Sprite{
			return this;
		}
		public function set itemQuality(value:int) : void
		{
		}
		
	}
}