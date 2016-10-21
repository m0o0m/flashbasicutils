package 
{
	import com.ql.gameKit.extensions.debug.Logger;
	
	import flash.desktop.Clipboard;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.ContextMenuEvent;
	import flash.events.KeyboardEvent;
	import flash.events.UncaughtErrorEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	public class Context extends Object
	{
		private var _stage:Sprite;
		private var _downKeysDic:Dictionary;
		private static var _instance:Context;
		
		public function Context()
		{
			if (!_instance)
			{
				_instance = this;
			}
			else
			{
				throw getQualifiedClassName(this) + " is a singleton class.";
			}
			return;
		}// end function
		
		public function initialize(target:Sprite, version:String, isLog:Boolean, isDebug:Boolean) : void
		{
			if (target)
			{
				_stage = target;
				_stage.stage.stageFocusRect = false;
				Logger.isDebug = isDebug;
				Logger.isLog = isLog;
				setMenu(version);
				if (!isDebug)
				{
					_stage.stage.loaderInfo.uncaughtErrorEvents.addEventListener("uncaughtError", onUncaughtError);
				}
			}
			return;
		}// end function
		
		protected function onUncaughtError(event:UncaughtErrorEvent) : void
		{
			var _loc_2:* = event.error as Error;
			if (_loc_2)
			{
				Logger.warn(_loc_2.getStackTrace(), this);
				UncaughtErrorEvent(_loc_2.getStackTrace());
			}
			return;
		}// end function
		
		protected function handleUncaughtError(error:String) : void
		{
			return;
		}// end function
		
		public function getSize() : Object
		{
			return {width:_stage.stage.stageWidth, height:_stage.stage.stageHeight};
		}// end function
		
		public function addChild(child:DisplayObject) : DisplayObject
		{
			_stage.addChild(child);
			return child;
		}// end function
		
		public function addChildAt(child:DisplayObject, index:int) : DisplayObject
		{
			_stage.addChildAt(child, index);
			return child;
		}// end function
		
		public function removeChild(child:DisplayObject) : DisplayObject
		{
			return _stage.removeChild(child);
		}// end function
		
		public function removeChildAt(index:int) : DisplayObject
		{
			return _stage.removeChildAt(index);
		}// end function
		
		public function removeChildren(beginIndex:int, endIndex:int) : void
		{
			_stage.removeChildren(beginIndex, endIndex);
			return;
		}// end function
		
		public function contain(child:DisplayObject) : Boolean
		{
			return _stage.contains(child);
		}// end function
		
		public function resizeStage(w:Number, h:Number, frameRate:int) : void
		{
			var _loc_6:Boolean = false;
			var _loc_4:Number = NaN;
			var _loc_5:* = getParent();
			if (getParent())
			{
				_loc_6 = w / h > _loc_5.stage.stageWidth / _loc_5.stage.stageHeight;
				_loc_4 = !_loc_6 ? (_loc_5.stage.stageWidth / w) : (_loc_5.stage.stageHeight / h);
				if (_loc_4 < 1)
				{
					_loc_5.stage.align = "T";
					var _loc_7:* = _loc_4;
					_loc_5.scaleY = _loc_4;
					_loc_5.scaleX = _loc_7;
					_loc_5.parent.x = (_loc_5.stage.stageWidth - w * _loc_4) / 2;
				}
				_loc_5.stage.frameRate = frameRate;
			}
			return;
		}// end function
		
		public function getParent() : Sprite
		{
			var _loc_1 = null;
			if (_stage && _stage.parent.parent)
			{
				_loc_1 = _stage.parent as MovieClip;
			}
			return _loc_1;
		}// end function
		
		public function removeLoading(callback:Function) : void
		{
			Logger.log("remove loading", this);
			var _loc_2:* = getParent();
			if (_loc_2 && _loc_2["removeBrand"])
			{
				_loc_2._loc_2["removeBrand"](true, callback);
			}
			return;
		}// end function
		
		public function getContext(data:ByteArray, callback:Function, isDebug:Boolean) : void
		{
			var _loc_4:* = getParent();
			if (getParent() && _loc_4["addChlid"])
			{
				_loc_4._loc_4["addChlid"](_stage, data, callback, null, isDebug);
			}
			return;
		}// end function
		
		public function getPath() : String
		{
			var _loc_2:* = _stage.loaderInfo.url;
			var _loc_1:* = _loc_2.lastIndexOf(".swf");
			if (_loc_1 != -1)
			{
				_loc_2 = _loc_2.slice(0, _loc_1);
			}
			_loc_1 = _loc_2.lastIndexOf("/");
			if (_loc_1 != -1)
			{
				_loc_2 = _loc_2.slice(0, (_loc_1 + 1));
			}
			return _loc_2;
		}// end function
		
		public function getParameters() : Object
		{
			var _loc_1:* = getParent();
			if (_loc_1)
			{
				return _loc_1.stage.loaderInfo.parameters;
			}
			return null;
		}// end function
		
		public function setMenu(version:String) : void
		{
			var _loc_3:* = new ContextMenu();
			_loc_3.hideBuiltInItems();
			var _loc_2:* = new ContextMenuItem("Version:" + version);
			_loc_2.enabled = false;
			if (Logger.isLog)
			{
				_downKeysDic = new Dictionary();
				_stage.stage.addEventListener("keyDown", onCheckLogToggle);
				_stage.stage.addEventListener("keyUp", onReleaseKey);
			}
			_loc_3.customItems = [_loc_2];
			_stage.contextMenu = _loc_3;
			return;
		}// end function
		
		protected function onReleaseKey(event:KeyboardEvent) : void
		{
			if (_downKeysDic[event.keyCode])
			{
				delete _downKeysDic[event.keyCode];
			}
			return;
		}// end function
		
		protected function onCheckLogToggle(event:KeyboardEvent) : void
		{
			var _loc_2 = null;
			_downKeysDic[event.keyCode] = true;
			if (_downKeysDic[32] && _downKeysDic[76])
			{
				event.currentTarget.removeEventListener("keyDown", onCheckLogToggle);
				event.currentTarget.removeEventListener("keyUp", onReleaseKey);
				_loc_2 = _stage.contextMenu.customItems[0];
				if (!_loc_2.enabled)
				{
					_loc_2.addEventListener("menuItemSelect", onSelectMenu);
					_loc_2.enabled = true;
				}
			}
			return;
		}// end function
		
		protected function onSelectMenu(event:ContextMenuEvent) : void
		{
			Clipboard.generalClipboard.setData("air:text", Logger.getLog());
			return;
		}// end function
		
		public function get stage() : Sprite
		{
			return _stage;
		}// end function
		
		public static function getInstance() : Context
		{
			return _instance || new Context;
		}// end function
		
	}
}
import com.ql.gameKit.core;
import com.ql.gameKit.extensions.debug.Logger;

import flash.desktop.Clipboard;
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.ContextMenuEvent;
import flash.events.KeyboardEvent;
import flash.events.UncaughtErrorEvent;
import flash.ui.ContextMenu;
import flash.ui.ContextMenuItem;
import flash.utils.ByteArray;
import flash.utils.Dictionary;
import flash.utils.getQualifiedClassName;

