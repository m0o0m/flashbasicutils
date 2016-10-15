package views.alert
{
	import com.ClientConstants;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	public class AlertComp extends Sprite implements IAlert
	{
		public var _Content:TextField;
		public var _Checked:MovieClip;
		public var _Yes:MovieClip;
		public var _No:MovieClip;
		public var _Cancel:MovieClip;
		private var _yesLabelTip:String = "";
		private var _noLabelTip:String = "";
		private var _cancelLabelTip:String = "";
		private var _yesLabel:String = "Yes";
		private var _noLabel:String = "No";
		private var _cancelLabel:String = "Cancel";
		private var _yesEnabled:Boolean = true;
		private var _noEnabled:Boolean = true;
		private var _cancelEnabled:Boolean = true;
		private var _firstButton:uint = 1;
		private var _hasCheckbox:Boolean = false;
		private var _tip:ITip;
		private var _parent:Sprite;
		private var _visible:Boolean = false;
		private var _closeHander:Function;
		private var _paratermetes:Array;
		private var _defaultPosition:Dictionary;
		private var _infoDefaultWidth:int = 330;
		private var _defaultX:Number;
		private var _defaultY:Number;
		private var _defaultW:Number;
		private var _defaultH:Number;
		private var _minW:int;
		private var _minH:int;
		private var _maxW:int;
		private var _maxH:int;
		private var _timerIn:Timer;
		private var _listIn:Array;
		private var _timerOut:Timer;
		private var _list:Array;
		private var _onLoadLang:Function;
		private var _content:MovieClip;
		
		public static const TEXTFONT:String = "Verdana";
		public static const TEXTSIZE:uint = 12;
		public function AlertComp(con:MovieClip)
		{
			if(!con) throw new Error("弹出框资源不存在");
			_content = con;
			this.addChild(_content);
			_Content = _content._Content;
			_Checked = _content._Checked;
			_Yes = _content._Yes;
			_No = _content._No;
			_Cancel = _content._Cancel;
			_defaultPosition = new Dictionary();
			_listIn = [];
			_list = [];
			
			_Checked.buttonMode = true;
			_Checked.useHandCursor = true;
			settleButton(_Yes, _yesLabel);
			settleButton(_No, _noLabel);
			settleButton(_Cancel, _cancelLabel);
			_defaultW = width;
			_defaultH = height;
			_Checked.mouseChildren=false;
			_Yes.mouseChildren=false;
			_No.mouseChildren=false;
			_Cancel.mouseChildren=false;
		}
		private function setHtmlText(textField:TextField, htmlText:String, number:Boolean = false, font:String = "", size:int = 0):void
		{
			if(textField == null) return;
			
			var textFont:String;
			var textSize:int;
			
			if(!number){
				textFont = TEXTFONT;
				textSize = TEXTSIZE;
			}else{
				textFont = TEXTFONT;
				textSize = TEXTSIZE;
			}
			
			if(font != "") textFont = font;
			if(size != 0) textSize = size;
			//			textField.htmlText = "<font face = '" + textFont + "' size = '" + textSize + "'>" + htmlText + "</font>";
			
			textField.htmlText = "<font face = \"" + textFont + "\" size = \"" + textSize + "\">" + htmlText + "</font>";
		}
		public function reposition(normalWid:int, normalHei:int, maxWid:int, maxHei:int) : void
		{
			if (normalWid)
			{
				_minW = normalWid;
			}
			else
			{
				normalWid = _minW;
			}
			if (normalHei)
			{
				_minH = normalHei;
			}
			else
			{
				normalHei = _minH;
			}
			if (maxWid)
			{
				_maxW = maxWid;
			}
			else
			{
				maxWid = _maxW;
			}
			if (maxHei)
			{
				_maxH = maxHei;
			}
			else
			{
				maxHei = _maxH;
			}
			if (_parent == null || parent == null)
			{
				return;
			}
			var stageWid:int = Math.max(normalWid, Math.min(maxWid, stage.stageWidth));
			var stageHei:int = Math.max(normalHei, Math.min(maxHei, stage.stageHeight));
			_parent.graphics.clear();
			_parent.graphics.beginFill(0, 0);
			_parent.graphics.drawRect(0, 0, _parent.stage.stageWidth, _parent.stage.stageHeight);
			_parent.graphics.endFill();
			x = Math.floor((stageWid - width) / 2);
			y = Math.floor((stageHei - height) / 2);
			_defaultX = x;
			_defaultY = y;
			return;
		} 
		
		public function show(alertInfoTxt:String, btnType:uint = 1, closeFunc:Function = null,paraters:Array=null) : void
		{
			formatText(alertInfoTxt);
			_closeHander = closeFunc;
			_paratermetes = paraters;
			buttonState(_Yes, _yesLabel, _yesLabelTip, _yesEnabled);
			buttonState(_No, _noLabel, _noLabelTip, _noEnabled);
			buttonState(_Cancel, _cancelLabel, _cancelLabelTip, _cancelEnabled);
			var btnArr:Array = [];
			switch(btnType)
			{
				case 1:
				{
					yesVisible = true;
					btnArr.push(_Yes);
					break;
				}
				case 2:
				{
					noVisible = true;
					btnArr.push(_No);
					break;
				}
				case 3:
				{
					yesVisible = true;
					noVisible = true;
					btnArr.push(_Yes, _No);
					break;
				}
				case 4:
				{
					cancelVisible = true;
					btnArr.push(_Cancel);
					break;
				}
				case 5:
				{
					yesVisible = true;
					cancelVisible = true;
					noVisible=false;
					btnArr.push(_Yes, _Cancel);
					break;
				}
				case 6:
				{
					noVisible = true;
					cancelVisible = true;
					btnArr.push(_No, _Cancel);
					break;
				}
				case 7:
				{
					yesVisible = true;
					noVisible = true;
					cancelVisible = true;
					btnArr.push(_Yes, _No, _Cancel);
					break;
				}
				default:
				{
					yesVisible = true;
					btnArr.push(_Yes);
					break;
				}
			}
			var _loc_5:int = 10;
			var _loc_6:* = (btnArr.length - 1) * _loc_5 + btnArr[0].width * btnArr.length;
			var _loc_7:* = (width - _loc_6) / 2;
			var i:int = 0;
			while (i < btnArr.length)
			{
				
				btnArr[i].x = _loc_7 + i * (btnArr[i].width + _loc_5);
				i++;
			}
			_Checked.visible = _hasCheckbox;
			_Checked._Box.gotoAndStop(1);
			_Checked.addEventListener(MouseEvent.CLICK, onCheckedHandler);
			if (_parent)
			{
				_parent.addChild(this);
				_visible = true;
			}
			reposition(0, 0, 0, 0);
			visible = false;
			startFadeIn();
		}
		
		//		private function formatText(param1:String) : void
		//		{
		//			_Content.autoSize = TextFieldAutoSize.LEFT;
		//			_Content.multiline = true;
		//			_Content.wordWrap = true;
		//			var textFormat:TextFormat= new TextFormat();
		//			textFormat.leading = 3;
		//			textFormat.align = "center";
		//			var isMulitline:Boolean = /\r|\n|<br>|<br \/>/.test(param1);
		//			if (_Content.width > _infoDefaultWidth || isMulitline)
		//			{
		//				textFormat.align = isMulitline ? ("center") : ("left");
		//				_Content.y = 13;
		//				_Content.height = 80;
		//				_Content.multiline = true;
		//				_Content.wordWrap = true;
		//			}else{
		//				_Content.y = 45;
		//				_Content.height = 18;
		//			}
		//			_Content.width = _infoDefaultWidth;
		//			_Content.setTextFormat(textFormat);
		//			TextFieldUtils.setHtmlText(_Content,param1);
		//			_Content.height = _Content.textHeight + 5;
		//			if(_Content.height > 50) _Content.y = 13;
		//		}
		
		private function formatText(param1:String) : void
		{
			_Content.autoSize = TextFieldAutoSize.LEFT;
			_Content.multiline = false;
			_Content.wordWrap = false;
			setHtmlText(_Content,param1);
			if(_Content.textWidth + 5 > 330){
				_Content.width = 330;
				_Content.multiline = true;
				_Content.wordWrap = true;
			}else{
				_Content.width = _Content.textWidth + 5;
			}
			_Content.height = _Content.textHeight+5;
			_Content.x = 15 + (330 -_Content.width)/2;
			_Content.y = 15 + (80-_Content.height)/2;
		}
		
		public function hide() : void
		{
			startFadeOut();
			if (_parent)
			{
				_parent.graphics.clear();
			}
			if (parent)
			{
				parent.removeChild(this);
			}
			if (_tip)
			{
				_tip.hide();
				_tip.removeTarget(_Yes);
				_tip.removeTarget(_No);
				_tip.removeTarget(_Cancel);
			}
			_yesLabelTip = "";
			_noLabelTip = "";
			_cancelLabelTip = "";
			_yesLabel = "Yes";
			_noLabel = "No";
			_cancelLabel = "Cancel";
			_yesEnabled = true;
			_noEnabled = true;
			_cancelEnabled = true;
			_hasCheckbox = false;
			_visible = false;
			return;
		}
		
		private function onCheckedHandler(event:MouseEvent) : void
		{
			var frame:int = _Checked._Box.currentFrame;
			_Checked._Box.gotoAndStop(frame == 1 ? (2) : (1));
		}
		
		private function settleButton(param1:MovieClip, param2:String) : void
		{
			setHtmlText(param1._Name,param2);
			param1._Name.mouseEnabled = false;
			param1.buttonMode = true;
			param1.visible = true;
			_defaultPosition[param1] = new Point(param1._Name.x, param1._Name.y);
			param1.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverHandler);
			param1.addEventListener(MouseEvent.MOUSE_OUT, onMouseOutHandler);
			param1.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);
			param1.addEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
			param1.addEventListener(MouseEvent.CLICK, onClickHandler);
		}
		
		private function onMouseOverHandler(event:MouseEvent) : void
		{
			event.target.gotoAndStop(2);
		}
		
		private function onMouseOutHandler(event:MouseEvent) : void
		{
			event.target.gotoAndStop(1);
			event.target._Name.x = _defaultPosition[event.target].x;
			event.target._Name.y = _defaultPosition[event.target].y;
		}
		
		private function onMouseDownHandler(event:MouseEvent) : void
		{
			event.target.gotoAndStop(3);
			event.target._Name.x = _defaultPosition[event.target].x + 1;
			event.target._Name.y = _defaultPosition[event.target].y + 1;
		}
		
		private function onMouseUpHandler(event:MouseEvent) : void
		{
			event.target.gotoAndStop(2);
			event.target._Name.x = _defaultPosition[event.target].x;
			event.target._Name.y = _defaultPosition[event.target].y;
		}
		
		private function onClickHandler(event:MouseEvent) : void
		{
			var btnType:int = ClientConstants.ALERT_BUTTON_YES;
			if (event.target == _No)
			{
				btnType = ClientConstants.ALERT_BUTTON_NO;
			}
			else if (event.target == _Cancel)
			{
				btnType = ClientConstants.ALERT_BUTTON_CANCEL;
			}
			hide();
			if (_closeHander is Function)
			{
				if(_paratermetes&&_paratermetes.length>0)
				{
					trace(_paratermetes[0]+"---------");
					_closeHander(btnType,_paratermetes);
				}else{
					_closeHander(btnType);
				}
			}
		}
		
		private function set yesVisible(value:Boolean) : void
		{
			_Yes.visible = value;
		}
		
		private function set noVisible(value:Boolean) : void
		{
			_No.visible = value;
		}
		
		private function set cancelVisible(value:Boolean) : void
		{
			_Cancel.visible = value;
		}
		
		private function buttonState(param1:MovieClip, param2:String, param3:String, param4:Boolean) : void
		{
			param1.visible = false;
			setHtmlText(param1._Name,param2);
			param1.mouseEnabled = param4;
			param1.filters = param4 ? ([]) : ([ClientConstants.GLOBAL_FILTER_SHADOW_SERIOUS]);
			if (param3)
			{
				_tip.addTarget(param1, param3);
			}
		}
		
		public function defaultCloseEvent() : void
		{
			hide();
			if (_closeHander is Function)
			{
				if(_paratermetes&&_paratermetes.length>0)
				{
					_closeHander(_firstButton,_paratermetes)
				}else{
					_closeHander(_firstButton);
				}
			}
			return;
		}
		
		private function startFadeIn() : void
		{
			if (_parent == null)
			{
				return;
			}
			if (_timerIn == null)
			{
				_timerIn = new Timer(10);
				_timerIn.addEventListener(TimerEvent.TIMER, onFadeIn);
			}
			var _loc_1:* = new BitmapData(width, height, true, 0);
			_loc_1.draw(this);
			var _loc_2:* = new Bitmap(_loc_1);
			_parent.addChild(_loc_2);
			_loc_2.scaleX = 0.5;
			_loc_2.scaleY = 0.5;
			_loc_2.x = _defaultX + (_defaultW - _loc_2.width) / 2;
			_loc_2.y = _defaultY + (_defaultH - _loc_2.height) / 2;
			_listIn=[];
			_listIn.push(_loc_2);
			if (_listIn.length == 1)
			{
				_timerIn.start();
			}
			return;
		}
		
		private function onFadeIn(event:TimerEvent) : void
		{
			var _loc_4:Bitmap = null;
			var _loc_2:* = _listIn.length;
			var _loc_3:* = _loc_2 - 1;
			while (_loc_3 > -1)
			{
				
				_loc_4 = _listIn[_loc_3];
				if (_loc_4.scaleX < 1)
				{
					_loc_4.scaleX = _loc_4.scaleX + 0.1;
					_loc_4.scaleY = _loc_4.scaleY + 0.1;
					_loc_4.x = _defaultX + (_defaultW - _loc_4.width) / 2;
					_loc_4.y = _defaultY + (_defaultH - _loc_4.height) / 2;
				}
				if (_loc_4.scaleX > 0.9)
				{
					_parent.removeChild(_loc_4);
					_listIn.splice(_loc_3, 1);
					visible = true;
				}
				_loc_3 = _loc_3 - 1;
			}
			if (_listIn.length == 0)
			{
				_timerIn.stop();
			}
			return;
		}
		
		private function startFadeOut() : void
		{
			if (_parent == null || parent == null)
			{
				return;
			}
			if (_timerOut == null)
			{
				_timerOut = new Timer(10);
				_timerOut.addEventListener(TimerEvent.TIMER, onFadeOut);
			}
			var _loc_1:* = new BitmapData(width, height, true, 0);
			_loc_1.draw(this);
			var _loc_2:* = new Bitmap(_loc_1);
			_parent.addChild(_loc_2);
			_loc_2.x = x;
			_loc_2.y = y;
			_list.push(_loc_2);
			if (_list.length == 1)
			{
				_timerOut.start();
			}
			return;
		}
		
		private function onFadeOut(event:TimerEvent) : void
		{
			var _loc_4:Bitmap = null;
			var _loc_2:* = _list.length;
			var _loc_3:* = _loc_2 - 1;
			while (_loc_3 > -1)
			{
				
				_loc_4 = _list[_loc_3];
				_list[_loc_3].alpha = _loc_4.alpha - 0.15;
				if (_loc_4.scaleX - 0.08 > 0)
				{
					_loc_4.scaleX = _loc_4.scaleX - 0.08;
					_loc_4.scaleY = _loc_4.scaleY - 0.08;
					_loc_4.x = _defaultX + (_defaultW - _loc_4.width) / 2;
					_loc_4.y = _defaultY + (_defaultH - _loc_4.height) / 2;
				}
				if (_loc_4.alpha <= 0)
				{
					_loc_4.parent.removeChild(_loc_4);
					_list.splice(_loc_3, 1);
				}
				_loc_3 = _loc_3 - 1;
			}
			if (_list.length == 0)
			{
				_timerOut.stop();
			}
			return;
		}
		
		public function get content() : Sprite
		{
			return this;
		}
		
		public function set oParent(parentContainer:Sprite) : void
		{
			_parent = parentContainer;
			return;
		}
		
		public function set tip(param1:ITip) : void
		{
			_tip = param1;
			return;
		}
		
		public function set yesLabelTip(param1:String) : void
		{
			_yesLabelTip = param1;
			return;
		}
		
		public function set noLabelTip(param1:String) : void
		{
			_noLabelTip = param1;
			return;
		}
		
		public function set cancelLabelTip(param1:String) : void
		{
			_cancelLabelTip = param1;
			return;
		}
		
		public function set yesLabel(param1:String) : void
		{
			_yesLabel = param1;
		}
		
		public function set noLabel(param1:String) : void
		{
			_noLabel = param1;
		}
		
		public function set cancelLabel(param1:String) : void
		{
			_cancelLabel = param1;
		}
		
		public function set yesEnabled(param1:Boolean) : void
		{
			_yesEnabled = param1;
		}
		
		public function set noEnabled(param1:Boolean) : void
		{
			_noEnabled = param1;
		}
		
		public function set cancelEnabled(param1:Boolean) : void
		{
			_cancelEnabled = param1;
		}
		
		public function set hasCheckbox(param1:Boolean) : void
		{
			_hasCheckbox = param1;
		}
		
		public function get checked() : Boolean
		{
			return _Checked._Box.currentFrame == 2;
		}
		
		override public function get visible() : Boolean
		{
			return _visible;
		}
		
		public function set onLoadLang(value:Function):void
		{
			_onLoadLang = value;
			setHtmlText(_Checked.txt,_onLoadLang("不再提示"));
		}
		
	}
}