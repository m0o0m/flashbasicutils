package views.chat
{
	
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.*;
	
	public class ScrollbarComp extends MovieClip
	{
		public var _DownBtn:SimpleButton;
		public var _ScrollBtn:MovieClip;
		public var _UpBtn:SimpleButton;
		public var _ListBack:MovieClip;
		
		private var _filterColor:ColorMatrixFilter;
		private var _filters:Array;
		private var _target:MovieClip;
		private var _targetBool:Boolean = false;
		private var _targetY:Number;
		private var _firstBool:Boolean = false;
		private var _isTargetY:Boolean = false;
		private var _showWidth:Number = 0;
		private var _widthBool:Boolean = false;
		private var _mainHeight:Number = 0;//滚动目标的高度
		private var _isMainHeight:Boolean = false;
		private var _isShowBottom:Boolean = false;
		private var _noRefult:Boolean = false;
		private var _showHeight:Number = 0;//显示出来目标的高度
		private var _heightBool:Boolean = false;
		private var _moveNum:Number = 0;
		private var _speed:int = 5;
		private var _scrollbarX:int = 0;
		private var _scrollbarXBool:Boolean = false;
		private var _scrollbarY:int = 0;
		private var _scrollbarYBool:Boolean = false;
		private var _maskX:int = 0;
		private var _maskXBool:Boolean = false;
		private var _maskY:int = 0;
		private var _maskYBool:Boolean = false;
		private var _appointLive:Number;
		private var _visibleScrollbar:Boolean = true;//控制滚动条是否显示
		private var _rect:Sprite;
		private var _rectBool:Boolean = false;
		private var _wheel:Sprite;
		private var _wheelBool:Boolean = false;
		private var _showBottomFirst:Boolean = false;
		private var _loadThisBool:Boolean = false;
		private var ratio:Number = 0;
		private var _move:Number = 0;//按钮可以移动多少距离
		private var _movePoint:Number = 0;//滑块每移动单位距离 滚动目标移动多大距离
		private var _isMove:Boolean = false;
		private var _isLostUp:Boolean = false;
		private var _isLostDown:Boolean = false;
		
		public function ScrollbarComp()
		{
			//			调色	
			_filterColor = new ColorMatrixFilter([0.2, 0.2, 0.2, 0, 0, 0.2, 0.2, 0.2, 0, 0, 0.2, 0.2, 0.2, 0, 0, 0, 0, 0, 1, 1]);
			_filters = new Array();
			_ScrollBtn.y = 0;
			_ListBack.alpha = 0.54;
			_filters.push(_filterColor);	
		}
		
		public function set target(tar:MovieClip) : void
		{
			if (_target != tar)
			{
				if (_target != null)
				{
					clear();
				}
			}
			if (tar == null)
			{
				scrollUpClear();
			}
			_target = tar;
			if (_firstBool)
			{
				close();
				return;
			}
	
			if (_isMainHeight == false)
			{
				_mainHeight = _target.height;
			}
			
			if (_firstBool == false)
			{
				_targetY =_target.y;
			}
			_targetBool = true;
			startList();
		}
		
		public function set targetY(param1:Number) : void
		{
			_targetY = param1;
			_isTargetY = true;
		}
		
		public function set showWidth(wid:Number) : void
		{
			_showWidth = wid;
			_widthBool = true;
			startList();
		}
		
		public function set mainHeight(hei:Number) : void
		{
			_isMainHeight = true;
			_mainHeight = hei;
		}
		
		public function set showBottom(param1:Boolean) : void
		{
			_isShowBottom = param1;
			
		}
		
		public function set noRefult(param1:Boolean) : void
		{
			_noRefult = param1;
		}
		
		public function set showHeight(param1:Number) : void
		{
			_showHeight = param1;
			_heightBool = true;
			startList();
		}
		
		public function set moveNum(param1:Number) : void
		{
			_moveNum = param1;
		}
		
		public function set speed(value:int) : void
		{
			_speed = value;
		}
		
		public function set liveY(value:int) : void
		{
			_ScrollBtn.y = value;
			scrollMove();
		}
		
		public function set scrollbarX(value:int) : void
		{
			_scrollbarX = value;
			_scrollbarXBool = true;
		}
		
		public function set scrollbarY(value:int) : void
		{
			_scrollbarY = value;
			_scrollbarYBool = true;
		}
		
		public function set maskX(value:int) : void
		{
			_maskX = value;
			_maskXBool = true;
		}
		
		public function set maskY(value:int) : void
		{
			_maskY = value;
			_maskYBool = false;
		}
		
		public function set appointMc(value:Number) : void
		{
			_appointLive = value - _showHeight;
			
			if (_appointLive > 0)
			{
				_ScrollBtn.y = _appointLive * _movePoint;
				scrollMove();
			}
			
		}
		
		public function set visibleScrollbar(value:Boolean) : void
		{
			_visibleScrollbar = value;
		}
		
		public function set listBackAlpha(value:Number) : void
		{
			_ListBack.alpha = value;
		}
		
		private function createMask() : void
		{
//			return;
			clearMask();
			if(_target==null) return;
			
			if (_maskXBool == false)
			{
				_maskX = _target.x;
			}
			if (_maskYBool == false)
			{
				_maskY = _targetY;
			}
			_rect = new Sprite();
			_rect.graphics.beginFill(0xffffff);
			_rect.graphics.drawRect((_maskX - 1), _maskY, _showWidth + 2, _showHeight);
			_rect.graphics.endFill();
			_rect.mouseEnabled = false;
			_target.parent.addChild(_rect);
			_target.mask = _rect;
			_rectBool = true;
		}
		
		private function createWheel() : void
		{
			if(_target==null){
				return;
			}
			clearWheel();
			_wheel = new Sprite();
			_wheel.graphics.beginFill(0);
			_wheel.graphics.drawRect(0, 0,_target.width,_mainHeight);
			_wheel.graphics.endFill();
			
			_target.addChildAt(_wheel, 0);
			_target.addEventListener(MouseEvent.MOUSE_WHEEL,onScrollWheel);
			_wheel.alpha = 0;
			_wheelBool = true;
		}
		
		private function clearMask() : void
		{
			
			if (_rectBool)
			{
				if(_target){
					_target.mask = null;
					_target.parent.removeChild(_rect);
				}
				_rect = null;
				_rectBool = false;
			}
			
		}
		
		private function clearWheel() : void
		{
			
			if(_wheel){
				if (_wheel.parent)
				{
					_wheel.parent.removeChild(_wheel);
					_target.removeEventListener(MouseEvent.MOUSE_WHEEL, onScrollWheel);
					_wheel = null;
					_wheelBool = false;
				}
			}
		}
		
		private function startList() : void
		{
			if (_widthBool == false) return;
			clear();
			
			loadScrollbar();
			scrollbarLive();
			scrollbarSize();
			if (ratio >= 1)
			{
				renderData();
				hideBtn(false);
				_ListBack.visible = false;
				_DownBtn.visible = false;
				_UpBtn.visible =false;
				_showBottomFirst = true;
			}
			else
			{
				createMask();
				createWheel();
				hideBtn(true);
				_DownBtn.filters = null;
				_UpBtn.filters = null;
				_ListBack.visible = true;
				_DownBtn.visible = true;
				_UpBtn.visible = true;
				if (_isShowBottom)
				{
					if (_showBottomFirst == true)
					{
						_ScrollBtn.y = _move;
					}
					if (_ScrollBtn.y > _move - 10)
					{
						_ScrollBtn.y = _move;
					}
				}
				scrollMove();
			}
		}
		
		private function hideBtn(param1:Boolean) : void
		{
			_ScrollBtn.visible = param1;
		}
		
		private function loadScrollbar() : void
		{
			if (_loadThisBool == false)
			{
				if(_target)
				{
					_target.parent.addChildAt(this,2);
					eventListener();
					_loadThisBool = true;
				}
			}
		}
		
		private function removeScrollbar() : void
		{
			if (_loadThisBool&&parent)
			{
				parent.removeChild(this);
				_loadThisBool = false;
			}
		}
		
		private function scrollbarLive() : void
		{
			return;
			if(_target==null){
				return;
			}
			if (_scrollbarXBool == true)
			{	
				x = _scrollbarX;
			}
			else
			{
				x = _target.x + _showWidth;
			}
			
			if (_scrollbarYBool == true)
			{
				y = _scrollbarY;
			}
			else
			{
				y = _targetY + _UpBtn.height;
			}
			
		}
		
		private function scrollbarSize() : void
		{
			_ListBack.height = _showHeight - _DownBtn.height * 2;
			_DownBtn.y = _ListBack.height;
			if(_mainHeight == 0)
			{
				ratio == 0;
			}else
			{
				ratio = _showHeight / _mainHeight;
			}
			_ScrollBtn.height = _ListBack.height * ratio;
			_move = _ListBack.height - _ScrollBtn.height;
			if (_move <= 0)//如果滑块可移动距离为0
			{
				_movePoint = 0;
			}
			else
			{
				_movePoint = _move / (_mainHeight + _moveNum - _showHeight);
			}
			range();
		}
		
		private function range() : void
		{
			if (_ScrollBtn.y > _move)
			{
				_ScrollBtn.y = _move;
			}
			if (_ScrollBtn.y >= 0)
			{
			}
			if (ratio >= 1)
			{
				_ScrollBtn.y = 0;
			}
			scrollMove();
		}
		
		private function eventListener() : void
		{
			_UpBtn.addEventListener(MouseEvent.CLICK, onUpBtn);
			_ScrollBtn.addEventListener(MouseEvent.MOUSE_DOWN, onScrollDown);
			_DownBtn.addEventListener(MouseEvent.CLICK, onDownBtn);
		}
		
		private function removeListener() : void
		{
			_UpBtn.removeEventListener(MouseEvent.CLICK, onUpBtn);
			_ScrollBtn.removeEventListener(MouseEvent.MOUSE_DOWN, onScrollDown);
			_DownBtn.removeEventListener(MouseEvent.CLICK, onDownBtn);
		}
		
		private function onScrollWheel(event:MouseEvent) : void
		{
			if (event.delta > 0)
			{
				upMove();
			}
			else
			{
				downMove();
			}
			
		}
		
		private function onScrollDown(event:MouseEvent) : void
		{
			_showBottomFirst = false;
			stage.addEventListener(MouseEvent.MOUSE_UP, onScrollUp, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onScrollMove, false, 0, true);
			_ScrollBtn.startDrag(false, new Rectangle(-2, .5, 0, _move));
			_isMove = true;
			
		}
		
		private function onScrollUp(event:MouseEvent) : void
		{
			scrollUpClear();
		}
		
		private function scrollUpClear() : void
		{
			_ScrollBtn.stopDrag();
			if (stage == null)
			{
				return;
			}
			stage.removeEventListener(MouseEvent.MOUSE_UP, onScrollUp);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onScrollMove);
			_isMove = false;
			
		}
		
		private function onScrollMove(event:MouseEvent) : void
		{
			_isLostDown = false;
			_isLostUp = false;
			scrollMove();
		}
		
		private function onUpBtn(event:MouseEvent) : void
		{
			upMove();
		}
		
		private function onDownBtn(event:MouseEvent) : void
		{
			downMove();
		}
		
		private function upMove() : void
		{
			_showBottomFirst = false;
			if (_ScrollBtn.y - _speed < 0)
			{
				_ScrollBtn.y = 0;
			}
			else
			{
				_ScrollBtn.y = _ScrollBtn.y - _speed;
			}
			scrollMove();
		}
		
		private function downMove() : void
		{
			_showBottomFirst = false;
			if (_ScrollBtn.y + _speed > _move)
			{
				_ScrollBtn.y = _move;
			}
			else
			{
				_ScrollBtn.y = _ScrollBtn.y + _speed;
			}
			scrollMove();
		}
		
		private function scrollMove() : void
		{
			if (stage == null) return;
			if (_movePoint <= 0)
			{
				_target.y = _targetY;
			}
			else
			{
				//_targetY应该是一开始设置好的滚动目标的y坐标 推测 此处为控制滑块
				//				_target.y = -_ScrollBtn.y / _movePoint + _targetY;
				_target.y = -_ScrollBtn.y / _movePoint + _targetY;
			}
		}
		
		private function close() : void
		{
			if (_isMove)
			{
				scrollUpClear();
			}
			_firstBool = false;
			_showBottomFirst = true;
			clear();
			removeListener();
			removeScrollbar();
			_target = null;
		}
		
		private function clear() : void
		{
			clearMask();
			clearWheel();
		}
		
		private function renderData() : void
		{
			_ScrollBtn.y = 0;
			scrollMove();
			
		}
		
	}
}