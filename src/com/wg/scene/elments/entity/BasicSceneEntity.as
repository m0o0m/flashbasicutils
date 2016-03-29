package com.wg.scene.elments.entity
{
	
	import com.wg.logging.Log;
	import com.wg.scene.mapScene.SceneBasic;
	import com.wg.scene.SceneCamera;
	import com.wg.scene.avtars.BasicAvatar;
	import com.wg.scene.mapScene.layers.DisplaySortableSceneLayer;
	import com.wg.scene.utils.GameMathUtil;
	import com.wg.schedule.IAnimatedObject;
	import com.wg.schedule.ITickedObject;
	
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.utils.getQualifiedClassName;

	public class BasicSceneEntity implements ITickedObject, IAnimatedObject
	{
		
		//basic
		public var uid:String;//runtime id
		public var elementTypeId:int = -1;//see SceneElementType
		public var sceneLayerType:int = DisplaySortableSceneLayer.SCENELAYER_MIDDLE;//See SceneLayer.SCENELAYER_BOTTOM
		public var visibleTestRadius:Number = SceneCamera.DEFAULT_VISIBLE_TEST_RADIUS;
		
		public var scene:SceneBasic;
		public var camera:SceneCamera;
		
		public var isValidDisplay:Boolean = false;
		
		public var x:Number = 0.0;
		public var y:Number = 0.0;
		public var layerIndex:int = 0;
		public var zFighting:Number = 0.0;
		public var screenX:Number = 0.0;
		public var screenY:Number = 0.0;
		
		public var data:*;
		
		public var display:DisplayObject;
		
		private var mInitilized:Boolean = false;
		protected var mIsAnimatedDisplay:Boolean = false;
		
		public function BasicSceneEntity()
		{
			super();
		}
		
		public function get initilized():Boolean { return mInitilized };
		
		public function isInScene():Boolean
		{
			return scene != null;
		}
		
		public function isInScreen():Boolean
		{
			return GameMathUtil.isOverlapCircleAndRectangle(screenX, 
				screenY, visibleTestRadius,
				0, 0, camera.width, camera.height);
		}
		
		public final function initialize():void 
		{ 
			if(!mInitilized) 
			{ 
				onInitialize(); 
				mInitilized = true;
				onInitializeCompleted();
			} 
		}
		
		protected function onInitialize():void
		{
			if(!display) display = createDisplay();
			
			display.visible = false;
			if(display is BasicAvatar) BasicAvatar(display).initialize();
			if(display is IEntityComponent) IEntityComponent(display).owner = this;
			mIsAnimatedDisplay = display is IAnimatedObject;
		}
		
		protected function onInitializeCompleted():void
		{
			
		}
		
		protected function createDisplay():DisplayObject 
		{ 
			var d:BasicAvatar = new BasicAvatar();
			return d;
		};
		
		public final function updateByData(data:* = null):void
		{
			if(!mInitilized) return;
			
			this.data = data;
			
			onUpdateByData();
		}
		
		protected function onUpdateByData():void {};

		public function dispose():void
		{
			isValidDisplay = false;
			if(display)
			{
				if(display.hasOwnProperty("dispose")) display["dispose"]();
				display = null;
			}
		}
		
		public function onTick(deltaTime:Number):void
		{
			onPreUpdate(deltaTime);
			onUpdating(deltaTime);
			//may remove is the updating.
			if(scene) onUpdated(deltaTime);
		}
		
		protected function onPreUpdate(deltaTime:Number):void {};
		protected function onUpdating(deltaTime:Number):void {};
		protected function onUpdated(deltaTime:Number):void 
		{
			screenX = x - camera.scrollX;
			screenY = y - camera.scrollY;
			
			checkIsValidDisplayAvatar();
		}
		
		public function onFrame(deltaTime:Number):void
		{
			if(isValidDisplay)
			{
				display.visible = true;
				
				onUpdatingDisplay(deltaTime);
			}
			else
			{
				display.visible = false;
			}
		}
		
		protected function checkIsValidDisplayAvatar():void
		{
			isValidDisplay = isInScreen(); 
		}
		protected function onUpdatingDisplay(deltaTime:Number):void
		{
			display.x = GameMathUtil.round(screenX);// >> 0
			display.y = GameMathUtil.round(screenY);// >> 0;
//			trace("basicscene::"+deltaTime,display.x,display.y);
			if(mIsAnimatedDisplay) IAnimatedObject(display).onFrame(deltaTime);
		}
		
		public function showDebugLine(value:Boolean):void
		{
			if(display is Sprite)
			{
				var shape:Shape = Sprite(display).getChildByName("debugShape") as Shape;
				if(value)
				{
					if(!shape)
					{
						shape = new Shape();
						shape.name = "debugShape";
						Sprite(display).addChild(shape);
					}
					
					var length:Number = 20;
					
					var graphics:Graphics = shape.graphics;
					
					graphics.clear();
					graphics.lineStyle(1, 0xFF0000);
					graphics.moveTo(0, -length);
					graphics.lineTo(0, length);
					graphics.moveTo(-length, 0);
					graphics.lineTo(length, 0);
					graphics.endFill();	
				}
				else
				{
					if(shape)
					{
						Sprite(display).removeChild(shape);
					}
				}
			}
		}
		
		public function toString():String
		{
			var className:String = getQualifiedClassName(this);
			return "class: " + className + "\n" + 
				"uid: " + uid + "\n" + 
				"typeId: " + elementTypeId + "\n" +
				"sceneLayerType: " + sceneLayerType;
		}
	}
}