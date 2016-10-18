package views.chat
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;

	/**
	 *将每个表情对象（包含表情图案，侦听器，每个表情的背景）存储在数组。
	 */	
	
	public class EipBar extends EipbarBase
	{
		private var _onSendEip:Function;
		private var _btnList:Array;
//		private var me:EipBar;
		public function EipBar()
		{
			_onSendEip = new Function();
			renderEip();
			
		}
		
		public function set onSendEip(func:Function) : void
		{
			_onSendEip = func;
		}
		
		public function clear() : void
		{
			var faceBtn:Object = null;
			var len:int = this._btnList.length;
			var index:int = 0;
			while (index < len)
			{
				
				faceBtn = this._btnList[index];
				faceBtn.btn.removeEventListener(MouseEvent.CLICK, faceBtn.eipClick);
				faceBtn.btn.removeEventListener(MouseEvent.MOUSE_OVER, faceBtn.eipMouseOver);
				faceBtn.btn.removeEventListener(MouseEvent.MOUSE_OUT, faceBtn.eipMouseOut);
				faceBtn.btn.removeChild(faceBtn.eip);
				faceBtn.eip = null;
				removeChild(faceBtn.btn);
				faceBtn.btn = null;
				index = index + 1;
			}
			_btnList = null;
		}
		
		private function renderEip() : void
		{
			var faceObj:Object = null;
			var eipGround:EipBtnComp = null;
			var faceIndex:int = 0;
			var faceName:String = null;
			var faceClass:Class = null;
			var faceMc:MovieClip = null;
			_btnList = [];
			var index:int = 0;
			while (index < 35)
			{
				
				faceObj = {};
				eipGround = new EipBtnComp();
//			对表情进行排版
				eipGround.x = (eipGround.width + 2) * (index - 7 * Math.floor(index / 7));
				eipGround.y = Math.floor(index / 7) * (eipGround.height + 2);
				eipGround._Black.alpha = 0;
				eipGround.buttonMode = true;
				addChild(eipGround);
			
				faceIndex = index + 1;
				faceName = "Face" + faceIndex;
				faceClass = getDefinitionByName(faceName) as Class;//获取表情
				faceMc = new faceClass as MovieClip;
				faceMc.x =0;
				faceMc.y =0;
				faceMc.mouseChildren = false;
				faceMc.mouseEnabled = false;
				eipGround.addChild(faceMc);
				faceObj.eip = faceMc;
				faceObj.btn = eipGround;
				faceObj.name = faceName;
				faceObj.id = faceIndex;
				faceObj.eipClick = eipClick(faceObj);
				faceObj.eipMouseOver = eipMouseOver(faceObj);
				faceObj.eipMouseOut = eipMouseOut(faceObj);
				faceObj.btn.addEventListener(MouseEvent.CLICK, faceObj.eipClick);
				faceObj.btn.addEventListener(MouseEvent.MOUSE_OVER, faceObj.eipMouseOver);
				faceObj.btn.addEventListener(MouseEvent.MOUSE_OUT, faceObj.eipMouseOut);
				_btnList.push(faceObj);
				index = index + 1;
			}

		}
		
		private function eipClick(obj:Object) : Function
		{
			var data:Object = obj;
			var func:Function = function (event:MouseEvent) : void
			{
			trace("点击了" + obj.id);
				_onSendEip(data);
				if(event.currentTarget.parent){
				event.currentTarget.parent.visible=false;
				}
			}
			return func;
		}
		
		private function eipMouseOver(obj:Object) : Function
		{
			var data:Object = obj;
			var func:Function= function (event:MouseEvent) : void
			{
				data.btn._Black.alpha = 1;
			}
			return func;
		}
		
		private function eipMouseOut(obj:Object) : Function
		{
			var data:Object = obj;
			var func:Function= function (event:MouseEvent) : void
			{
				data.btn._Black.alpha = 0;
				return;
			}
			return func;
		}
		
	}
}