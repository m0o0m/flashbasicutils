package mymap.avtars.parts
{
	import flash.display.Sprite;
	import com.wg.scene.avtars.parts.SpriteAvatarPart;
	
	public class MyselfAvatarPart extends SpriteAvatarPart
	{
		public var isDebug:Boolean;
		private var _debugSprite:Sprite;
		public function MyselfAvatarPart()
		{
			super();
		}
		
		public function showDebug(bln:Boolean):void
		{
			isDebug = bln;
			if(!_debugSprite)
			{
				_debugSprite  = new Sprite();
				_debugSprite.graphics.beginFill(0x000000);
				_debugSprite.graphics.drawRect(0,0,20,20);
				this.addChild(_debugSprite);
			}
			_debugSprite.visible = bln;
		}
	}
}