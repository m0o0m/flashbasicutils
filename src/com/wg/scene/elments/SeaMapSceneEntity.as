package com.wg.scene.elments
{
	import com.ClientConstants;
	import com.CursorDecorator;
	import com.wg.scene.elments.entity.SceneEntity;
	import com.wg.scene.utils.GameMathUtil;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.utils.StringUtil;
	
	import mymap.scene.Mapscene;

	public class SeaMapSceneEntity extends SceneEntity
	{
		//基本移动方式
		public static const PATH_MOVEING_TYPE:int = 0;
		public static const ANGLE_MOVEING_TYPE:int = 1;
		public static const FOLLOW_MOVEING_TYPE:int = 2;
		//0的扩展移动方式
		public static const POINT_MOVEING_TYPE:int = 3;
		public static const TARGET_MOVEING_TYPE:int = 4;
		public static const CAPTURE_MOVEING_TYPE:int = 5;
		
		//--
		public static const MAX_LOSE_CUPTURE_DISTANCE:Number = 600;
		public static const MIN_COSE_CUPTURE_DISTANCE:Number = 80;
		
		public static const FOLLOW_BUFFER_DISTANCE:Number = 100;
		
		public static const REFIND_CAPTURE_TARGET_DELAY:Number = 0.4;
		public static const LOST_CUOTURE_DELAY:Number = 5;//ms
		
		public static const DEFAULT_BE_CAPTURED_DISTANCE:Number = 50;
		public static const DEFAULT_FOLLOWING_TARGE_TDISTANCE:Number = 200;
		
		//basic
		public var watchGridChange:Boolean = false;
		
		//mouse
		protected var myMouseHandlerId:int = -1;
		protected var myIsSelected:Boolean = false;
		protected var myIsMouseRollOver:Boolean = false;
		
		//moving
		protected var myMovingType:int = PATH_MOVEING_TYPE;
		
		protected var myBeCapturedDistance:Number = DEFAULT_BE_CAPTURED_DISTANCE;
		protected var myFollowingTargetDistance:Number = DEFAULT_FOLLOWING_TARGE_TDISTANCE;
		
		protected var myCurrentMoveToTarget:SeaMapSceneEntity;
		
		private var mWaiteToReFindedTatgetWaiteTime:Number = 0;
		private var mWaiteToLostFindedTargetWaiteTime:Number = 0;
		
		private var _lastMovingGridColIndex:int = 0;
		private var _lastMovingGridRowIndex:int = 0;
		
		protected var mPositionDirty:Boolean = false;
		protected var mLastPositionDirty:Boolean = false;
		
		public function SeaMapSceneEntity()
		{
			super();
		}
		
		public function notifyAnSceneElementArrived(target:SceneEntity):void {};
		public function notifyAnSceneElementCaptured(target:SceneEntity):void {};
		
		public function get sourceMovingSpeed():Number { return mySpeed; }
		public function get movingSpeed():Number { return mySpeed * mySpeedAddition; }
		public function get beCapturedDistance():Number { return myBeCapturedDistance; }
		public function get followingTargetDistance():Number { return myFollowingTargetDistance; }
		public function debugUpdateSpeed(value:Number):void { mySpeed = value; }
		public function getGridPositionColIndex():int { return int(x / ClientConstants.MAP_GRID_WIDTH); }
		public function getGridPositionRowIndex():int { return int(y / ClientConstants.MAP_GRID_WIDTH); }
		
		public function setModelName(value:String):void
		{
			this.setModelHTMLName(StringUtil.substitute(ClientConstants.AVATAR_HTML_NAME_TEMPALTE, 
				ClientConstants.AVATAR_FONT_NAME,
				ClientConstants.OTHER_HEAD_NAME_COLOR.toString(16),
				ClientConstants.AVATAR_FONT_SEIZE,
				value));
		}
		
		public function setModelHTMLName(value:String):void
		{
//			ModelAvatar(display).setModelNameHtml(value);
		}
		
		public function loadModel(url:String):void
		{
//			ModelAvatar(display).loadModel(url);
		}
		
		override public function setPosition(x:Number, y:Number):void
		{
			super.setPosition(x, y);
			
			mPositionDirty = true;
		}
		
		public function moveToByPath(pathPoints:Array, 
									 moveSyncSpeedAdditionPercent:Number = 1, 
									 isLoop:Boolean = false, 
									 onComplete:Function = null):Boolean
		{
			if(!checkIsValidMove()) return false;
			
			if(pathPoints == null || pathPoints.length == 0) return false;
			
			clearMovingData();
			
			if(!isLoop) mMoveToTargetPointComplete = onComplete;
			
			myMovingType = PATH_MOVEING_TYPE;
			
			mySpeedAddition = moveSyncSpeedAdditionPercent;
			myCurrentPathIsLoop = isLoop;
			
			innerMoveToByPath(pathPoints);
			
			return true;
		}
		
		public function moveToByAngle(angle:Number):Boolean
		{
			if(!checkIsValidMove()) return false;
			
			clearMovingData();
			
			myMovingType = ANGLE_MOVEING_TYPE;
			
			this.setAngle(angle);
			
			resumeWalk();
			
			return true;
		}
		
		public function moveToByFollowTarget(target:SeaMapSceneEntity):Boolean
		{
			if(!checkIsValidMove()) return false;
			
			if(target == null || !target.isInScene()) return false;
			
			clearMovingData();
			
			myMovingType = FOLLOW_MOVEING_TYPE;
			myCurrentMoveToTarget = target;
			
			resumeWalk();
			
			return true;
		}
		
		/**
		 *将对象移动到指定的点; 
		 * @param position
		 * @param onComplete
		 * @return 
		 * 
		 */
		public function moveToByPoint(position:Object, onComplete:Function = null):Boolean
		{
			if(!checkIsValidMove()) return false;
			
			var astarPath:Array = Mapscene(scene).seaMapGrid.findPath(position, this, true);
//			var astarPath:Array = [position];
			//astarPath = scene.seaMapGrid.findPath3(position, this, beCapturedDistance);
			//			trace(astarPath);
			if(astarPath != null && astarPath.length > 0)
			{
				clearMovingData();
				
				mMoveToTargetPointComplete = onComplete;
				
				myMovingType = POINT_MOVEING_TYPE;
				
				innerMoveToByPath(astarPath);
				
				return true;
			}
			
			return false;
		}
		
		public function moveToByArriveTarget(target:SeaMapSceneEntity, onComplete:Function = null):Boolean
		{
			if(!checkIsValidMove()) return false;
			
			if(target == null || !target.isInScene()) return false;
			
			//这里可能是静态不会动的元素
			var astarPath:Array = Mapscene(scene).seaMapGrid.findPath2(target, this, target.beCapturedDistance, true);
//			astarPath.push(new Point(target.x,target.y));
			if(astarPath != null && astarPath.length > 0)
			{
				clearMovingData();
				
				mMoveToTargetPointComplete = onComplete;
				
				myMovingType = TARGET_MOVEING_TYPE;
				
				myCurrentMoveToTarget = target;
				
				innerMoveToByPath(astarPath);
				
				return true;
			}
			
			return false;
		}
		
		public function moveToByCaptureTarget(target:SeaMapSceneEntity, onComplete:Function = null):Boolean
		{
			if(!checkIsValidMove()) return false;
			
			if(target == null || !target.isInScene()) return false;
			
			var astarPath:Array =Mapscene(scene).seaMapGrid.findPath2(target, this, target.beCapturedDistance);
//			astarPath.push(new Point(target.x,target.y));
			if(astarPath != null && astarPath.length > 0)
			{
				clearMovingData();
				
				mMoveToTargetPointComplete = onComplete;
				
				myMovingType = CAPTURE_MOVEING_TYPE;
				
				myCurrentMoveToTarget = target;
				
				innerMoveToByPath(astarPath);
				
				return true;
			}
			
			return false;
		}
		
		
		
		protected function checkIsValidMove():Boolean { return true; }
		
		override protected function clearMovingData():void
		{
			super.clearMovingData();
			
			myCurrentMoveToTarget = null;
			
			mWaiteToLostFindedTargetWaiteTime = 0;
			mWaiteToReFindedTatgetWaiteTime = 0;
		}
		
		override protected function onPreUpdate(deltaTime:Number):void
		{
			if(myMovingType == FOLLOW_MOVEING_TYPE)
			{
				if(myCurrentMoveToTarget != null)
				{
					var distance:Number = GameMathUtil.distance(x, y, myCurrentMoveToTarget.x, myCurrentMoveToTarget.y);
					
					if(distance > myFollowingTargetDistance - FOLLOW_BUFFER_DISTANCE)
					{
						if(!myIsWalking) resumeWalk();
						
						//					trace("111: ", distance, this);
					}
				}
			}
			
			if(!mPositionDirty && myIsWalking && watchGridChange)
			{
				_lastMovingGridColIndex = getGridPositionColIndex();
				_lastMovingGridRowIndex = getGridPositionRowIndex();
			}
		}
		
		override protected function onUpdating(deltaTime:Number):void
		{
			if(myIsWalking)
			{
				onUpdatingPosition(deltaTime);
			}
		}
		
		override protected function onUpdated(deltaTime:Number):void
		{
			if(mPositionDirty)
			{
				mPositionDirty = false;
				mLastPositionDirty = true;
				
				onGridPositionChanged(getGridPositionColIndex(), getGridPositionRowIndex());
			}
			else
			{
				if(myIsWalking && watchGridChange)
				{
					var currentGridColIndex:int = getGridPositionColIndex();
					var currentGridRowIndex:int = getGridPositionRowIndex(); 
					
					if(currentGridColIndex != _lastMovingGridColIndex || 
						currentGridRowIndex != _lastMovingGridRowIndex)
					{
						onGridPositionChanged(currentGridColIndex, currentGridRowIndex);
					}
				}
			}
			
			super.onUpdated(deltaTime);
		}
		
		override public function onFrame(deltaTime:Number):void
		{
			super.onFrame(deltaTime);
			
			mLastPositionDirty = false;
		}
		
		protected function onGridPositionChanged(currentColIndex:int, currentRowIndex:int):void {};
		
		//updating position
		override protected function onUpdatingPosition(deltaTime:Number):void
		{
			var actualSpeed:Number = 0;
			
			switch(myMovingType)
			{
				case PATH_MOVEING_TYPE:
				case POINT_MOVEING_TYPE:
				case TARGET_MOVEING_TYPE:
				case CAPTURE_MOVEING_TYPE:
					
					actualSpeed = movingSpeed * deltaTime;
					
					doPathMoving(actualSpeed);
					
					if(myMovingType == CAPTURE_MOVEING_TYPE)
					{
						checkCaptureMoveingType(deltaTime);
					}
					break;
				
				case ANGLE_MOVEING_TYPE:
					actualSpeed = movingSpeed * deltaTime;
					doAngleMoving(actualSpeed);
					break;
				
				case FOLLOW_MOVEING_TYPE:
					if(myCurrentMoveToTarget != null)
					{
						actualSpeed = myCurrentMoveToTarget.movingSpeed * deltaTime;
						doFollowTargetMoving(actualSpeed);	
					}
					break;
			}
		}
		
		private function checkCaptureMoveingType(deltaTime:Number):void
		{
			if(myCurrentMoveToTarget != null &&　myCurrentMoveToTarget.isInScene())
			{
				//here need to check the distance between self and target
				var distance:Number = GameMathUtil.distance(this.x, this.y, myCurrentMoveToTarget.x, myCurrentMoveToTarget.y);
				
				if(distance > MAX_LOSE_CUPTURE_DISTANCE)
				{
					mWaiteToLostFindedTargetWaiteTime += deltaTime;
					if(mWaiteToLostFindedTargetWaiteTime >= LOST_CUOTURE_DELAY)
					{
						mWaiteToLostFindedTargetWaiteTime = 0;
						
						//lose capture target
						stopWalk();
					}
				}
				else if(distance < MIN_COSE_CUPTURE_DISTANCE)
				{
					//captured target
					onCapturedAndSceneElement(myCurrentMoveToTarget);
					myCurrentMoveToTarget.notifyAnSceneElementCaptured(this);
					
					stopWalk();
				}
				else
				{
					mWaiteToReFindedTatgetWaiteTime += deltaTime;
					if(mWaiteToReFindedTatgetWaiteTime >= REFIND_CAPTURE_TARGET_DELAY)
					{
						mWaiteToReFindedTatgetWaiteTime = 0;
						
						//refind
						var astarPath:Array = Mapscene(scene).seaMapGrid.findPath2(myCurrentMoveToTarget, this, myCurrentMoveToTarget.beCapturedDistance);
						astarPath.push(new Point(this.x,this.y));
						if(astarPath != null && astarPath.length > 0)
						{
							innerMoveToByPath(astarPath);
						}
						else
						{
							stopWalk();
						}
					}
				}
			}
			else
			{
				stopWalk();
			}
		}
		
		protected function doAngleMoving(actualSpeed:Number):void
		{
			if(actualSpeed <= 0) return;
			
			this.x += actualSpeed * Math.cos(myAngle);
			this.y += actualSpeed * Math.sin(myAngle);	
		}
		
		override protected function doPathMoving(actualSpeed:Number):void
		{
			if(actualSpeed <= 0) return;
			
			var targetPathPoint:Object = myCurrentPathPoints[myCurrentPathStepIndex];
			if(!targetPathPoint) return;
			var distance:Number = GameMathUtil.distance(targetPathPoint.x, targetPathPoint.y, x, y);
			
			//			trace(distance, actualSpeed, myCurrentPathStepIndex, GameMathUtil.radianToDegree(myAngle));
			if(distance < actualSpeed)//到了该点了
			{
				myCurrentPathStepIndex++;
				
				if(myCurrentPathStepIndex >= myCurrentPathPoints.length)
				{
					//					this.x = targetPathPoint.x;
					//					this.y = targetPathPoint.y;
					
					switch(myMovingType)
					{
						case TARGET_MOVEING_TYPE:
							if(myCurrentMoveToTarget != null && myCurrentMoveToTarget.isInScene())
							{
								onArrivedAndSceneElement(myCurrentMoveToTarget);
								myCurrentMoveToTarget.notifyAnSceneElementArrived(this);
							}
							break;
						
						case PATH_MOVEING_TYPE:
							if(myCurrentPathIsLoop)
							{
								myCurrentPathStepIndex = 0;
								targetPathPoint = myCurrentPathPoints[myCurrentPathStepIndex];
								this.setAngle(GameMathUtil.caculateDirectionRadianByTwoPoint2(x, y, 
									targetPathPoint.x, targetPathPoint.y));
								return;
							}
							else
							{
								onArrivedEndPoint();
							}
							break;
						
						case POINT_MOVEING_TYPE:
							onArrivedEndPoint();
							break;
					}
					
					if(myMovingType != CAPTURE_MOVEING_TYPE)
					{
						var moveCallback:Function = mMoveToTargetPointComplete;
						
						stopWalk();	
						
						if(moveCallback != null) 
						{ 
							moveCallback(); 
							
							moveCallback = null; 
						};
					}
				}
				else
				{
					targetPathPoint = myCurrentPathPoints[myCurrentPathStepIndex];
					
					this.setAngle(GameMathUtil.caculateDirectionRadianByTwoPoint2(x, y, 
						targetPathPoint.x, targetPathPoint.y));
				}
			}
			else
			{
				this.x += actualSpeed * Math.cos(myAngle);
				this.y += actualSpeed * Math.sin(myAngle);
			}
		}
		
		protected function doFollowTargetMoving(actualSpeed:Number):void
		{
			if(actualSpeed <= 0) return;
			
			var distance:Number = GameMathUtil.distance(x, y, myCurrentMoveToTarget.x, myCurrentMoveToTarget.y); 
			
			var minFollowDistance:Number = myFollowingTargetDistance - FOLLOW_BUFFER_DISTANCE;
			var deltaDistanceAndMinFollowDistance:Number = distance - minFollowDistance;
			
			if(deltaDistanceAndMinFollowDistance > 0)
			{
				var faceTargetAngle:Number = GameMathUtil.caculateDirectionRadianByTwoPoint2(x, y, myCurrentMoveToTarget.x, myCurrentMoveToTarget.y);
				this.setAngle(faceTargetAngle);
				
				var percenDeltaAndFollowRange:Number = deltaDistanceAndMinFollowDistance / FOLLOW_BUFFER_DISTANCE;
				if(percenDeltaAndFollowRange < 0.1) percenDeltaAndFollowRange = 0.1;
				
				actualSpeed *= percenDeltaAndFollowRange;
				
				this.x += actualSpeed * Math.cos(myAngle);
				this.y += actualSpeed * Math.sin(myAngle);
			}
			else
			{
				pauseWalk();
			}
		}
		
		protected function onArrivedAndSceneElement(targe:SceneEntity):void
		{
			if(mMoveToTargetPointComplete != null) 
			{
				mMoveToTargetPointComplete();
				mMoveToTargetPointComplete = null;
			}
		}
		
		protected function onCapturedAndSceneElement(targe:SceneEntity):void
		{
			if(mMoveToTargetPointComplete != null) 
			{
				mMoveToTargetPointComplete();
				mMoveToTargetPointComplete = null;
			}
		}
		
		public function setTargetSelected(value:Boolean):void
		{
			if(myIsSelected != value)
			{
				myIsSelected = value;
				
				onTargetSelectedChanged();
			}
		}
		
		protected function setTargetMouseRollOvered(value:Boolean):void
		{
			if(myIsMouseRollOver != value)
			{
				myIsMouseRollOver = value;
				
				onTargetMouseRollOveredChanged();
			}
		}
		
		protected function onTargetSelectedChanged():void {};
		protected function onTargetMouseRollOveredChanged():void {};
		
		override public function dispose():void
		{
			myIsSelected = false;
			
			clearCurrentMouseHandCursor();
			
			myCurrentPathStepIndex = 0;
			myCurrentPathPoints = null;
			myIsWalking = false;
			
			super.dispose();
		}
		
		protected function clearCurrentMouseHandCursor():void
		{
			if(myMouseHandlerId > 0)
			{
				CursorDecorator.getInstance().removeCursorHangingDrop(myMouseHandlerId);
				myMouseHandlerId = -1;
			}
		}
		
		protected function showMouseHandCursor(cursorCls:Class):void
		{
			if(!CursorDecorator.getInstance().isCurrentCursorHangingDrop(myMouseHandlerId))
			{
				myMouseHandlerId = CursorDecorator.getInstance().setCursorHangingDrop(cursorCls);
			}
		}
		
		//Event Handler
		override protected function onRollOverHandler(event:MouseEvent):void
		{
			super.onRollOverHandler(event);
			
			setTargetMouseRollOvered(true);
		}
		
		override protected function onRollOutHandler(event:MouseEvent):void
		{
			super.onRollOutHandler(event);
			
			setTargetMouseRollOvered(false);
		}
	}
}