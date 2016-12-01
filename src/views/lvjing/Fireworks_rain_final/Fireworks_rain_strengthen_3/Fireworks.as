package  {	
	import flash.display.MovieClip;	
	import flash.utils.setTimeout;
	import flash.geom.ColorTransform;	
	import flash.filters.GlowFilter;
	import flash.filters.ConvolutionFilter;
	import flash.events.MouseEvent;
	import flash.display.BlendMode;
	import flash.events.Event;
	import com.gemei.particle.core.AbstractParticle;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.filters.BlurFilter;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.StageScaleMode;

	[SWF(backgroundColor="#000000")]
	public class Fireworks extends MovieClip {				
	
		//存储烟花粒子的数组
		private var _fireworks_arr:Array;
		
		//生成烟花效果所使用的BitmapData
		private var _fireworks_bd:BitmapData;
		
		//模糊部分的BitmapData
		private var _blur_bd:BitmapData;
		
		//发光部分的BitmapData
		private var _glow_bd:BitmapData;
		
		//发光粒子的BitmapData
		private var _glowParticle_bds:Array;
		
		//最终显示用的BitmapData
		private var _final_bd:BitmapData;
		
		//显示BitmapData的位图
		private var _fireworks_bm:Bitmap;
		
		//将高手写的模糊滤镜先抄过来
		private var cf:ConvolutionFilter = new ConvolutionFilter(3, 3, [1, 1, 1, 1, 10, 1, 1, 1, 1],20,0);
		
		//定义一个扩散比较快的模糊滤镜
		private var blur:BlurFilter = new BlurFilter(8, 8);
		
		//场景主位图的矩形区域
		private var _main_rect:Rectangle;
		
		//色彩填充的位图区域
		private var _fillColor_rect:Rectangle;
		
		//复制粒子像素时用到的Point对象
		private var _copyParticle_point:Point;
		
		//复制粒子像素时用到的Rectangle对象
		private var _copyParticle_rect:Rectangle;
		
		//检查某些耗性能的操作是否有必要进行的Timer
		private var _check_timer:Timer;
		
		//是否需要应用模糊滤镜
		private var _needToUseBlur:Boolean;
		private var _needToUseBlur2:Boolean;
		
		//是否需要加发光粒子
		private var _needToUseGlow:Boolean;
		
		//0点对象
		private var _0pt:Point;
		
		private var _lastBound:Rectangle;
		
		public function Fireworks() {
			// constructor code
			init();
		}		
		private function init():void{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			//初始化主位图
			_fireworks_bd = new BitmapData(FWConstants.STAGE_BMP_WIDTH, FWConstants.STAGE_BMP_HEIGHT, false, 0x000000);			
			//初始化发光部分的位图，由于在上层，所以要透明
			_glow_bd = new BitmapData(FWConstants.STAGE_BMP_WIDTH, FWConstants.STAGE_BMP_HEIGHT, true, 0x00000000);
			//初始化最终位图
			_final_bd = new BitmapData(FWConstants.STAGE_BMP_WIDTH, FWConstants.STAGE_BMP_HEIGHT, false, 0x000000);
			//初始化模糊部分位图
			_blur_bd = new BitmapData(FWConstants.STAGE_BMP_WIDTH, FWConstants.STAGE_BMP_HEIGHT, true, 0x000000);
			//初始化主位图的矩形区域
			_main_rect = new Rectangle(0, 0, FWConstants.STAGE_BMP_WIDTH, FWConstants.STAGE_BMP_HEIGHT);
			//初始化复制粒子像素时用到的Point对象
			_copyParticle_point = new Point();
			//色彩填充的位图区域
			_fillColor_rect = new Rectangle(0, 0, 2, 2);
			//复制粒子像素时用到的Rectangle对象（跟粒子位图的矩形区域大小相等）
			_copyParticle_rect = new Rectangle(0, 0, 15, 15);
			//0点
			_0pt = new Point();
			_fireworks_bm = new Bitmap(_final_bd);
			addChild(_fireworks_bm);			
			//初始化数组
			_fireworks_arr = [];
			//监听帧刷新事件
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			//监听鼠标左键按下事件
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			_check_timer = new Timer(5000);
			_check_timer.addEventListener(TimerEvent.TIMER, checkTimerHandler);
			_check_timer.start();
		}				
		
		private function mouseDownHandler(event:MouseEvent):void
		{
			//鼠标左键每按一次，就在当前的鼠标位置创建一朵烟花
			createFireworks(stage.mouseX, stage.mouseY);
			_needToUseBlur = _needToUseBlur2 = _needToUseGlow = true;
		}
		
		private function enterFrameHandler(event:Event):void
		{
			if(!_needToUseGlow && !_needToUseBlur && !_needToUseBlur2)
			{
				return;
			}
			//先锁定BitmapData以避免不必要的渲染损耗
			_final_bd.lock();
			//清空发光部分BitmapData重新绘制，使得原有的像素颜色不残留，发光粒子的运动显得更为干净利落
			if(_needToUseGlow)
			{
				_glow_bd.fillRect(_glow_bd.rect, 0x00000000);
			}
			//遍历所有的烟花粒子
			for each(var _particle:FireworksParticleController in _fireworks_arr)
			{
				//让粒子运动
				_particle.move();
				//是否完成了它的使命
				if(_particle.finished)
				{
					//将Object从全局数组里移除
					_fireworks_arr.splice(_fireworks_arr.indexOf(_particle), 1);
				}			
			}			
			if(_needToUseBlur)
			{
				/* 为BitmapData应用模糊滤镜，使得所有粒子都淡出到舞台上
				 * 参数说明：
				 * sourceBitmapData仍是自己，所以该参数的值跟要操作的对象一致
				 * sourceRect和destPoint分别取位图整个矩形区域和（0，0）点，意味着整个位图应用滤镜
				 * filter就用高手写的那个
				 */
				_fireworks_bd.applyFilter(_fireworks_bd, _main_rect, _0pt, cf);				
			}
			if(_needToUseBlur || _needToUseBlur2)
			{
				//将主位图写入到最终显示的BitmapData上
				_final_bd.copyPixels(_fireworks_bd, _main_rect, _0pt);
			}
			if(_needToUseBlur2)
			{
				//应用模糊滤镜
				_blur_bd.applyFilter(_blur_bd, _main_rect, _0pt, blur);
				_final_bd.copyPixels(_blur_bd, _main_rect, _0pt);
			}			
			if(_needToUseGlow)
			{
				//将发光部分的位图写入到最终显示的BitmapData上
				_final_bd.copyPixels(_glow_bd, _main_rect, _0pt);
			}
			//BitmapData操作完成，解锁
			var _thisBound:Rectangle = _final_bd.getColorBoundsRect(0xFFFFFF, 0x000000, false);
			_final_bd.unlock(_lastBound ? _thisBound.union(_lastBound) : _thisBound);
			_lastBound = _thisBound;
		}
		/**
		 * 创建一朵烟花
		 * @param x Number 烟花的x坐标
		 * @param y Number 烟花的y坐标
		 **/
		private function createFireworks(x:Number, y:Number):void
		{
			for(var i:int = 0; i < 12; i++)
			{								   
				//创建粒子实例
				var _particle:FireworksParticleController = new FireworksParticleController(_fireworks_bd, _glow_bd, _blur_bd);							   
				//稍微错开一下每个粒子的位置，以形成烟花束的感觉	
				_particle.startX = x + Math.random() * 6 - 3;
				_particle.startY = y + Math.random() * 6 - 3;
				_fireworks_arr.push(_particle);
			}

		}		
		
		private function add(bg:int, blend:int):int
		{
			return Math.min(bg + blend, 255);
		}
		
		private function screen(bg:int, blend:int):int
		{
    		//滤色混合公式
    		return 255 - (255 - bg) * (255 - blend) / 255;
		}
		
		//从本人的类库里抽取出来的东东（因为类库暂时未能发布）
		private function getScreenColor(bgColor:uint, blendColor:uint):uint
		{
    		return getBlendResultColor(bgColor, blendColor, screen);
		}
		
		//从本人的类库里抽取出来的东东（因为类库暂时未能发布）
		private function getAddColor(bgColor:uint, blendColor:uint):uint
		{
    		return getBlendResultColor(bgColor, blendColor, add);
		}
		
		//从本人的类库里抽取出来的东东（因为类库暂时未能发布）
		private function getBlendResultColor(bgColor:uint, blendColor:uint, blendFunc:Function):uint
		{
			//将通道分离出来
    		var bgR:uint = bgColor >> 16 & 0xFF;
    		var bgG:uint = bgColor >> 8 & 0xFF;
    		var bgB:uint = bgColor & 0xFF;
    		var blendR:uint = blendColor >> 16 & 0xFF;
   			var blendG:uint = blendColor >> 8 & 0xFF;
    		var blendB:uint = blendColor & 0xFF;
    		//每个通道都混合一下
    		var resultR:int = blendFunc(bgR, blendR);
    		var resultG:int = blendFunc(bgG, blendG);
    		var resultB:int = blendFunc(bgB, blendB);
    		return resultR << 16 | resultG << 8 | resultB;   
		}
		
		private function checkTimerHandler(event:TimerEvent):void
		{
			var _len:int = _fireworks_arr.length;
			if(_needToUseBlur)
			{
				if(_len == 0 && _fireworks_bd.getColorBoundsRect(0xFFFFFF, 0x000000, false).width == 0)
				{
					_needToUseBlur = false;
				}
			}
			if(_needToUseBlur2)
			{
				if(_len == 0 && _blur_bd.getColorBoundsRect(0xFFFFFFF, 0x00000000, false).width == 0)
				{
					_needToUseBlur2 = false;
				}
			}
			if(_needToUseGlow)
			{
				if(_len == 0)
				{
					_needToUseGlow = false;
				}
			}
		}		
	}	
}
