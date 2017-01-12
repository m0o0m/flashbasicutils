package views
{
	import com.google.zxing.BarcodeFormat;
	import com.google.zxing.EncodeHintType;
	import com.google.zxing.Writer;
	import com.google.zxing.common.BitMatrix;
	import com.google.zxing.common.flexdatatypes.HashTable;
	import com.google.zxing.qrcode.QRCodeWriter;
	import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	

	public class ErweimaView extends ViewBase
	{
		private var _param:HashTable;
		private var writer:Writer;
		public function ErweimaView()
		{
			panelName = "erweimaComp";
			super();
		}
		override protected function render():void
		{
			if(!content)
			{
				var maincls:Class = Config.resourceLoader.getClass(panelName);
				content = new maincls();
				this.addChild(content);
				
			}
			super.render();
			fliterUrl();
		}
		private function fliterUrl():void
		{
			var url:String = "http://www.baidu.com?dasdjkljksljkjkljkljkjkjkjkjkjkljkjkljkljlkjkljkjljkjljklj";
			
			var qrImg:Bitmap = show(onCreate(url));
			qrImg.width = content.ma_mc.width;
			qrImg.height = content.ma_mc.width;
			content.ma_mc.addChild(qrImg);
		}
		private function show(bytes:BitMatrix):Bitmap {
			var w:int = bytes.width, h:int = bytes.height;
			var bmp:BitmapData = new BitmapData(w, h);
			for (var i:int = 0; i < w; i++) {
				for (var j:int = 0; j < h;j++) {
					bmp.setPixel(i, j, bytes._get(i,j)?0:0xffffff);
				}
			}
			
			return new Bitmap(bmp);
		}
		/**
		 *计算出符合二维码大小的尺寸; 
		 * @param url
		 * @return 
		 * 
		 */
		private function onCreate(url:String):BitMatrix {
			var qrcodeSize:uint = 200;
			var txtLength:int = url.length - 310;
			if(txtLength>0)
			{
				var num:uint = Math.ceil(txtLength/40);
				qrcodeSize = qrcodeSize+num*10;
			}
			var param:Object = {};
			param["ERROR_CORRECTION"] = ErrorCorrectionLevel.L;
			param["charset"] = "UTF-8";
			param['size'] = qrcodeSize;
			_param = new HashTable(2);
			_param.Add(EncodeHintType.CHARACTER_SET, param.charset);
			_param.Add(EncodeHintType.ERROR_CORRECTION, param["ERROR_CORRECTION"]);
			
			
			if(!writer)writer = new QRCodeWriter() as Writer;
			var r:BitMatrix = writer.encode(url, BarcodeFormat.QR_CODE, param.size, param.size, _param) as BitMatrix;
			
			return r;
		}
		override public function close():void
		{
			super.close();
		}
	}
}