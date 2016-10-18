package views.tip
{
	
	import com.ClientConstants;
	import com.wg.assets.TextFieldUtils;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	
	import views.alert.ITip;
	
	
	/**
	 * ...
	 * @author Jason
	 */
	public class Tip extends Sprite implements ITip
	{
		
		private var _parent:Sprite;
		private var _targets:Dictionary;
		private var _target:DisplayObject;
		private var _content:DisplayObject;
		private var _contentOffset:Point;
		private var _contentSpan:Point;
		private var _mouseOffset:Point;
		private var _dir:int = 0;
		private var _openedTarget:Object;
		private var _tempX:Number = 0;
		private var _tempY:Number = 0;
		private var _txtTween:TextField;
		private var _speed:Number = 0.15;
		private var _angle:Number = 0;
		private static var _offset:Point = new Point(0, 0);
		private static var _obj:Tip;
		public static const LEFT:int = -1;
		public static const RIGHT:int = 1;
		private static var isThree:Boolean;
		
		public function Tip()
		{
			_targets = new Dictionary();
			_contentOffset = new Point(6, 6);
			_contentSpan = new Point(10, 0);
			_mouseOffset = new Point(15, 15);
			_openedTarget = {};
			mouseEnabled = false;
			initTextTip();
		}
		
		public function get stageOffset() : Point
		{
			return _offset;
		}
		
		public function addTarget(p_target:DisplayObject, p_desc:* = null, backStatus:Boolean = true) : void
		{
			clearTarget(p_target);
			addOne(p_target, p_desc, null, true, backStatus);
			addEvent(p_target);
		}
		
		public function addTargetMoreTips(p_target:DisplayObject, ... args) : void
		{
			clearTarget(p_target);
			var len:int = args.length;
			isThree=false;
			if(len>=3){ isThree=true; }
			var i:int = 0;
			while (i < len)
			{
				this.addOne(p_target, args[i]);
				i++;
			}
			addEvent(p_target);
		}
		
		public function addFixedTarget(p_target:DisplayObject, p_desc:*, p_pos:Point, param4:Boolean = true) : void
		{
			clearTarget(p_target);
			addOne(p_target, p_desc, p_pos, param4);
			addEvent(p_target);
		}
		
		private function addOne(p_target:DisplayObject, p_desc:*, p_pos:Point = null, param4:Boolean = true, backStatus:Boolean = true) : void
		{
			var d:DisplayObject;
			var target:DisplayObject = p_target;
			var content:* = p_desc;
			var pos:Point = p_pos;
			var topBase:* = param4;
			
			if (content is String)
			{
				d = new TextField();
				var _loc_6:TextField = d as TextField;
				with (d as TextField)
				{
					selectable = false;
					autoSize = TextFieldAutoSize.LEFT;
					multiline = true;
					htmlText = HtmlText.white(content);
				}
			}
			else if (content is DisplayObject)
			{
				d = content;
			}
			
			if (_targets[target] == null)
			{
				_targets[target] = {contents:[], pos:pos, topBase:topBase, backStatus:backStatus};
			}
			_targets[target]["contents"].push(d);
			if(isThree){
				_targets[target]["isThree"]=true;
				isThree=false;
			}
		}
		
		public function removeTarget(param1:DisplayObject) : void
		{
			if (param1 && this._targets[param1])
			{
				this.hide();
				this.removeEvent(param1);
				delete this._targets[param1];
				
			}
			return;
		}
		
		private function addEvent(p_target:DisplayObject) : void
		{
			var target:DisplayObject = p_target;
			var mouseMove:Function = function (event:MouseEvent) : void
			{
				if (stage == null)  return;
				
				_target = target;
				
				if(!_targets[target]) return;
				
				var content:* = _targets[target]["contents"][0];
				if (_content && _content != content){
					while (numChildren){
						removeChildAt(0);
					}
					_content = null;
				}
				
				if (_content != content){
					_content = content;
					var contentLen:int = _targets[target]["contents"].length;
					var i:int=0
					while ( i < contentLen){
						content = _targets[target]["contents"][i];
						addChild(content);
						i++;
					}
					draw();
				}
				var offSetX:* = _parent.mouseX + _mouseOffset.x;
				var offSetY:* = _parent.mouseY + _mouseOffset.y;
				var dir:int = 0;
				
				if (offSetX + width > stage.stageWidth - _offset.x * 2)
				{
					offSetX = _parent.mouseX - width - _mouseOffset.x + 5;
					dir = Tip.LEFT;
				}
				else
				{
					dir = Tip.RIGHT;
				}
				
				if (offSetY + height > stage.stageHeight - _offset.y * 2)
				{
						offSetY = _parent.mouseY - height - _mouseOffset.y + 5;
						if(this.y<0){
							offSetY = 0;
						}
				}
				
				if (_targets[target].pos)
				{
					x = _targets[target].pos.x;
					y = _targets[target].pos.y - height;
				}
				else
				{
					if(_targets[target].isThree){
						x = Math.floor(offSetX)-dir*200;
						y = Math.floor(offSetY);
					}else{
						x = Math.floor(offSetX);
						if(offSetY>=0){
							y = Math.floor(offSetY);
						}else{
							y = 0
						}
					}
				}
				if (dir != _dir)
				{
					_dir = dir;
					draw();
				}
				event.updateAfterEvent();
			}
			
			var mouseOver:Function = function (event:MouseEvent) : void
			{
				show();
				target.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove, false, 0, true);
			}
			
			var mouseOut:Function = function (event:MouseEvent) : void
			{
				hide();
				target.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			}
			
			_targets[target].mouseOver = mouseOver;
			_targets[target].mouseOut = mouseOut;
			_targets[target].mouseMove = mouseMove;
			target.addEventListener(MouseEvent.MOUSE_OVER, mouseOver, false, 0, true);
			target.addEventListener(MouseEvent.MOUSE_OUT, mouseOut, false, 0, true);
		}
		
		private function removeEvent(p_target:DisplayObject) : void
		{
			p_target.removeEventListener(MouseEvent.MOUSE_OVER, _targets[p_target].mouseOver);
			p_target.removeEventListener(MouseEvent.MOUSE_OUT, _targets[p_target].mouseOut);
			p_target.removeEventListener(MouseEvent.MOUSE_MOVE, _targets[p_target].mouseMove);
		}
		
		private function clearTarget(p_target:DisplayObject) : void
		{
			if (p_target == null)
			{
				throw new Error("target不能为null！");
			}
			if (this._targets[p_target])
			{
				this.removeTarget(p_target);
			}
		}
		
		public function updateTarget(p_target:DisplayObject = null) : void
		{
			draw();
			updateTarget1();
		}
		
		private function show() : void
		{
			if (_parent){
				_parent.addChild(this);
			}
			if (x == 0 && y == 0){
				x = 10000;
				y = 10000;
			}
		}
		
		public function hide() : void
		{
			_target = null;
			_content = null;
			graphics.clear();
			if (_parent && parent)
			{
				parent.removeChild(this);
			}
			while (numChildren)
			{
				removeChildAt(0);
			}
		}
		
		private function draw() : void
		{
			var addonX:int;
			var addonY:int;
			
			if (!_target) return;
			
			graphics.clear();
			var handler:Function = function (p_index:int) : void
			{
				var content:* = _targets[_target]["contents"][p_index];
				var backStatus:Boolean = _targets[_target]["backStatus"];
				if(!content) return;
				visible = content.visible;
				var _x:* = content ? (content.width + _contentOffset.x * 2) : (100);
				var _y:* = content ? (content.height + _contentOffset.y * 2) : (50);
				if(backStatus){
					var ellipse:int = 8;
					graphics.lineStyle(1, 0, 0.3);
					graphics.beginFill(0, 0.9);
					graphics.drawRoundRect(0 + addonX, 0 + addonY, _x, _y, ellipse, ellipse);
					graphics.endFill();
					graphics.lineStyle(1, 0xa39271);//改变边框
					graphics.beginFill(0x13100e,.3);//改变背景
					graphics.drawRoundRect(0 + addonX, 0 + addonY, _x, _y, ellipse, ellipse);
					graphics.endFill();
					content.x = _contentOffset.x + addonX;
					content.y = _contentOffset.y + addonY;
					addonX = addonX + (_x + 5);
					addonY = addonY + _contentSpan.y;
				}
			}
			
			var start:int;
			var i:int;
			var end:int = _targets[_target]["contents"].length;
			if (Tip.LEFT == _dir)
			{
				i = (end - 1);
				while (i >= start)
				{
					handler(i);
					i = (i - 1);
				}
			}
			else
			{
				i = start;
				while (i < end)
				{
					handler(i);
					i = (i + 1);
				}
			}
		}
		
		public function clickToOpen(showSprite:*, param2:Event = null) : Sprite
		{
			var d:DisplayObject;
			var content:* = showSprite;
			var container:Sprite = new Sprite();
			this._parent.addChild(container);
			if (content is DisplayObject)
			{
				d = content;
			}
			else
			{
				d = new TextField();
				var _loc_4:* = d as TextField;
				with (d as TextField)
				{
					selectable = false;
					autoSize = TextFieldAutoSize.LEFT;
					multiline = true;
					htmlText = "<font color=\"#ffffff\" face = \"" + TextFieldUtils.TEXT_FONT_NAME + ">" + content + "</font>";
				}
			}
			_openedTarget["container"] = container;
			_openedTarget["content"] = d;
			d.x = this._contentOffset.x;
			d.y = this._contentOffset.y;
			container.addChild(d);
			var handler:* = this.clickToClose(container);
			_parent.stage.addEventListener(MouseEvent.CLICK, handler);
			_parent.stage.addEventListener(MouseEvent.CLICK, handler, true);
			_openedTarget["mouseX"] = this._parent.mouseX;
			_openedTarget["mouseY"] = this._parent.mouseY;
			updateTarget1();
			return container;
		}
		
		private function clickToClose(param1:DisplayObject) : Function
		{
			
			var container:* = param1;
			var handler:Function = function (event:MouseEvent) : void
			{
				var tempTarget:* = event.target as DisplayObject;
				while (tempTarget)
				{
					
					if (tempTarget == container)
					{
						break;
						continue;
					}
					tempTarget = tempTarget.parent;
				}
				_parent.stage.removeEventListener(MouseEvent.CLICK, handler);
				_parent.stage.removeEventListener(MouseEvent.CLICK, handler, true);
				if (container && container.parent)
				{
					container.parent.removeChild(container);
				}
			}
			
			return handler;
		}
		
		public function hideOpened() : void
		{
			var container:* = this._openedTarget["container"];
			if (container && container.parent)
			{
				container.parent.removeChild(container);
			}
		}
		
		private function updateTarget1() : void
		{
			var container:* = _openedTarget["container"];
			var content:* = _openedTarget["content"];
			if (!container || !container.parent) return;
			
			var _loc_3:int = 0;
			var _loc_4:int = 0;
			var _x:* = content ? (content.width + _contentOffset.x * 2) : (100);
			var _y:* = content ? (content.height + _contentOffset.y * 2) : (50);
			var ellipse:int = 8;
			container.graphics.clear();
			container.graphics.lineStyle(1, 0xa39271, 0.3);
			container.graphics.beginFill(0, 0.75);
			container.graphics.drawRoundRect(2 + _loc_3, 2 + _loc_4, _x, _y, ellipse, ellipse);
			container.graphics.endFill();
			container.graphics.lineStyle(1, 0xa39271);
			container.graphics.beginFill(1118481);
			container.graphics.drawRoundRect(0 + _loc_3, 0 + _loc_4, _x, _y, ellipse, ellipse);
			container.graphics.endFill();
			
			updatePosition(container);
		}
		
		private function updatePosition(p_container:Sprite) : void
		{
			var tempMouseX:* = _openedTarget["mouseX"];
			var tempMouseY:* = _openedTarget["mouseY"];
			var _x:* = tempMouseX + this._mouseOffset.x;
			var _y:* = tempMouseY + this._mouseOffset.y;
			if (_x + p_container.width > _parent.stage.stageWidth - _offset.x * 2)
			{
				_x = tempMouseX - p_container.width - _mouseOffset.x;
			}
			if (_y + p_container.height > _parent.stage.stageHeight - _offset.y * 2)
			{
				_y = tempMouseY - p_container.height - _mouseOffset.y;
			}
			p_container.x = Math.floor(_x);
			p_container.y = Math.floor(_y);
		}
		
		
		
		public function textTip(param1:DisplayObject, param2:String, param3:uint = 16776960) : void
		{
			
			this._angle = 0;
			
			// Notice : 
			var _loc_4:* = HtmlText.format(param2, 18, param3);
			_txtTween.filters = [ClientConstants.GLOBAL_FILTER_SHADOW_SERIOUS];
			_txtTween.mouseEnabled = false;
			TextFieldUtils.setHtmlText(_txtTween,_loc_4);
			//_txtTween.htmlText = "<font face='" + TextFieldUtils.NUMBER_FONT_NAME + "' size='" + TextFieldUtils.TEXT_FONT_SIZE + "'>" + _loc_4 + "</font>"
			
			_txtTween.alpha = _angle;
			_txtTween.x = param1.x + (param1.width - _txtTween.width) / 2;
			_txtTween.y = param1.y - 27;
			param1.parent.addChild(_txtTween);
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function initTextTip() : void
		{
			_txtTween = new TextField();
			_txtTween.mouseEnabled = false;
			_txtTween.autoSize = TextFieldAutoSize.LEFT;
		}
		
		private function enterFrame(event:Event) : void
		{
			var _loc_2:* = Math.sin(_angle);
			_txtTween.alpha = _loc_2;
			_angle = this._angle + this._speed;
			if (_angle >= 1.5)
			{
				_txtTween.y = this._txtTween.y - 0.5;
			}
			if (_angle >= 3.2)
			{
				_angle = 0;
				removeEventListener(Event.ENTER_FRAME, this.enterFrame);
				_txtTween.parent.removeChild(this._txtTween);
			}
		}
		
		public function set oParent(p_parent:Sprite) : void
		{
			_parent = p_parent;
		}
		
		public function get targets() : Dictionary
		{
			return _targets;
		}
		
		override public function toString() : String
		{
			var result:String = "============\n";
			var obj:Object = null;
			
			var i:int = 1;
			for (obj in _targets)
			{
				
				result = result + ("[" + i + "], " + obj + " : \n" + "\tname   : " + obj.name + "\n" + "\tparent : " + obj.parent + "\n" + "\n");
				i++;
			}
			result = result + "============\n";
			return result;
		}
		
		public static function set offset(p_offset:Point) : void
		{
			_offset = p_offset;
			_obj.hideOpened();
		}
		
		public static function getInstance() : ITip
		{
			if (!_obj)
			{
				_obj = new Tip;
			}
			return _obj;
		}
	}
	
}