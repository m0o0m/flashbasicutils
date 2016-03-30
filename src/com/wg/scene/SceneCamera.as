package com.wg.scene
{
	
	import com.wg.scene.utils.GameMathUtil;
	import com.wg.schedule.IAnimatedObject;
	import com.wg.schedule.ITickedObject;
	import com.wg.utils.colorUtils.ColorUtil;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Point;

	public class SceneCamera implements ITickedObject, IAnimatedObject
	{
		/**
		 *摄像头外保留的保存区域;
		 * 通过判断显示对象是否在可视区域中,隐藏和显示对象;
		 * 此处不使用,在entity使用并计算,根据值确定是否隐藏此entity;
		 */
		public static const DEFAULT_VISIBLE_TEST_RADIUS:uint = 50;
		
		/**
		 *测试用,整个场景的宽高; 
		 */
		public static const DEFAULT_SCROLLWIDTH:int = 2700;
		public static const DEFAULT_SCROLLHEIGHT:int = 1800;
		
		/**
		 *设置焦点对象在镜头内的移动范围; 
		 */
		public static const DEADAREA_X:Number = 0.75;
		public static const DEADAREA_Y:Number = 0.75;
		
		
		
		/**
		 * Camera "shake" effect preset: shake camera on both the X and Y axes.
		 */
		public static const SHAKE_BOTH_AXES:uint = 0;
		/**
		 * Camera "shake" effect preset: shake camera on the X axis only.
		 */
		public static const SHAKE_HORIZONTAL_ONLY:uint = 1;
		/**
		 * Camera "shake" effect preset: shake camera on the Y axis only.
		 */
		public static const SHAKE_VERTICAL_ONLY:uint = 2;
		
		public static const SCROLL_FACTOR:Number = 0.5;
		
//		public var isDebug:Boolean = false;
		
		private var _wideScreenShape:Shape;
		private var _cameraStage:Sprite;
		
		/**
		 *代表除焦点对象以外的 对象的移动的x距离,(反方向) 
		 */
		public var scrollX:Number = 0;
		/**
		 *代表除焦点对象以外的 对象的移动的y距离,(反方向) 
		 */
		public var scrollY:Number = 0;
		/**
		 *保存整个场景的宽,包括未显示的 
		 */
		public var scrollWidth:Number = 0;
		/**
		 *保存整个场景的高,包括未显示的 ; 
		 */
		public var scrollHeight:Number = 0;
		
		/**
		 *舞台的宽 
		 */
		public var width:Number  = 0;
		/**
		 *舞台的高 
		 */		
		public var height:Number  = 0;
		
		/**
		 *焦点对象的x坐标,相对于camera 
		 */
		public var focusTargetX:Number = 0;
		/**
		 * 焦点对象的y坐标,相对于camera 
		 */
		public var focusTargetY:Number = 0;
		
		/**
		 * 相当于给整个场景设置一个有厚度的border,???
		 */
		public var scrollLimitX:Number = 0.0;//<0 means out of hor
		public var scrollLimitY:Number = 0.0;
		
		
		
		/**
		 *是否支持有缓冲的移动(显示对象会有个移动范围,不支持的话显示对象会一直居中显示) 
		 */
		public var isTweenMoveCamera:Boolean = false;
		
		private var mSizeDirty:Boolean = false;
		public var lastSizeDirty:Boolean = false;
		
		/**
		 * 舞台宽的一半
		 */
		private var _halfWidth:Number = 0;
		/**
		 *舞台高的一半 
		 */
		private var _halfHeight:Number = 0;
		
		/**
		 *焦点对象 
		 */
		private var _watchTarget:Object;
		
		private var _deadRectangleH:Number = 0;
		private var _deadRectangleV:Number = 0;

		private var _deltaFocusTargetAndCenterX:Number = 0;
		private var _deltaFocusTargetAndCenterY:Number = 0;
		
		private var _fxTargetMovingPosX:Number = 0;
		private var _fxTargetMovingPosY:Number = 0;
		private var _fxIsMoving:Boolean = false;
		private var _fxMovingSpeed:Number = 0;
		private var _fxMoveCameraComplete:Function;
		
		private var _fxEffectPercent:Number = 1;
		//shake effect
		private var _fxShakeIntensity:Number;
		private var _fxShakeDuration:Number;
		private var _fxShakeTime:Number;
		private var _fxShakeOffset:Point = new Point();
		private var _fxShakeDirection:uint;
		private var _fxShakeComplete:Function;
		
		//fade effect
		private var _fxFadeEndRedColor:uint;
		private var _fxFadeEndGreenColor:uint;
		private var _fxFadeEndBlueColor:uint;
		private var _fxFadeIsFadeOut:Boolean = false;
		private var _fxFadeDuration:Number;
		private var _fxFadeTime:Number;
		private var _fxFadeColorTransform:ColorTransform;
		private var _fxFadeComplete:Function;
		
		//widescreen effect
		private var _fxWideScreenHeight:Number;
		private var _currentWideScreenHeight:Number = 0;
		private var _fxWidScreenDuration:Number;
		private var _fxWideIsWideOut:Boolean = false;
		private var _fxWideScreenTime:Number;
		private var _fxWideScreenComplete:Function;
		
		public function SceneCamera(flashStage:Stage,testStage:Sprite)
		{
			super();

			_cameraStage = new camera();
			_cameraStage.mouseEnabled = false;
			_wideScreenShape = new Shape();
			
			_cameraStage.addChild(_wideScreenShape);
			
//			flashStage.addChildAt(_cameraStage, 0);
			//测试用,游戏地图应放在最后一层;
			
			/*_cameraStage.x = 200;
			_cameraStage.y = 100;*/
			flashStage.addChild(_cameraStage);
			flashStage.swapChildren(testStage,_cameraStage);
			setCameraSize(flashStage.stageWidth, flashStage.stageHeight);
		}
		
		public function get cameraStage():Sprite
		{
			return _cameraStage;
		}
		
		/**
		 *设置镜头的宽高 
		 * @param width
		 * @param height
		 * 
		 */
		public function setCameraSize(width:Number, height:Number):void
		{
			if(this.width != width || this.height != height)
			{
				this.width = width;
				this.height = height;
				
				_halfWidth = width * 0.5;
				_halfHeight = height * 0.5;
				
				_deadRectangleH = _halfWidth * DEADAREA_X;
				_deadRectangleV = _halfHeight * DEADAREA_Y;
				
				if(_fxWideScreenTime == 0 && _currentWideScreenHeight > 0)
				{
					drawWideScreen(_currentWideScreenHeight / _fxWideScreenHeight);	
				}
				
				mSizeDirty = true;
			}
		}
		
		public function shake(intensity:Number = 0.05, 
							  duration:Number = 0.5, 
							  direction:uint=SHAKE_BOTH_AXES,
							  force:Boolean = false, 
							  onComplete:Function = null):void
		{
			if(!force && _fxShakeTime > 0)
				return;
			
			//for ever becarefull
			if(duration <= 0) duration = Number.MAX_VALUE;
			
			_fxShakeIntensity = intensity;
			_fxShakeDuration = _fxShakeTime = duration;
			_fxShakeDirection = direction;
			_fxShakeOffset.x = 0;
			_fxShakeOffset.y = 0;
			_fxShakeComplete = onComplete;
		}
		
		public function stopShake():void
		{
			_fxShakeOffset.x = 0;
			_fxShakeOffset.y = 0;
			
			_fxShakeTime = 0;
			_fxShakeComplete = null;
			
			_cameraStage.x = _fxShakeOffset.x;
			_cameraStage.y = _fxShakeOffset.y;
		}
		
		/**
		 * The screen is filled with this color and gradually returns to normal.
		 * 
		 * @param	Color		The color you want to use.
		 * @param	Duration	How long it takes for the flash to fade.
		 * @param	OnComplete	A function you want to run when the flash finishes.
		 * @param	Force		Force the effect to reset.
		 */
		public function fade(color:uint=0xffffffff, 
							  duration:Number = 1, 
							  isFadeOut:Boolean = false,
							  force:Boolean = false,
							  onComplete:Function = null):void
		{
			if(!force && (_fxFadeTime > 0)) return;
			
			_fxFadeEndRedColor = ColorUtil.getRed(color);
			_fxFadeEndGreenColor = ColorUtil.getGreen(color);
			_fxFadeEndBlueColor = ColorUtil.getBlue(color);
			
			//for ever becarefull
			if(duration <= 0) duration = Number.MIN_VALUE;
			
			_fxFadeIsFadeOut = isFadeOut;
			_fxFadeColorTransform = new ColorTransform();
			_fxFadeDuration = _fxFadeTime = duration;
			_fxFadeComplete = onComplete;
		}
		
		public function stopFade():void
		{
			_fxFadeTime = 0;
			_fxFadeComplete = null;
			
			if(_fxFadeColorTransform)
			{
				_fxFadeColorTransform.redMultiplier = 1.0;
				_fxFadeColorTransform.greenMultiplier = 1.0;
				_fxFadeColorTransform.blueMultiplier = 1.0;
				
				_fxFadeColorTransform.redOffset = 0;
				_fxFadeColorTransform.greenOffset = 0;
				_fxFadeColorTransform.blueOffset = 0;
				
				_cameraStage.transform.colorTransform = _fxFadeColorTransform;
			}
		}
		
		public function wideScreen(height:Number, 
								   duration:Number = 1, 
								   isWideOut:Boolean = false,//true open
								   force:Boolean = false,
								   onComplete:Function = null):void
		{
			if(!force && (_fxWideScreenTime > 0)) return;
			
			_fxWideIsWideOut = isWideOut;
			_fxWideScreenHeight = height;
			_fxWideScreenTime = _fxWidScreenDuration = duration;
			_fxWideScreenComplete = onComplete;
		}
		
		public function stopWideScreen():void
		{
			_fxWideScreenTime = 0;
			_currentWideScreenHeight = 0;
			_wideScreenShape.graphics.clear();
		}
		
		/**
		 *改变camara 操作的显示根容器; 
		 * @param cameraStage
		 * 
		 */
		public function setCameraStage(cameraStage:Sprite):void
		{
			if(_cameraStage)
			{
				_cameraStage.removeEventListener(Event.ADDED, camerChildAddOrRemoveHandler, true);
				_cameraStage.removeEventListener(Event.REMOVED, camerChildAddOrRemoveHandler, true);
				
				_cameraStage.removeChild(_wideScreenShape);
			}
			
			_cameraStage = cameraStage;
			
			if(_cameraStage)
			{
				_cameraStage.addChild(_wideScreenShape);
				_cameraStage.addEventListener(Event.ADDED, camerChildAddOrRemoveHandler, true);
				_cameraStage.addEventListener(Event.REMOVED, camerChildAddOrRemoveHandler, true);
			}
		}
		
		//just stop the event chain.
		private function camerChildAddOrRemoveHandler(event:Event):void
		{
			event.stopImmediatePropagation();
		}
		
		/**
		 * 
		 * 重置所有的效果
		 */
		public function reset():void
		{
			_watchTarget = null;
			focusTargetX  = focusTargetY = 0;
			scrollX = scrollY = 0;
			scrollLimitX = scrollLimitY = 0;

			stopFade();
			stopShake();
			stopWideScreen();
		}
		
		public function watchTarget(target:Object, onComplete:Function = null):void
		{
			_watchTarget = target;
			
			_fxIsMoving = false;
			_fxMoveCameraComplete = onComplete;
			
			if(_watchTarget)
			{
				focusTargetX = _watchTarget.x;//GameMathUtil.ceil(_watchTarget.x + (_watchTarget.x > 0 ? 0.0000001:-0.0000001));
				focusTargetY = _watchTarget.y;//GameMathUtil.ceil(_watchTarget.y + (_watchTarget.y > 0 ? 0.0000001:-0.0000001));

				//
				scrollX = GameMathUtil.clamp(focusTargetX - _halfWidth, scrollLimitX, scrollWidth - width - scrollLimitX);
				scrollY = GameMathUtil.clamp(focusTargetY - _halfHeight, scrollLimitY, scrollHeight - height - scrollLimitY);
			}
		}
		
		public function watchPoint(x:Number, y:Number, onComplete:Function = null):void
		{
			_watchTarget = null;
			
			_fxIsMoving = false;
			_fxMoveCameraComplete = onComplete;
			
			focusTargetX = x;
			focusTargetY = y;
			
			focusTargetX = GameMathUtil.clamp(focusTargetX, scrollLimitX + _halfWidth, scrollWidth - _halfWidth - scrollLimitX);
			focusTargetY = GameMathUtil.clamp(focusTargetY, scrollLimitY + _halfHeight, scrollHeight - _halfHeight - scrollLimitY);
		}
		
		public function moveToPoint(x:Number, y:Number, speed:Number, onComplete:Function = null):void
		{
			_watchTarget = null;
			_fxIsMoving = true;
			_fxMovingSpeed = speed;
			_fxTargetMovingPosX = x;
			_fxTargetMovingPosY = y;
			_fxMoveCameraComplete = onComplete;
		}
		
		public function getWatchTarget():Object
		{
			return _watchTarget;
		}
		
		private var _elapsed:Number = 0;
		public function onTick(deltaTime:Number):void
		{
			if(_elapsed<0.1)
			{
				_elapsed +=deltaTime;
				return ;
			}
			lastSizeDirty = mSizeDirty
			mSizeDirty = false;
			
			if(_fxIsMoving)
			{
				var actualSpeed:Number = _fxMovingSpeed * deltaTime;
				var actualDistance:Number = GameMathUtil.distance(focusTargetX, focusTargetY, _fxTargetMovingPosX, _fxTargetMovingPosY);
				
				if(actualDistance < actualSpeed)
				{
					_fxIsMoving = false;
					
					if(_fxMoveCameraComplete != null)
					{
						var f:Function = _fxMoveCameraComplete;
						_fxMoveCameraComplete = null;
						f();
					}
				}
				
				var actualAngle:Number = GameMathUtil.caculateDirectionRadianByTwoPoint2(focusTargetX, focusTargetY, 
					_fxTargetMovingPosX, _fxTargetMovingPosY);
				
				focusTargetX += actualSpeed * Math.cos(actualAngle);
				focusTargetY += actualSpeed * Math.sin(actualAngle);
				
				scrollX = focusTargetX - _halfWidth;
				scrollY = focusTargetY - _halfHeight;
			}
			else
			{
				//normal camera move
				if(_watchTarget)
				{
					focusTargetX = _watchTarget.x;//ceil(_watchTarget.x + (_watchTarget.x > 0 ? 0.0000001:-0.0000001));
					focusTargetY = _watchTarget.y;//ceil(_watchTarget.y + (_watchTarget.y > 0 ? 0.0000001:-0.0000001));
				}
				
				if(isTweenMoveCamera)
				{
					_deltaFocusTargetAndCenterX = 0;
					_deltaFocusTargetAndCenterX = 0;
					
					var centerX:Number = scrollX + _halfWidth;
					var centerY:Number = scrollY + _halfHeight;
					
					_deltaFocusTargetAndCenterX = centerX - focusTargetX;
					if(_deltaFocusTargetAndCenterX != 0)
					{
						if(_deltaFocusTargetAndCenterX > 0)
						{
							_deltaFocusTargetAndCenterX = _deltaFocusTargetAndCenterX < _deadRectangleH ? 
								_deltaFocusTargetAndCenterX : _deadRectangleH;
						}
						else
						{
							_deltaFocusTargetAndCenterX = _deltaFocusTargetAndCenterX > -_deadRectangleH ? 
								_deltaFocusTargetAndCenterX : -_deadRectangleH;
						}
					}
					
					_deltaFocusTargetAndCenterY = centerY - focusTargetY;
					if(_deltaFocusTargetAndCenterY != 0)
					{
						if(_deltaFocusTargetAndCenterY > 0)
						{
							_deltaFocusTargetAndCenterY = _deltaFocusTargetAndCenterY < _deadRectangleV ? 
								_deltaFocusTargetAndCenterY : _deadRectangleV;
						}
						else
						{
							_deltaFocusTargetAndCenterY = _deltaFocusTargetAndCenterY > -_deadRectangleV ? 
								_deltaFocusTargetAndCenterY : -_deadRectangleV;
						}
					}
					
					centerX = focusTargetX + _deltaFocusTargetAndCenterX;
					centerY = focusTargetY + _deltaFocusTargetAndCenterY;
					
					var scrollXDelta:Number = (GameMathUtil.clamp(centerX - _halfWidth, scrollLimitX, 
						scrollWidth - width - scrollLimitX) - scrollX) * SCROLL_FACTOR;
					
					var scrollYDelta:Number = (GameMathUtil.clamp(centerY - _halfHeight, scrollLimitY, 
						scrollHeight - height - scrollLimitY) - scrollY) * SCROLL_FACTOR;
					
					if(GameMathUtil.isEquivalent(scrollXDelta, 0) && GameMathUtil.isEquivalent(scrollYDelta, 0))
					{
						scrollXDelta = 0;
						scrollYDelta = 0;
						
						if(_fxMoveCameraComplete != null)
						{
							var f2:Function = _fxMoveCameraComplete;
							_fxMoveCameraComplete = null;
							f2();
						}
					}
					
					scrollX += scrollXDelta;
					scrollY += scrollYDelta;
					
//									trace("1:   ", focusTargetX, focusTargetY, scrollX, scrollY);
				}
				else
				{
					scrollX = focusTargetX - _halfWidth;
					scrollY = focusTargetY - _halfHeight;
//									trace("2:   ", focusTargetX, focusTargetY, scrollX, scrollY);
				}
			}

			clampScrollXY();
			
//			scrollX = clamp(focusTargetX - _halfWidth, scrollLimitX, scrollWidth - width - scrollLimitX);
//			scrollY = clamp(focusTargetY - _halfHeight, scrollLimitY, scrollHeight - height - scrollLimitY);
			
			if(true)
			{
				_wideScreenShape.graphics.clear();
				_wideScreenShape.graphics.lineStyle(1, 0xFF0000);
				_wideScreenShape.graphics.drawRect(0, 0, width, height);
				_wideScreenShape.graphics.drawCircle(centerX, centerY, 8);
				_wideScreenShape.graphics.endFill();
			}
			
//			skipTween = true;
				
//			if(!skipTween)
//			{
//				var dx:Number = targetX - _viewPortRect.x;
//				var dy:Number = targetY - _viewPortRect.y;
//				
//				//				_scrollRect.x += Math.round(dx * 0.1);
//				//				_scrollRect.y += Math.round(dy * 0.1);
//				
//				if(abs(dx) > _halfStageWidth ||
//					abs(dy) > _halfStageHeight)
//				{
//					_viewPortRect.x = targetX;
//					_viewPortRect.y = targetY;
//				}
//				else
//				{
//					_viewPortRect.x += dx * 0.1;
//					_viewPortRect.y += dy * 0.1;
//				}
//			}
			
			
			//shake effect
			if(_fxShakeTime > 0)
			{
				_fxShakeTime -= deltaTime;
				
				_fxEffectPercent = 0;
				
				if(_fxShakeTime <= 0)//shake complete
				{
					_fxShakeTime = 0;
					
					_fxShakeOffset.x = 0;
					_fxShakeOffset.y = 0;
					
					if(_fxShakeComplete != null)
					{
						_fxShakeComplete();
						_fxShakeComplete = null;
					}
				}
				else
				{
					_fxEffectPercent = _fxShakeTime / _fxShakeDuration;
					
					if((_fxShakeDirection == SHAKE_BOTH_AXES) || (_fxShakeDirection == SHAKE_HORIZONTAL_ONLY))
					{
						_fxShakeOffset.x = GameMathUtil.randomNumberBetween(-1, 1) * _fxShakeIntensity * _fxEffectPercent * width;
					}
					
					if((_fxShakeDirection == SHAKE_BOTH_AXES) || (_fxShakeDirection == SHAKE_VERTICAL_ONLY))
					{
						_fxShakeOffset.y =GameMathUtil.randomNumberBetween(-1, 1) * _fxShakeIntensity * _fxEffectPercent * height;
					}
				}
				
				_cameraStage.x = _fxShakeOffset.x;
				_cameraStage.y = _fxShakeOffset.y;
			}
			
			//fade effect
			if(_fxFadeTime > 0)
			{
				_fxFadeTime -= deltaTime;
				
				_fxEffectPercent = _fxFadeIsFadeOut ? 1.0 : 0.0;

				if(_fxFadeTime <= 0)//fade complete
				{
					_fxFadeTime = 0;
					
					if(_fxFadeComplete != null)
					{
						_fxFadeComplete();
					}
				}
				else
				{
					_fxEffectPercent = _fxFadeIsFadeOut ? 
						1 - _fxFadeTime / _fxFadeDuration :
						_fxFadeTime / _fxFadeDuration;
				}
				
				_fxFadeColorTransform.redMultiplier = _fxFadeColorTransform.greenMultiplier = 
					_fxFadeColorTransform.blueMultiplier = 1 - _fxEffectPercent;
				
				_fxFadeColorTransform.redOffset = GameMathUtil.lerp(0, _fxFadeEndRedColor, _fxEffectPercent);
				_fxFadeColorTransform.greenOffset = GameMathUtil.lerp(0, _fxFadeEndGreenColor, _fxEffectPercent);
				_fxFadeColorTransform.blueOffset = GameMathUtil.lerp(0, _fxFadeEndBlueColor, _fxEffectPercent);
				
				_cameraStage.transform.colorTransform = _fxFadeColorTransform;
			}
			
			//wideScreen effect
			if(_fxWideScreenTime > 0)
			{
				_fxWideScreenTime -= deltaTime;
				
				_fxEffectPercent = _fxWideIsWideOut ? 1.0 : 0.0;
				
				if(_fxWideScreenTime <= 0)
				{
					_fxWideScreenTime = 0;
					
					if(_fxWideScreenComplete != null)
					{
						_fxWideScreenComplete();
					}
				}
				else
				{
					_fxEffectPercent = _fxWideIsWideOut ?
						1 - _fxWideScreenTime / _fxWidScreenDuration:
						_fxWideScreenTime / _fxWidScreenDuration;
				}
				
				drawWideScreen(_fxEffectPercent);
			}
		}
		
		public function clampScrollXY():void
		{
			scrollX = GameMathUtil.clamp(scrollX, scrollLimitX, GameMathUtil.max(scrollWidth - width - scrollLimitX, 0));
			scrollY = GameMathUtil.clamp(scrollY, scrollLimitY, GameMathUtil.max(scrollHeight - height - scrollLimitY, 0));
		}
		
		public function onFrame(deltaTime:Number):void
		{
			lastSizeDirty = mSizeDirty;
			mSizeDirty = false;
		}

		private function drawWideScreen(percent:Number):void
		{
			_wideScreenShape.graphics.clear();
			
			if(percent > 0)
			{
				_currentWideScreenHeight = percent * _fxWideScreenHeight;
				
				_wideScreenShape.graphics.beginFill(0);
				_wideScreenShape.graphics.drawRect(0, 0, width, _currentWideScreenHeight);
				_wideScreenShape.graphics.drawRect(0, height - _currentWideScreenHeight, width, _currentWideScreenHeight);
			}
			else
			{
				_currentWideScreenHeight = 0;
			}
			
			_wideScreenShape.graphics.endFill();
		}
		

	}
}
import flash.display.Sprite;

class camera extends Sprite
{
	override public function set visible(value:Boolean):void
	{
		super.visible = value;
	}
	
	override public function set mouseChildren(bool:Boolean):void
	{
		super.mouseChildren = bool;
	}
	
	override public function set mouseEnabled(bool:Boolean):void
	{
		super.mouseEnabled = bool;
	}
}
