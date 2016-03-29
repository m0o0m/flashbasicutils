package  com.wg.scene.basics
{
	import com.wg.scene.mapScene.SceneBasic;
	import com.wg.scene.SceneCamera;
	import com.wg.schedule.IAnimatedObject;
	import com.wg.schedule.ITickedObject;


	public class BasicSceneLayer extends BasicViewElement implements IAnimatedObject, ITickedObject
	{
		public var scene:SceneBasic;
		public var camera:SceneCamera;
		
		public function BasicSceneLayer()
		{
			super();
			
			this.mouseEnabled = false;
			this.mouseChildren = false;
		}
		
		//IAnimatedObject Interface
		public function onFrame(deltaTime:Number):void {};
		public function onTick(deltaTime:Number):void {};
	}
}