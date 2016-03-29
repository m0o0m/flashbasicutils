package com.wg.layout
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import views.LayoutView;
	import views.ViewBase;
	import mymvc.views.TestView;

	/**
	 * 只提供两个方法,
	 * addView 添加界面到popup
	 * closeView 移除界面从popup
	 */
	public class Popup extends LayoutSprite
	{
		private var _lockScreenSprite:Sprite;
		
		private var _superViews:Array;//超级view,和任何界面都可共存;坐标点(0,0);无淡入淡出
		private var _freeViews:Array;
		private var _coexistViews:Array;		// 共存视图列表 ;和规定的 界面共存;坐标点 父容器中心点;有淡出
		private var _coexistViewsNoTile:Array;		// 共存视图列表,不平铺
		private var _tipViews:Array;
		
		
		private var _topView:Sprite;
		private var _supers:Dictionary;
		private var _views:Dictionary;
		private var _frees:Dictionary;
		private var _tips:Dictionary;
		
		private var _processList:Dictionary;//存储计算出来的即将展示到界面的窗口的坐标和对象;
		private var _fadeOutList:Dictionary;//存储已经 存在在界面上的窗口;
		
		private var _viewsList:Array;
		private var _tipViewsList:Array;
		private var _view:*;//一般是指View;
		private var _changetMapCloseViews:Array;
		
		private var _shape:Sprite;
		private var _alphp:Number = 0;
		
		private var _hasFade:Boolean = false;
		private var _timerOut:Timer;
		
		public var structure:Layout;
		
		private var _focusView:*;
		
		public function Popup(p_view:*) 
		{
			_view = p_view;
			_supers = new Dictionary();
			_views = new Dictionary();
			_frees = new Dictionary();
			_tips = new Dictionary();
			_viewsList = [];
			_tipViewsList = [];
			_fadeOutList = new Dictionary();
			_processList = new Dictionary();
			//可保存任何类型,自定义类型可以做属性设置和方法调用;
			_tipViews = ["tipsView1","tipsView2"];
			_superViews = [TestView,"superView1","superView2"]
			_coexistViewsNoTile = [
				["coexistViewsNoTile1","coexistViewsNoTile2"]
			]
				
			_coexistViews =[
				["coexistViews1","coexistViews2","contentNmae"]
			];
			
			_view.addToFrameProcessList(this.toString(), process);
		}
		internal var timeOutId:int;
		/**
		 * 
		 * @param p_view
		 * @param p_content
		 * 
		 */
		public function addView(p_view:*, p_content:Sprite) : void
		{
			if (hasViewIncluded(p_view, _tipViews)){
				removeFadeOutList(p_view);
				_tips[p_view] = p_content;
				_tipViewsList.unshift(p_view);
				addChildWithFade(p_view, p_content);
				renderTipView();
				return;
			}
			else if (hasViewIncluded(p_view, _freeViews)){
				removeFadeOutList(p_view);
				_frees[p_view] = p_content;
				addChildWithFade(p_view, p_content);
				
				return;
			}
			else if (hasViewIncluded(p_view, _superViews)){
				removeFadeOutList(p_view);
				_supers[p_view] = p_content;
				addChildWithFade(p_view, p_content);
				return;
			}
			
			var coexistViews:Array = getCoexistViews(p_view,_coexistViews);
			if (coexistViews.length > 0){
				coexistViews = coexistViews[0];
			}
			coexistViews.push(p_view);
			closeExclude(coexistViews);
			removeFadeOutList(p_view);
			
			if(!_views[p_view])
			{
				_views[p_view] = p_content;
				addChildWithFade(p_view, p_content);
			}
			setfocusView(p_view);
			p_content.mouseChildren = true;
			p_content.mouseEnabled = true;
			
			if (p_content.width < structure.width){
				p_content.x = Math.floor((structure.stageWidth - p_content.width) / 2);
				p_content.y = Math.floor((structure.stageHeight - p_content.height) / 2);
			}
			if (_viewsList.indexOf(p_view) == -1){
				
				_viewsList.push(p_view);
			}
			
			if(hasViewIncluded(p_view, _coexistViewsNoTile))
				return;
			
			upPosition();
			
			timeOutId = setTimeout(reposition, 10);
			p_view.inStage = true;
		}
		public function closeView(p_view:*) : void
		{
			if (hasViewIncluded(p_view, _tipViews)){
				var tempPanel3:Sprite = _tips[p_view];
				if (tempPanel3){
					startFadeOut(p_view, true);
					delete _tips[p_view];
					removeView(p_view,tempPanel3);
					deleteTipView(p_view);
				}
				return;
			}
			else if (hasViewIncluded(p_view, _freeViews)){
				var tempPanel1:Sprite = _frees[p_view];
				if (tempPanel1){
					startFadeOut(p_view, true);
					delete _frees[p_view];
					removeView(p_view,tempPanel1);
				}
				return;
			}
				
			else if (hasViewIncluded(p_view, _superViews)){
				var tempPanel2:Sprite = _supers[p_view];
				if (tempPanel2){
					startFadeOut(p_view, true);
					delete _supers[p_view];
					removeView(p_view,tempPanel2);
				}
				return;
			}
				
			else if (_views[p_view] is Sprite)
			{
				_views[p_view].mouseChildren = false;
				_views[p_view].mouseEnabled = false;
				closeViewBased(p_view, true);
			}
			
			setfocusView(null);
			
			var tempView:Object = null;
			for (tempView in _views){
				if (!_focusView){
					setfocusView(tempView);
					break;
				}
			}
			
			timeOutId = setTimeout(closePositon, 100);
			p_view.inStage = false;
		}
		private function closePositon():void
		{
			clearTimeout(timeOutId);
			upPosition();
		}
		private function deleteTipView(view:*):void
		{
			for(var i:int=0;i<_tipViewsList.length;i++)
			{
				if(_tipViewsList[i] == view)
				{
					_tipViewsList.splice(i,1);
					return;
				}
			}
		}
		public function reposition():void
		{
			upModalShape();
			upPosition();
		}
		// 判断在视图数组中是否包含该视图
		private function hasViewIncluded(p_displayObj:*, p_views:Array) : Boolean
		{
			var len:int = p_views ? (p_views.length) : (0);
			var i:int = 0;
			while (i < len){
				/*var arrStr:String = String(p_views[i]+"");
				var objStr:String = String(p_displayObj+"");
				
				var viewName:String=arrStr.slice(7,-1);
				var p_displayObjName:String=objStr.slice(8,-1);*/
				
				//测试用
				var viewName:String=p_views[i];
				var p_displayObjName:String=p_displayObj;
				
				if (p_displayObjName == viewName)
				{
					return true;
				}
				i++;
			}
			return false;
		}
		
		/**
		 *将界面从 _fadeOutList 中移除
		 * @param p_view
		 * 
		 */
		private function removeFadeOutList(p_view:*) : void
		{
			if (_fadeOutList[p_view]){ 
				removeChild(_fadeOutList[p_view]);
				delete _fadeOutList[p_view];
			}
		}
		
		/**
		 *将界面加入popup 中; 
		 * @param p_view
		 * @param p_panel
		 * 
		 */
		private function addChildWithFade(p_view:*, p_panel:Sprite) : void
		{
			//是否添加全屏背景
			if(p_view is String)
			{
				
			}else if(p_view.isModal)
			{
				addMask();
			}
			
			var panel:Sprite = p_panel;
			addChild(p_panel);
		}
		/**
		 *添加一个全屏背景; 
		 * @param p_isBottom
		 * @param p_alpha
		 * 
		 */
		public function addMask(p_isBottom:Boolean = true, p_alpha:Number = 0.3) : void
		{
			if (_shape == null){
				_shape = new Sprite();
				_shape.name = "popup AddMask";
			}
			_alphp = p_alpha;
			
			if (p_isBottom)
			{
				addChild(_shape);
			}
			else
			{
				addChildAt(_shape, 0);
			}
			
			upModalShape();
		}
		
		/**
		 *绘画出一个半透明全屏背景; 
		 * 
		 */
		private function upModalShape():void
		{
			if (_shape && _shape.parent)
			{
				_shape.graphics.clear();
				_shape.graphics.beginFill(0, _alphp);
				_shape.graphics.drawRect(0, 0, structure.stageWidth, structure.stageHeight);
				_shape.graphics.endFill();
			}
		}
		
		private function getCoexistViews(p_view:*,coexistViews:Array) : Array
		{
			var result:Array = [];
			
			var len:int = coexistViews.length;
			var i:int = 0;
			var childCoexistViews:Array;
			while (i < len){
				childCoexistViews = coexistViews[i];
				if (hasViewIncluded(p_view, childCoexistViews))
				{			
					var tempViews:Array = [];
					for (var view:Object in _views){
						if (hasViewIncluded(view, childCoexistViews)){
							tempViews.push(view);
						}
					}
					
					//					if (tempViews.length > 0){
					if (tempViews.length >= 1)
					{
						result.push(tempViews); 
					}
					//					}
				}
				i++;
			}
			return result;
		}
		/**
		 *开始关闭已经存在的 ,判断完是否共存后;
		 * @param p_coexistViews
		 * 
		 */
		private function closeExclude(p_coexistViews:Array) : void
		{
			var keys:Array = getKeys(_views);
			var i:int = 0;
			while (i < keys.length)
			{
				if (p_coexistViews.indexOf(keys[i]) == -1) 
				{
					closeViewBased(keys[i], false);
				}
				i++;
			}
		}
		/**
		 *关闭不能共存的 已经存在的界面 
		 * @param p_view
		 * @param p_isFromCloseView
		 * 
		 */
		private function closeViewBased(p_view:*, p_isFromCloseView:Boolean) : void
		{
			//测试用
//			_view.cancelCenter(p_view.sign);
			startFadeOut(p_view);
			removeView(p_view,_views[p_view]);
			delete _views[p_view];
			
			if (!p_isFromCloseView){
				//测试用
				//执行关闭界面的回调函数close();
				if(!(p_view is String)) p_view.close();
			}
			
			var len:int = _viewsList.length;
			var i:int = 0;
			while (i < len){
				if (p_view == _viewsList[i]){
					_viewsList.splice(i, 1);
					break;
					
				}
				i++;
			}
			//Shortcut.removeView(p_view);
		}
		/**
		 *界面out动画执行; 用界面的截图操作动画展示效果
		 * @param p_view
		 * @param p_isSuper
		 * 
		 */
		private function startFadeOut(p_view:*, p_isSuper:Boolean = false) : void
		{
			var tempPanel:* = _views[p_view] || (!p_isSuper ? (_supers[p_view]) : (_frees[p_view]));
			if (tempPanel && tempPanel.width > 0 && tempPanel.height > 0 && tempPanel.parent){
				//面板截图
				var mcRect:Rectangle = tempPanel.getBounds(tempPanel);
				if(mcRect.width == 0 || mcRect.height == 0)
				{
					return;
				}
				var _matrix:Matrix = new Matrix();
				_matrix.translate(-mcRect.x, -mcRect.y);
				var tempBMD:BitmapData = new BitmapData(mcRect.width, mcRect.height, true, 0x000000);
				tempBMD.draw(tempPanel, _matrix);
				var tempBM:Bitmap = new Bitmap(tempBMD);
				tempBM.x = tempPanel.x + mcRect.x;
				tempBM.y = tempPanel.y +  mcRect.y;
				addChildAt(tempBM, getChildIndex(tempPanel));
				removeFadeOutList(p_view);
				_fadeOutList[p_view] = tempBM;
				
			}
			
			_hasFade = true;
			
			if (!_timerOut) {
				_timerOut = new Timer(10);
				_timerOut.addEventListener(TimerEvent.TIMER, onFadeOut);
			}
			_timerOut.start();
		}
		/**
		 * 界面飞出时,每个时间段内做的操作,这里改变界面的alpha值;
		 * @param event
		 * 
		 */
		private function onFadeOut(event:TimerEvent) : void
		{
			var tempPanel:Object = null;
			var tempBM:Bitmap = null;
			var i:int = 0;
			for (tempPanel in _fadeOutList){
				
				tempBM = _fadeOutList[tempPanel];
				if (tempBM.alpha > 0){
					tempBM.alpha = tempBM.alpha - 0.08;
					i++;
					continue;
				}
				delete _fadeOutList[tempPanel];
				removeChild(tempBM);
			}
			
			if (i == 0){
				_hasFade = false;
				_timerOut.stop();
			}
		}
		/**
		 *移除界面 从popup中 
		 * @param p_view
		 * @param p_panel
		 * 
		 */
		private function removeView(p_view:*,p_panel:Sprite) : void
		{
			if(p_view is String){
			
			}else if(p_view.isModal){
				removeMask();
			}
			if (p_panel && p_panel.parent){
				removeChild(p_panel);
			}
		}
		
		/**
		 *移除绘制的背景图 
		 * 
		 */
		public function removeMask() : void
		{
			if (_shape && _shape.parent){
				removeChild(_shape);
			}
		}
		
		/**
		 *设置焦点界面,即即将展示的界面; 
		 * @param p_view
		 * 
		 */
		private function setfocusView(p_view:*) : void
		{
			_focusView = p_view;
		}
		/**
		 *更新界面的坐标 
		 * 
		 */
		private function upPosition() : void
		{
			var space:int = 10;
			var position:Number = 0;
			var tempView:*;
			var tempSprite:Sprite;
			var viewIndex:int = _viewsList.length - 1;
			var needTile:Boolean = true;
			while (viewIndex > -1)
			{
				tempView = _viewsList[viewIndex];
				tempSprite = _views[tempView];
				if (tempSprite)
				{
					position = position + (tempSprite.width + (viewIndex > 0 ? (space) : (0)));
				}
				
				if(needTile&&hasViewIncluded(tempView, _coexistViewsNoTile))
				{
					needTile = false;
				}
				
				viewIndex--;
			}
			
			var viewsLength:int = _viewsList.length;
			var offsetX:int = 0;
			var offsetY:int = 0;
			if (viewsLength == 1)
			{
				tempSprite = _views[_viewsList[0]];
				offsetX = Math.floor((structure.stageWidth - tempSprite.width) / 2);
				offsetY = Math.floor((structure.stageHeight - tempSprite.height) / 2);
				moveTo(_viewsList[0], tempSprite, offsetX, offsetY);
			}
			else if (viewsLength > 1)
			{
				var isTooWidth:Boolean = position > structure.stageWidth;
				var centerX:Number = (structure.stageWidth - position) / 2;
				viewIndex = 0;
				var isInNoTile:Boolean
				while (viewIndex < viewsLength)
				{
					tempSprite = _views[_viewsList[viewIndex]];
					if (tempSprite)
					{
						offsetX = Math.floor(isTooWidth||!needTile ? ((structure.stageWidth - tempSprite.width) / 2) : (centerX));
						offsetY = Math.floor((structure.stageHeight - tempSprite.height) / 2);
						moveTo(_viewsList[viewIndex], tempSprite, offsetX, offsetY);
						centerX = centerX + (tempSprite.width + space);
					}
					viewIndex++;
				}
			}
			
			renderLockScreen();
			respositionTopView();
		}
		/**
		 *开始锁定 _lockScreenSprite 
		 * 
		 */
		private function renderLockScreen():void{
			if (!_lockScreenSprite) return;
			
			_lockScreenSprite.graphics.clear();
			_lockScreenSprite.graphics.beginFill(1, .2);
			_lockScreenSprite.graphics.drawRect(0, 0, structure.stage.stageWidth, structure.stage.stageHeight);
			_lockScreenSprite.graphics.endFill();
		}
		
		/**
		 *改变界面 的 坐标 
		 * @param p_view
		 * @param p_sprite
		 * @param p_offsetX
		 * @param p_offsetY
		 * 
		 */
		private function moveTo(p_view:*, p_sprite:Sprite, p_offsetX:Number, p_offsetY:Number) : void
		{
			var distanceX:int = p_offsetX - p_sprite.x;
			var distanceY:int = p_offsetY - p_sprite.y;
			var times:int = 6;
			var dx:int = distanceX / times;
			var dY:int = distanceY / times;
			_processList[p_view] = {panel:p_sprite, x:p_sprite.x, y:p_sprite.y, dx:dx, dy:dY, i:0, n:times};
		}
		/**
		 * 居中显示 _topView
		 * 
		 */
		private function respositionTopView():void{
			if (_topView){
				_topView.x = (structure.stageWidth - _topView.width)/2;
				_topView.y = (structure.stageHeight - _topView.height)/2;
			}
		}
		
		private function renderTipView():void
		{
			var orX:int;
			var orY:int;
			var moveToX:int;
			var moveToY:int;
			var tipSpriteInfo:Sprite;
			var alpha:Number;
			for(var i:int=0;i<_tipViewsList.length;i++)
			{
				tipSpriteInfo = _tips[_tipViewsList[i]];
				orX = Config.layout.stageWidth - tipSpriteInfo.width;
//				orX = _view.layout.stageWidth - tipSpriteInfo.width;
				tipSpriteInfo.x = orX;
				if(i == 0)
				{
					tipSpriteInfo.y =  Config.layout.stageHeight - 80;
//					tipSpriteInfo.y =  _view.layout.stageHeight - 80;
					tipSpriteInfo.alpha = 0;
					alpha = 0.05; 
				}else if(i > 2)
				{
					alpha = -0.05;
				}else
				{
					alpha = 0;
				}
				_processList[_tipViewsList[i]] = {panel:tipSpriteInfo,dx:0, dy:-(tipSpriteInfo.height + 10)/20, i:0, n:20,alpha:alpha};
			}
			
		}
		/**
		 * 
		 * @param displayObj
		 * @return 
		 * 
		 */
		public function hasView(displayObj:*) : Boolean
		{
			return _views[displayObj] || _supers[displayObj] || _frees[displayObj];
		}
		
		/**
		 *每个时间间隔都执行的函数; 
		 * 
		 */
		private function process() : void
		{
			var view:*;
			var target:Object;
			var list:Array = getKeys(_processList);
			var i:int = 0;
			while (i < list.length){
				view = list[i];
				target = _processList[view];
				if (target.panel.parent && target.i < target.n){
					if(target.alpha && target.alpha != 0)
					{
						target.panel.alpha = target.panel.alpha + target.alpha;
						if(target.panel.alpha <= 0)
						{
							closeView(view);
						}
					}
					target.panel.x = target.panel.x + target.dx;
					target.panel.y = target.panel.y + target.dy;
					target.i ++;
					
				}
				else{
					delete this._processList[view];
				}
				i++;
			}
		}
		
		public static function getKeys(object:Object) : Array
		{
			var keys:Array = [];
			for (var element:* in object) {
				keys.push(element);
			}
			return keys;
		}
		
		public static function getValues(object:Object) : Array
		{
			var values:Array = [];
			for each (var element:* in object) {
				values.push(element);
			}
			return values;
		}
	}
	
}