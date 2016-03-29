package com.wg.scene.loading
{
	
	import com.wg.scene.utils.GameMathUtil;
	
	import flash.display.BitmapData;
	import flash.display.LoaderInfo;

	public class BitmapClsSWFLoaderItem extends BasicSWFModelLoadItem
	{
		public function BitmapClsSWFLoaderItem()
		{
			super();
		}
		
		override protected function convertLoadedContentToCacheContent(l:LoaderInfo):*
		{
			var fileName:String = GameMathUtil.getFileName(modelURL);
			var bitmapCls:Class = l.applicationDomain.getDefinition("bitmap_" + fileName) as Class;
			var bitmapData:BitmapData = new bitmapCls(0, 0);
			
			return bitmapData;
		}
	}
}