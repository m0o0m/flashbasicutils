package com.wg.scene.avtars
{
	
	import com.wg.scene.avtars.parts.IAvatarPart;
	import com.wg.scene.elments.entity.BasicSceneEntity;
	import com.wg.scene.elments.entity.IEntityComponent;
	import com.wg.scene.utils.UniqueLinkList;
	import com.wg.schedule.IAnimatedObject;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class BasicAvatar extends Sprite implements IAnimatedObject, IEntityComponent
	{
		public static const DEFAULT_HIT_TEST_RADIUS:uint = 50;
		
		public var hitTestRadiusCenterX:Number = 0;
		public var hitTestRadiusCenterY:Number = -30;
		public var hitTestRadius:Number = DEFAULT_HIT_TEST_RADIUS;
		
		public var data:*;
		
		private var mInitilized:Boolean = false;
		
		protected var mAvatarParts:UniqueLinkList;
		
		private var mOwner:BasicSceneEntity;
		
		public function BasicAvatar()
		{
			super();
			
			this.mouseChildren = false;
			this.mAvatarParts = new UniqueLinkList();
		}
		
		//IEntityComponent Interface
		public function get owner():BasicSceneEntity { return mOwner; }
		public function set owner(value:BasicSceneEntity):void { mOwner = value; }
		
		public final function get initilized():Boolean { return mInitilized; }
		public function initialize(data:* = null):void
		{
			if(!mInitilized)
			{
				this.data = data;
				//hitTestRadius
				/*if(hitTestRadius > 0)
					createHitTestSprite();*/ 
				onInitialize();
				mInitilized = true;
				onInitializeComplete();
			}
		}
		
		protected function createHitTestSprite():void
		{
			var s:Sprite = new Sprite();
			s.graphics.beginFill(0x000000);
			s.graphics.drawCircle(0, 0, hitTestRadius);
			s.x = hitTestRadiusCenterX;
			s.y = hitTestRadiusCenterY;
//			s.visible = false;
			addChild(s);
			this.hitArea = s;
		}
		
		public function addAvatarPart(avatarPart:IAvatarPart):void
		{
			mAvatarParts.add(avatarPart);
			onAvatarPartAdded(avatarPart);
		}
		
		protected function onAvatarPartAdded(avatarPart:IAvatarPart):void
		{
			this.addChild(DisplayObject(avatarPart));
		}
		
		public function removeAvatarPart(avatarPart:IAvatarPart):void
		{
			mAvatarParts.remove(avatarPart);
			avatarPart.dispose();
			onAvatarPartRemoved(avatarPart);
		}
		
		protected function onAvatarPartRemoved(avatarPart:IAvatarPart):void
		{
			DisplayObject(avatarPart).parent.removeChild(DisplayObject(avatarPart))
		}
		
		public function getAvatarPartsCount():int
		{
			return mAvatarParts.length;
		}
		
		public function getAvatarPartByName(name:String):IAvatarPart
		{
			return mAvatarParts.findItemByFunction(function(avatarPart:IAvatarPart):Boolean {
				return avatarPart.name == name;
			});
		}
		
		public function getAvatarPartsByType(type:String):Array
		{
			return mAvatarParts.findItemsByFunction(function(avatarPart:IAvatarPart):Boolean {
				return avatarPart.type == type;
			});
		}
		
		public function dispose():void
		{
			this.hitArea = null;
			
			data = null;
			mInitilized = false;
			
			var avatarPart:IAvatarPart = mAvatarParts.moveFirst();
			while(avatarPart)
			{
				avatarPart.dispose();
				avatarPart = mAvatarParts.moveNext();
			}
			mAvatarParts.clear();
			mAvatarParts = null;
			
			while(this.numChildren) removeChildAt(this.numChildren - 1);
		}
		
		protected function onInitialize():void {};
		protected function onInitializeComplete():void {};
		
		//IAnimatedObject Interface
		public function onFrame(deltaTime:Number):void
		{
			var avatarPart:IAvatarPart = mAvatarParts.moveFirst();
			while(avatarPart)
			{
				onAvatarPartsUpdating(avatarPart, deltaTime);
				
				avatarPart = mAvatarParts.moveNext();
			}
		}
		
		protected function onAvatarPartsUpdating(avatarPart:IAvatarPart, deltaTime:Number):void
		{
			avatarPart.onFrame(deltaTime);
		}
	}
}