package com.wg.ui.button
{
	import com.wg.ui.utils.pic.NumPicUtils;
	import com.wg.assets.TextFieldUtils;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import com.wg.ui.interfaces.IUI2;
	
	import org.osmf.media.DefaultMediaFactory;
	
	/**
	 *所有的按钮都需要手动init和手动dispose(); 
	 * 可转化为按钮组,checkbox,radiobox,通过设置不同的属性值;
	 * @author Allen
	 * 
	 */
	public class LittleButton implements IUI2
	{


		public var clickFunc:Function;//按钮点击响应的事件回调;
		private var _state:String;//根据状态值设定;
		public var gameType:String = "";//保存彩种的常量或子彩种的名称;
		private var _value:*;//给按钮赋值,传递使用;

		private var _title:String;//按钮的标题
		public var tipData:Object;//按钮的tips
		public var content:MovieClip;
		public static const ALREADYCLICK:String = "alreadyclick";
		public static const UNCLICK:String = "unclick";
		
		//记录是否是点击;
		protected var isClick:Boolean = false;
		
		//按钮的锁定状态;
		private var _isLock:Boolean = false;
		
		//是否设置文本颜色;
		private var _canSetTextColor:Boolean;
		private var _firstTxtColor:int;
		private var _secondTxtColor:int;
		
		//设置是否可拥有点击状态保持;
		public var hasClickState:Boolean = true;
		
		public function set isLock(value:Boolean):void
		{
			_isLock = value;
			if(!_isLock)
			{
				addListener();
				changeState(_state);
			}else
			{
				content.gotoAndStop(4);
				removeListener();
			}
		}


		public function LittleButton(con:MovieClip,tit:String):void
		{
			content = con;
			_title = tit;
//			content.addEventListener(Event.ADDED_TO_STAGE,addToStage);
//			content.addEventListener(Event.REMOVED_FROM_STAGE,removeFromStage);
		}
		public function get title():String
		{
			return _title;
		}
		
		public function set title(value:String):void
		{
			_title = value;
			if(content["txt"]) (content.txt as TextField).text = _title;
		}
		
		public function get state():String
		{
			return _state;
		}
		
		
		public function get value():*
		{
			return _value;
		}
		
		public function set value(value:*):void
		{
			_value = value;
		}
		
		public function init():void
		{
			content.gotoAndStop(1);
			content.mouseChildren = false;
			content.buttonMode = true;
			
			_state = LittleButton.UNCLICK;
			changeTxtColor();
			if(content["txt"]) (content.txt as TextField).text = _title;
			
			if(_isLock)
			{
				content.gotoAndStop(4);
				return;
			}
			addListener();
/*			if(_hasPicMc)
			{
				setPic(_title);
				if(content["txt"]) (content.txt as TextField).text = "";
			}
*/		}

		/**
		 *还原到初始状态; 
		 * 
		 */
		public function gotoStartState():void
		{
			//默认是黑色;
			_state = LittleButton.UNCLICK;
			changeTxtColor();
			if(_isLock)
			{
				content.gotoAndStop(4);
				removeListener();
			}else
			{
				if(!content.hasEventListener(MouseEvent.MOUSE_DOWN))
				{
					addListener();
				}
//				this.changeState(_state);//调用的是子类的覆盖方法,
				switch(_state){
					case LittleButton.UNCLICK:
						content.gotoAndStop(1);
						break;
					case LittleButton.ALREADYCLICK:
						content.gotoAndStop(3);
						break;
					default:
						break;
				}
			}
		}
		private function addListener():void
		{
			content.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
			content.addEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
			content.addEventListener(MouseEvent.MOUSE_OVER,mouseOverHandler);
			content.addEventListener(MouseEvent.MOUSE_OUT,mouseOutHandler);
		}
		
		private function removeListener():void
		{
			content.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
			content.removeEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
			content.removeEventListener(MouseEvent.MOUSE_OVER,mouseOverHandler);
			content.removeEventListener(MouseEvent.MOUSE_OUT,mouseOutHandler);
		}
		/**
		 *外部改变按钮状态的方法; 
		 * @param type
		 * 
		 */
		public function changeState(type:String):void
		{
			if(hasClickState==false)
			{
				type = UNCLICK;
			}
			_state = type;
			switch(_state){
				case LittleButton.UNCLICK:
					content.gotoAndStop(1);
					break;
				case LittleButton.ALREADYCLICK:
					content.gotoAndStop(3);
					break;
				default:
					break;
			}
			changeTxtColor();
		}
		
		/**
		 *初始化文本的颜色; 
		 * @param firstColor
		 * @param secondColor
		 * 
		 */
		public function setTxtColor(firstColor:int = 0,secondColor:int = 0):void
		{
			if(!firstColor) firstColor = 0x000000;
			if(!secondColor) secondColor = 0xffffff;
			_firstTxtColor = firstColor;
			_secondTxtColor = secondColor;
			_canSetTextColor = true;
		}
		
		/**
		 *设置文本的格式; 
		 * @param format
		 * 
		 */
		public function setTxtFormat(format:TextFormat):void
		{
			if(content["txt"])
			{
				(content["txt"] as TextField).setTextFormat(format);
			}
		}
		/**
		 *设置文本的颜色; 
		 * 
		 */
		private function changeTxtColor():void
		{
			if(_canSetTextColor&&content["txt"])
			{
				if(state==LittleButton.ALREADYCLICK)
				{
					(content.txt as TextField).textColor = _secondTxtColor;
//					TextFieldUtils.setTextColor(content.txt,_secondTxtColor);
				}else
				{
					(content.txt as TextField).textColor = _firstTxtColor;
//					TextFieldUtils.setTextColor(content.txt,_firstTxtColor);
				}
			}
		}
		public function dispose():void
		{
			removeListener();
			content = null;
			clickFunc = null;
		}
		
		private function mouseOverHandler(event:MouseEvent):void
		{
			if(_state == LittleButton.ALREADYCLICK) return;//如果是锁定状态,不发生over效果
			content.gotoAndStop(2);
		}
		
		private function mouseOutHandler(event:MouseEvent):void
		{
			if(_state == LittleButton.ALREADYCLICK) return;//如果是锁定状态,不发生out效果;
			
			content.gotoAndStop(1);
		}
		
		private function mouseDownHandler(event:MouseEvent):void
		{
			content.gotoAndStop(3);
			isClick = true;
		}
		protected function mouseUpHandler(event:MouseEvent):void
		{
			if(_state == LittleButton.ALREADYCLICK)
			{
				_state = LittleButton.UNCLICK;
			}else
			{
				_state = LittleButton.ALREADYCLICK;
			}
			if(hasClickState==false)
			{
				_state = UNCLICK;
			}
			changeTxtColor();
			//检查是否是按钮组里的成员,如果是改变状态;
//			if(!TitileButtonGroup.instance.changeState(this))
//			{
				switch(_state){
					case LittleButton.UNCLICK:
						content.gotoAndStop(2);//over状态;
						break;
					case LittleButton.ALREADYCLICK:
						content.gotoAndStop(3);
						break;
					default:
						break;
				}
//			}
			
			
			if(isClick&&clickFunc is Function)
			{
				isClick = false;
				clickFunc(this);
			}
		}
		private function removeFromStage(event:Event):void
		{
			dispose();
		}
		private function addToStage(event:Event):void
		{
			init();
		}
		private function removeAllchild(mc:MovieClip):void
		{
				for(var i:int = mc.numChildren; i >=1 ; i--) 
				{
					mc.removeChildAt(0);
				}
				
		}
	}
}