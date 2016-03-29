package com.wg.scene.mapScene
{
	
	import flash.events.Event;

	public class MapSceneEvent extends Event
	{
		public static const ADD_SCENE_ELEMENT:String  = "addSceneElement";
		public static const REMOVE_SCENE_ELEMENT:String  = "removeSceneElement";

		public static const SCENE_INITIALIZED:String = "sceneInitialized";
		public static const SCENE_CLEARED:String = "sceneCleared";
		
		public static const SCENE_BACKGROUND_CLICK:String = "sceneBackgroundClick";
		
		public static const SEFL_TARGET_START_MOVE:String = "selfTargetStartMove";
		public static const SEFL_TARGET_PAUSE_MOVE:String = "selfTargetPauseMove";
		public static const SEFL_TARGET_COMPLETE_MOVE:String = "selfTargetCompleteMove";
		
		public var x:Number;
		public var y:Number;

		public var sceneElement:*;
		
		public function MapSceneEvent(type:String)
		{
			super(type);
		}
	}
}