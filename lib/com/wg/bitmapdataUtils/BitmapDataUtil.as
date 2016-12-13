package com.wg.bitmapdataUtils
{
	
	import com.adobe.images.PNGEncoder;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	public final class BitmapDataUtil
	{
		
		public static function qiege(bm:Bitmap):*{
			var image:Bitmap = bm;
			
			// compute the width and height of each piece
			var pieceWidth:Number = image.width/6;
			var pieceHeight:Number = image.height/4;
			
			// loop through all pieces
			for(var x:uint=0;x<6;x++) {
				for (var y:uint=0;y<4;y++) {
					
					// create new puzzle piece bitmap
					var newPuzzlePieceBitmap:Bitmap = new Bitmap(new BitmapData(pieceWidth,pieceHeight));
					newPuzzlePieceBitmap.bitmapData.copyPixels(image.bitmapData,new Rectangle(x*pieceWidth,y*pieceHeight,pieceWidth,pieceHeight),new Point(0,0));
					
					// create new sprite and add bitmap data to it
					var newPuzzlePiece:Sprite = new Sprite();
					newPuzzlePiece.addChild(newPuzzlePieceBitmap);
					
					// add to stage
					//addChild(newPuzzlePiece);
					
					// set location
					newPuzzlePiece.x = x*(pieceWidth+5)+20;
					newPuzzlePiece.y = y*(pieceHeight+5)+20;
				}
			}
		}
		
		public static function mc2bmd(mc:MovieClip):BitmapData
		{
			var mc:MovieClip = mc;
			var mBit:BitmapData = new BitmapData(mc.width,mc.height, true, 0xffffff);
			mBit.draw(mc);
			//var bitmap:Bitmap = new Bitmap(mBit);
			
			/*var displayObject:DisplayObject = stage; 
			
			var bitmapData:BitmapData = new BitmapData(displayObject.width,displayObject.height,true,0xffffff); 
			
			bitmapData.draw(displayObject);   */
			
			/*
			var bitmap:Bitmap = new Bitmap(bitmapData);        
			
			var png:PNGEncoder = new PNGEncoder();   
			
			var pngStream:ByteArray = png.encode(bitmapData);   
			
			var f:File = File.desktopDirectory;   
			
			f = new File(f.resolvePath("a.png").nativePath);   f.save(pngStream,"a.png");*/  
			return mBit;
		}
		
		public static function fanse(ds:DisplayObject):void
		{
			/*
			red(dst) = red(src) * (-1) + 255。
			green(dst) = green(src) * (-1) + 255
			blue(dst) = blue(src) * (-1) + 255
			*/
			//注意BlendMode的使用造成的计算影响;
			var _myColorTransform:ColorTransform = new ColorTransform();
			_myColorTransform.redMultiplier = -1;
			_myColorTransform.greenMultiplier =-1;
			_myColorTransform.blueMultiplier = -1;
			_myColorTransform.redOffset = 255;
			_myColorTransform.greenOffset = 255;
			_myColorTransform.blueOffset = 255;
			ds.transform.colorTransform = _myColorTransform;
		}
	}
}