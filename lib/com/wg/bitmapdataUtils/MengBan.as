package com.wg.bitmapdataUtils
{
	import flash.display.MovieClip;
	import flash.display.*;
	import flash.geom.*;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;

	public class MengBan extends MovieClip
	{
		public function MengBan()
		{
			super();
			var butterfly:Butterfly=new Butterfly(250,240);//链接蝴蝶位图数据对象
			var butterflyMask:ButterflyMask=new ButterflyMask(250,240);//连接的蝴蝶蒙板位图数据对象
			var butterflyData:BitmapData=new BitmapData(250,240,true);//最终要显示的位图数据对象
			var butterflyShow:Bitmap=new Bitmap(butterflyData);
			butterflyShow.x=110;
			butterflyShow.y=70;
			var bgShow:Bitmap=new Bitmap(new BitmapData(1,1));
			var point:Point=new Point(0,0);
			var url:URLRequest=new URLRequest("背景图.jpg");//在根路径下应该要有这张图
			var loader:Loader=new Loader();//外部资源加载器
			loader.load(url);//加载
			addChild(loader);
			butterflyData.merge(butterfly,butterfly.rect,point,255,255,255,0);//将蝴蝶位图数据拷贝到目标位图数据
			butterfly.dispose();//释放内存
			//蒙版的蓝色通道数据拷贝到目标位图数据的Alpha通道作为透明度使用
			/*
			 *蒙版素材中,蝴蝶形状为白色,其余区域为黑色,白色由红蓝绿三通道纯正颜色(1:1:1)组成;黑色为(0:0:0)
			提取蓝色为目标对象的alhpa的值,那么alhpa为1的像素显示出来,为0的则不显示,最终形成遮罩的效果;
			
			*/
			butterflyData.copyChannel(butterflyMask,butterflyData.rect,point,BitmapDataChannel.BLUE,BitmapDataChannel.ALPHA);
			//butterflyMask.dispose();//释放内存
			addChild(butterflyShow);
			function openFileError(evt:IOErrorEvent):void {
				trace("打开文件错误，请检查文件是否存在");
			}
			loader.addEventListener(IOErrorEvent.IO_ERROR,openFileError);
		}
		
		
	}
}
import flash.display.BitmapData;

class Butterfly extends BitmapData
{
	public function Butterfly(width:int,height:int)
	{
		super(width,height);
	}
}

class ButterflyMask extends BitmapData
{
	public function ButterflyMask(width:int,height:int)
	{
		super(width,height);
	}
}