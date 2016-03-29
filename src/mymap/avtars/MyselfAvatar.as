package mymap.avtars
{
	import com.wg.scene.avtars.parts.IAvatarPart;
	import mymap.avtars.parts.MyselfAvatarPart;
	import com.wg.scene.avtars.BasicAvatar;

	public class MyselfAvatar extends BasicAvatar
	{
		public function MyselfAvatar()
		{
			super();
		}
		
		override protected function onInitialize():void
		{
			var part:MyselfAvatarPart = new MyselfAvatarPart();
			part.name = "SeaRoleHeaderPart";
			part.showDebug(true);
			this.addAvatarPart(part as com.wg.scene.avtars.parts.IAvatarPart);
		}
	}
}