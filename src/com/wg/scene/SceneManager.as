package  com.wg.scene
{
	import com.wg.scene.mapScene.SceneBasic;
	
	public class SceneManager
	{
		private var mActivedScenesStack:Array = [];

		public function SceneManager()
		{
			super();
		}
		
		public function pushScene(scene:SceneBasic):void
		{
			if(mActivedScenesStack.length > 0)
			{
				SceneBasic(mActivedScenesStack[mActivedScenesStack.length - 1]).deactiveScene();
			}
			
			mActivedScenesStack.push(scene);
			
			SceneBasic(mActivedScenesStack[mActivedScenesStack.length - 1]).activeScene();
		}
		
		public function popupScene():void
		{
			if(mActivedScenesStack.length > 0)
			{
				SceneBasic(mActivedScenesStack[mActivedScenesStack.length - 1]).deactiveScene();
				
				mActivedScenesStack.pop();
			}
			
			if(mActivedScenesStack.length > 0)
			{
				SceneBasic(mActivedScenesStack[mActivedScenesStack.length - 1]).activeScene();
			}
		}
		
		public function getScenesStackLength():int
		{
			return mActivedScenesStack.length;
		}
		
		public function getScenesStackAt(index:int):SceneBasic
		{
			return mActivedScenesStack[index];
		}
	}
}