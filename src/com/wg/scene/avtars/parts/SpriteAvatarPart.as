package com.wg.scene.avtars.parts
{
	
	import com.wg.scene.avtars.BasicAvatar;
	
	import flash.display.Sprite;

	public class SpriteAvatarPart extends Sprite implements IAvatarPart
	{
		private var mType:String;
		private var mOwner:BasicAvatar;
		private var mPartIndex:int = 0;
		
		//Transform
		private var mX:Number = 0.0;
		private var mY:Number = 0.0;
		private var mScaleX:Number = 1.0;
		private var mScaleY:Number = 1.0;
		private var mPivotX:Number = 0.0;
		private var mPivotY:Number = 0.0;
		
		private var mTransformDirty:Boolean = false;
		
		public function SpriteAvatarPart()
		{
			super();
		}
		
		public function get partIndex():int { return mPartIndex };
		public function set partIndex(value:int):void { mPartIndex = value };
		
		public function get type():String { return mType };
		public function set type(value:String):void { mType = value };
		
		public function get owner():BasicAvatar { return mOwner };
		public function setOwner(value:BasicAvatar):void
		{
			mOwner = value;
		}
		
		//Display
		override public function get x():Number { return mX; }
		override public function set x(value:Number):void 
		{ 
			if(mX != value) 
			{ 
				mX = value; 
				mTransformDirty = true; 
			} 
		}
		
		override public function get y():Number { return mY; }
		override public function set y(value:Number):void 
		{ 
			if(mY != value) 
			{ 
				mY = value; 
				mTransformDirty = true; 
			}
		}
		
		override public function get scaleX():Number { return mScaleX };
		override public function set scaleX(value:Number):void 
		{
			if(mScaleX != value)
			{
				mScaleX = value;
				mTransformDirty = true; 
			}
		}
		
		override public function get scaleY():Number { return mScaleY };
		override public function set scaleY(value:Number):void 
		{
			if(mScaleY != value)
			{
				mScaleY = value;
				mTransformDirty = true; 
			}
		}
		
		public function get pivotX():Number { return mPivotX; }
		public function set pivotX(value:Number):void
		{
			if(mPivotX != value)
			{
				mPivotX = value;
				mTransformDirty = true; 
			}
		}
		
		public function get pivotY():Number { return mPivotY; }
		public function set pivotY(value:Number):void
		{
			if(mPivotY != value)
			{
				mPivotY = value;
				mTransformDirty = true; 
			}
		}
		
		protected function onRenderTransform():void
		{
			super.x = int(mX - mPivotX * mScaleX);
			super.y = int(mY - mPivotY * mScaleY);
			
			super.scaleX = mScaleX;
			super.scaleY = mScaleY;
		}
		
		public function onFrame(deltaTime:Number):void
		{
			if(mTransformDirty)
			{
				onRenderTransform();
				mTransformDirty = false;
			}
		}
		
		public function dispose():void {};
	}
}