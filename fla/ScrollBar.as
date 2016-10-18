package
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.utils.setTimeout;
	
	public class ScrollBar extends MovieClip
	{
		private static const colorMatrixFilter:ColorMatrixFilter = new ColorMatrixFilter([0.3, 0.3, 0.3, 0, 0, 0.3, 0.3, 0.3, 0, 0, 0.3, 0.3, 0.3, 0, 0, 0, 0, 0, 1, 1]);
		
		private static const BAR_DEEP:int = 5;
		
		public var btnUp:SimpleButton;
		public var btnDown:SimpleButton;
		public var scrollBar:MovieClip;
		public var barBack:MovieClip;
		public var back:MovieClip;
		
		private var barHeight:int;
		
		private var _totalValue:int;
		
		private var _clientX:Number = 0;
		private var _clientY:Number = 0;
		
		private var _target:DisplayObject;
		
		private var _targetX:Number;
		private var _targetY:Number;
		
		private var _maskShape:Shape;
		
		private var _initStatus:Boolean;
		
		public function ScrollBar()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
		}
		
		private function onAddedToStageHandler(eventHandler:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
			
			this.registerEventListener();
		}
		
		public function registerEventListener():void
		{
			this.btnUp.addEventListener(MouseEvent.CLICK, onUpClickHandler);
			this.btnDown.addEventListener(MouseEvent.CLICK, onDownClickHandler);
			this.scrollBar.addEventListener(MouseEvent.MOUSE_DOWN, onScrollBarMouseDownHandler);
		}
		
		public function unloadEventListener():void
		{
			this.btnUp.removeEventListener(MouseEvent.CLICK, onUpClickHandler);
			this.btnDown.removeEventListener(MouseEvent.CLICK, onDownClickHandler);
			this.scrollBar.removeEventListener(MouseEvent.MOUSE_DOWN, onScrollBarMouseDownHandler);
			this.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheelHandler);
			
			if(this._target != null){
				if(this._target.hasEventListener(MouseEvent.MOUSE_WHEEL)){
					this._target.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheelHandler);
				}
			}
		}
		
		private function setTotalValue(totalValue:int, currentValue:int = 0, typeStatus:Boolean = false):void
		{
			if(this._target != null){
				this._target.y = this._targetY;
			}
			
			this._totalValue = totalValue;
			
			var initStatus:Boolean = this.initItemList();
			
			if(initStatus){
				
				if(!typeStatus){
					
					if(currentValue > 0 && this._totalValue > this.barHeight){
						this.scrollBar.y = this.btnUp.height + (currentValue / (this._totalValue - this.barHeight)) * (this.barHeight - this.btnUp.height - this.btnDown.height - this.scrollBar.height)
					}
					
					var status:Boolean = false;
					
					if(this.scrollBar.y + this.scrollBar.height >= this.barHeight - this.btnDown.height){
						this.scrollBar.y = this.barHeight - this.btnDown.height - this.scrollBar.height;
						if(this._initStatus){
							this.sendEvent();
						}
					}
					
					if(this._totalValue <= this.barHeight && !status){
						if(this._initStatus){
							this.sendEvent();
						}
					}
				}else{
					this.scrollBar.y = this.barHeight - this.btnDown.height - this.scrollBar.height;
					if(this._initStatus){
						this.sendEvent();
					}
				}
			}
		}
		
		private function initItemList():Boolean
		{
			this.btnUp.y = 0;
			this.btnDown.y = this.barHeight - this.btnDown.height;
			this.scrollBar.y = this.btnUp.y + this.btnUp.height;
			
			if(this._totalValue > this.barHeight){
				
				var barHeight:int = (this.barHeight - this.btnUp.height - this.btnDown.height) / this._totalValue * (this.barHeight - this.btnUp.height - this.btnDown.height);
				
				if(barHeight < this.btnUp.height){
					barHeight = this.btnUp.height;
				}
				
				this.scrollBar.height = barHeight;
				
				this.setEnabled(this.btnUp, true);
				this.setEnabled(this.btnDown, true);
				this.setEnabled(this.scrollBar, true);
				
				if(!this.hasEventListener(MouseEvent.MOUSE_WHEEL))
				{
					this.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheelHandler);
				}
				
				if(this._target != null)
				{
					if(!this._target.hasEventListener(MouseEvent.MOUSE_WHEEL)){
						this._target.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheelHandler);
					}
				}
				
				return true;
				
			}else{
				
				this.scrollBar.height = this.btnUp.height;
				
				this.scrollBar.y = this.btnUp.y + this.btnUp.height;
				
				this.setEnabled(this.btnUp, false);
				this.setEnabled(this.btnDown, false);
				this.setEnabled(this.scrollBar, false);
				
				if(this.hasEventListener(MouseEvent.MOUSE_WHEEL))
				{
					this.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheelHandler);
				}
				
				if(this._target != null)
				{
					if(this._target.hasEventListener(MouseEvent.MOUSE_WHEEL)){
						this._target.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheelHandler);
					}
				}
				
				return false;
			}
		}
		
		public function STarget(width:Number, height:Number, displayObject:DisplayObject):void 
		{
			if(displayObject == null) return;
			
			this._target = displayObject;
			
			this._targetX = this._target.x;
			this._targetY = this._target.y;
			
			this.setMask(width, height);
		}
		
		public function setMask(width:Number,height:Number):void
		{
			this.barHeight = height;
			
			this.barBack.y = this.btnUp.y + this.btnUp.height;
			
			if(this._maskShape == null){
				
				this._maskShape = new Shape();
				
				if(this._target is Sprite){
					(this._target as Sprite).mask = this._maskShape;
					(this._target as Sprite).parent.addChild(this._maskShape);
				}
			}
			
			this._maskShape.graphics.clear();
			this._maskShape.graphics.beginFill(0xFFFFFF);
			this._maskShape.graphics.drawRect(this._targetX, this._targetY, width, height);
			this._maskShape.graphics.endFill();
			
			this.back.height = height;
			
			this.barBack.height = height - this.btnUp.height - this.btnDown.height;
			
			this.btnUp.y = 0;
			this.btnDown.y = height - this.btnDown.height;
			this.scrollBar.y = this.btnUp.y + this.btnUp.height;
			
			this.setTotalValue(this._target.height, 0);
		}
		
		/**
		 * 
		 * @param type top置顶，boto下面，defined 自定义
		 * @param percentage 0-1
		 */
		public function upData(type:String = "bottom",percentage:Number=0):void 
		{
			if(type == "top")
			{
				this.setTotalValue(this._target.height, 0, false);
				
			}else if(type == "bottom")
			{
				this.setTotalValue(this._target.height, 0, true);
			}else if(type == "defined")
			{
				this.setTotalValue(this._target.height, int(percentage*this._target.height), false);
			}
			
			if(!this._initStatus) this._initStatus = true;
		}
		
		private function getScrollSize():Number
		{
			var varHeight:Number = ((this.scrollBar.y - this.btnUp.height) / (this.barHeight - this.btnUp.height - this.btnDown.height - this.scrollBar.height)) * (this._totalValue - this.barHeight);
			return varHeight;
		}
		
		private function sendEvent():void
		{
			var scrollSize:Number = this.getScrollSize();
			
			if(this._target != null)
			{
				this._target.y = this._targetY - scrollSize;
			}
		}
		
		private function onScrollBarMouseDownHandler(eventHandler:MouseEvent):void
		{
			this._clientX = this.mouseX;
			this._clientY = this.mouseY;
			
			if(stage != null){
				stage.addEventListener(MouseEvent.MOUSE_MOVE, onScrollBarMoveHandler);
				stage.addEventListener(MouseEvent.MOUSE_UP, onScrollBarUpHandler);
			}
			
		}
		
		private function onScrollBarMoveHandler(eventHandler:MouseEvent):void
		{
			var subHeight:Number = this._clientY - this.scrollBar.y;
			
			this._clientY = this.mouseY;
			
			if(((this.mouseY - subHeight) >= (this.btnUp.height)) && ((this.mouseY - subHeight) <= (this.barHeight - this.btnDown.height - this.scrollBar.height))){
				this.scrollBar.y = this.mouseY - subHeight;
			}else{
				
				if((this.mouseY - subHeight) < (this.btnUp.height))
				{
					this.scrollBar.y = this.btnUp.y + this.btnUp.height;
				}
				
				if((this.mouseY - subHeight) > (this.barHeight - this.btnDown.height - this.scrollBar.height))
				{
					this.scrollBar.y = this.barHeight - this.btnDown.height - this.scrollBar.height;
				}
				
			}
			
			this.sendEvent();
		}
		
		private function onScrollBarUpHandler(eventHandler:MouseEvent):void
		{
			if(stage){
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, onScrollBarMoveHandler);
				stage.removeEventListener(MouseEvent.MOUSE_UP, onScrollBarUpHandler);
			}
		}
		
		private function onUpClickHandler(eventHandler:MouseEvent):void
		{
			this.onUpScrollHandler();
		}
		
		private function onDownClickHandler(eventHandler:MouseEvent):void
		{
			this.onDownScrollHandler();
		}
		
		private function onUpScrollHandler():void
		{
			if(this.scrollBar.y - BAR_DEEP >= this.btnUp.height){
				this.scrollBar.y = this.scrollBar.y - BAR_DEEP;
			}else{
				this.scrollBar.y = this.btnUp.y + this.btnUp.height;
			}
			this.sendEvent();
		}
		
		private function onDownScrollHandler():void
		{
			if((this.scrollBar.y + this.scrollBar.height + BAR_DEEP) <= (this.barHeight - this.btnDown.height)){
				this.scrollBar.y = this.scrollBar.y + BAR_DEEP;
			}else{
				this.scrollBar.y = this.barHeight - this.btnDown.height - this.scrollBar.height;
			}
			this.sendEvent();
		}
		
		private function onMouseWheelHandler(eventHandler:MouseEvent):void
		{
			if(eventHandler.delta < 0)
			{
				this.onDownScrollHandler();
			}else{
				this.onUpScrollHandler();
			}
		}
		
		public function dispose():void
		{
			this.unloadEventListener();
		}
		
		private function setEnabled(displayObject:*, status:Boolean):void
		{
			if(displayObject == null) return;
			
			if(displayObject is SimpleButton){
				
				SimpleButton(displayObject).mouseEnabled = status;
				
				if(status){
					SimpleButton(displayObject).filters = [];
				}else{
					SimpleButton(displayObject).filters = [colorMatrixFilter];
				}
				
			}else if(displayObject is DisplayObjectContainer){
				
				DisplayObjectContainer(displayObject).mouseChildren = status;
				DisplayObjectContainer(displayObject).mouseEnabled = status;
				
				if(status){
					DisplayObjectContainer(displayObject).filters = [];
				}else{
					DisplayObjectContainer(displayObject).filters = [colorMatrixFilter];
				}
			}
		}
	}
}