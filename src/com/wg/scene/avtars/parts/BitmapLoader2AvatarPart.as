package com.wg.scene.avtars.parts
{
	
	import com.wg.scene.loading.BitmapClsSWFLoaderItem;
	
	import flash.display.BitmapData;

	public class BitmapLoader2AvatarPart extends BasicLoaderBitmapAvatarPart
	{
		override protected function getLoaderCls():Class
		{
			return BitmapClsSWFLoaderItem;
		}
		
		override protected function onCompleteLoadModel(content:*):void
		{
			this.bitmapData = content as BitmapData;
		}
	}
}