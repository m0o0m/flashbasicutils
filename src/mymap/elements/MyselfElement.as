package mymap.elements
{
	import mymap.avtars.MyselfAvatar;
	
	import flash.display.DisplayObject;
	import com.wg.scene.elments.SeaMapSceneEntity;

	public class MyselfElement extends SeaMapSceneEntity
	{
		public function MyselfElement()
		{
			
		}
		
		override protected function createDisplay():DisplayObject
		{
//			super.createDisplay();
			var avatar:MyselfAvatar = new MyselfAvatar();
			return avatar;
		}
	}
}