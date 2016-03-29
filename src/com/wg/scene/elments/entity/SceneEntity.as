package com.wg.scene.elments.entity
{
	
	import com.wg.scene.utils.GameMathUtil;
	
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;

	public class SceneEntity extends BasicSceneEntity
	{
		public var mouseEnable:Boolean = true;
		
		//moving
		protected var mySpeed:Number = 200;//pixel/s
		protected var mySpeedAddition:Number = 1;//>0
		protected var myAngle:Number = 0;//弧度
		protected var myAngleIndex:int = 0;
		protected var myIsWalking:Boolean = false;
		protected var myCurrentPathStepIndex:int = 0;
		protected var myCurrentPathPoints:Array = null;
		protected var myCurrentPathIsLoop:Boolean = false;
		
		protected var mMoveToTargetPointComplete:Function;
		
		public function SceneEntity()
		{
			super();
		}
		
		override protected function onInitializeCompleted():void
		{
			if(display is InteractiveObject)
			{
				if(mouseEnable)
				{
					InteractiveObject(display).mouseEnabled = true;
					
					display.addEventListener(MouseEvent.ROLL_OVER, onRollOverHandler);
					display.addEventListener(MouseEvent.ROLL_OUT, onRollOutHandler);
				}
				else
				{
					InteractiveObject(display).mouseEnabled = false;
				}
			}
		}
		
		override public function dispose():void
		{
			if(mouseEnable)
			{
				mouseEnable = false;
				display.removeEventListener(MouseEvent.ROLL_OVER, onRollOverHandler);
				display.removeEventListener(MouseEvent.ROLL_OUT, onRollOutHandler);	
			}
			
			super.dispose();
		}
		
		//Position
		public function setPosition(x:Number, y:Number):void
		{
			this.x = x;
			this.y = y;
		}
		
		//Moving
		public function get angle():Number { return myAngle; }
		//弧度
		public function setAngle(value:Number, isTween:Boolean = false):void
		{
			myAngle = value;
		}
		
		public function get movingPath():Array { return myCurrentPathPoints ? myCurrentPathPoints.concat() : null; }
		public function get movingPathStepIndex():int { return myCurrentPathStepIndex; }
		
		public final function get isWalking():Boolean { return myIsWalking; }
		
		public final function resumeWalk():void
		{
			if(!myIsWalking)
			{
				myIsWalking = true;
				onStartMove();
			}
		}
		
		protected function onStartMove():void {};
		
		public function stopWalk():void
		{
			pauseWalk();
			clearMovingData();
		}
		
		public final function pauseWalk():void
		{
			if(myIsWalking)
			{
				myIsWalking = false;
				onPauseMove();
			}
		}
		
		protected function onPauseMove():void {};
		
		protected function clearMovingData():void
		{
			mySpeedAddition = 1;
			myCurrentPathStepIndex = 0;
			myCurrentPathIsLoop = false;
			myCurrentPathPoints = null;
			
			mMoveToTargetPointComplete = null;
		}
		
		protected function innerMoveToByPath(path:Array):void
		{
			myCurrentPathStepIndex = 0;
			myCurrentPathPoints = path;
			
			adjustAngleWhenMoveStart();
			
			resumeWalk();
		}
		
		protected function adjustAngleWhenMoveStart():void
		{
			this.setAngle(GameMathUtil.caculateDirectionRadianByTwoPoint2(this.x, this.y, 
				myCurrentPathPoints[0].x, myCurrentPathPoints[0].y), true);
		}
		
		override protected function onUpdating(deltaTime:Number):void
		{
			if(myIsWalking)
			{
				onUpdatingPosition(deltaTime);
			}
		}
		
		protected function onUpdatingPosition(deltaTime:Number):void
		{
			doPathMoving(mySpeed * deltaTime);
		}
		
		protected function doPathMoving(actualSpeed:Number):void
		{
			if(actualSpeed <= 0) return;
			
			var targetPathPoint:Object = myCurrentPathPoints[myCurrentPathStepIndex];
			var distance:Number = GameMathUtil.distance(targetPathPoint.x, targetPathPoint.y, x, y);
			
			//			trace(distance, actualSpeed, myCurrentPathStepIndex, GameMathUtil.radianToDegree(myAngle));
			if(distance < actualSpeed)//到了该点了
			{
				myCurrentPathStepIndex++;
				
				if(myCurrentPathStepIndex >= myCurrentPathPoints.length)
				{
					var targetAngle:Number = GameMathUtil.caculateDirectionRadianByTwoPoint2(x, y, 
						targetPathPoint.x, targetPathPoint.y);
					this.setAngle(GameMathUtil.interpolateRadianToQuarer(targetAngle))
					
					this.x = targetPathPoint.x;
					this.y = targetPathPoint.y;
					
					var moveCallback:Function = mMoveToTargetPointComplete;
					
					onArrivedEndPoint();

					stopWalk();

					if(moveCallback != null) 
					{ 
						moveCallback(); 
						
						moveCallback = null; 
					};
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
		
		protected function onArrivedEndPoint():void {};
		
		public var isCanShow:Boolean = true;
		override protected function checkIsValidDisplayAvatar():void
		{
			isValidDisplay = isCanShow&&isInScreen(); 
		}
		
		//Event Handler
		protected function onRollOverHandler(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
		}
		
		protected function onRollOutHandler(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
		}
	}
}