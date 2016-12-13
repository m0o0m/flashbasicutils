package views.lvjing.yanhua4  {	
	import com.gemei.geom.BlendModeUtil;
	import com.gemei.geom.ColorUtil;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.ConvolutionFilter;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import views.lvjing.yanhua.AbstractLvjing;
	import wg.utils.colorUtils.BlendModeUtil;
	import views.lvjing.yanhua3.particle.core.AbstractParticle;
	import flash.geom.Point;
	import views.lvjing.yanhua3.FWConstants;
	import views.lvjing.yanhua3.FireworksParticle;

	[SWF(backgroundColor="#000000")]
	/**
	 *使用多位图,分别处理位图数据;然后叠加起来 
	 */
	public class Fireworks4 extends AbstractLvjing {				
		public function Fireworks4(con:MovieClip) {
			// constructor code
			super(con);
			init();
		}		
		override public function reset():void
		{
			_con.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			//监听鼠标左键按下事件
			_con.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			_check_timer.stop();
			_check_timer.removeEventListener(TimerEvent.TIMER, checkTimerHandler);
		}
		
		//存储烟花粒子的数组
		private var _fireworks_arr:Array;
		
		//生成烟花效果所使用的BitmapData
		private var _fireworks_bd:BitmapData;
		
		//发光部分的BitmapData
		private var _glow_bd:BitmapData;
		
		//发光粒子的BitmapData
		private var _glowParticle_bds:Array;
		
		//最终显示用的BitmapData
		private var _final_bd:BitmapData;
		
		//显示BitmapData的位图
		private var _fireworks_bm:Bitmap;
		
		//将高手写的模糊滤镜先抄过来
		private var cf:ConvolutionFilter = new ConvolutionFilter(3, 3, [1, 1, 1, 1, 32, 1, 1, 1, 1],41.8,0);
		
		//场景主位图的矩形区域
		private var _main_rect:Rectangle;
		
		//色彩填充的位图区域
		private var _fillColor_rect:Rectangle;
		
		//复制粒子像素时用到的Point对象
		private var _copyParticle_point:Point;
		
		//复制粒子像素时用到的Rectangle对象
		private var _copyParticle_rect:Rectangle;
		
		//0点对象
		private var _0pt:Point;
		
		//检查部分耗性能的行为是否需要进行的Timer
		private var _check_timer:Timer;
		
		//是否需要应用模糊滤镜
		private var _needToUseBlur:Boolean;
		
		//是否需要应用发光滤镜
		private var _needToUseGlow:Boolean;
		
		private var _lastBound:Rectangle;
		
		public function Fireworks() {
			// constructor code
			init();
		}		
		/**
		 * 三张位图,
		 * _final_bd中添加_fireworks_bd和_glow_bd的数据;每单位时间刷新数据;
		 */
		private function init():void{
			//初始化主位图
			_fireworks_bd = new BitmapData(FWConstants.STAGE_BMP_WIDTH, FWConstants.STAGE_BMP_HEIGHT, false, 0x000000);
			//初始化发光部分的位图，由于在上层，所以要透明
			_glow_bd = new BitmapData(FWConstants.STAGE_BMP_WIDTH, FWConstants.STAGE_BMP_HEIGHT, true, 0x00000000);
			//初始化最终位图
			_final_bd = new BitmapData(FWConstants.STAGE_BMP_WIDTH, FWConstants.STAGE_BMP_HEIGHT, false, 0x000000);
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
			//初始化发光粒子的BitmapData，本次先分配两张
			_glowParticle_bds = [];
			//第一张，给1个像素填充75%不透明度白色，发光滤镜较弱，作为较暗的图像
			_glowParticle_bds[0] = new BitmapData(15, 15, true, 0x00000000);
			_glowParticle_bds[0].setPixel32(7, 7, 0xCCFFFFFF);
			_glowParticle_bds[0].applyFilter(_glowParticle_bds[0], _glowParticle_bds[0].rect, _glowParticle_bds[0].rect.topLeft, new GlowFilter(0xFFFFFF, 0.4));
			//第一张，给4个像素填充100%不透明度白色，发光滤镜较强，作为较亮的图像
			_glowParticle_bds[1] = new BitmapData(15, 15, true, 0x00000000);
			_glowParticle_bds[1].fillRect(new Rectangle(6, 6, 2, 2), 0xFFFFFFFF);
			_glowParticle_bds[1].applyFilter(_glowParticle_bds[1], _glowParticle_bds[1].rect, _glowParticle_bds[1].rect.topLeft, new GlowFilter(0xFFFFFF, 0.8, 6, 6, 4));
			_fireworks_bm = new Bitmap(_final_bd);
			_con.addChild(_fireworks_bm);			
			//初始化数组
			_fireworks_arr = [];
			//监听帧刷新事件
			_con.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			//监听鼠标左键按下事件
			_con.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			//初始化Timer并启动
			_check_timer = new Timer(5000);
			_check_timer.addEventListener(TimerEvent.TIMER, checkTimerHandler);
			_check_timer.start();
		}		
		private function mouseDownHandler(event:MouseEvent):void
		{
			//鼠标左键每按一次，就在当前的鼠标位置创建一朵烟花
			createFireworks(_con.mouseX, _con.mouseY);
			_needToUseGlow = _needToUseBlur = true;
		}
		private function enterFrameHandler(event:Event):void
		{
			if(!_needToUseGlow && !_needToUseBlur)
			{
				return;
			}
			//先锁定BitmapData以避免不必要的渲染损耗
			_final_bd.lock();
			//清空发光部分BitmapData重新绘制，使得原有的像素颜色不残留，发光粒子的运动显得更为干净利落
			if(_needToUseGlow && _lastBound)
			{
				_glow_bd.fillRect(_glow_bd.rect, 0x00000000);
			}
			//遍历所有的烟花粒子
			for each(var _fireworks_item:Object in _fireworks_arr)
			{
				var _particle:FireworksParticle4 = _fireworks_item.particle;
				//让粒子运动
				_particle.move();
				//将粒子属性同步到BitmapData中
				syncParticleToBitmapData(_particle);
				//是否完成了它的使命
				if(_particle.finished)
				{
					//将Object从全局数组里移除
					_fireworks_arr.splice(_fireworks_arr.indexOf(_fireworks_item), 1);
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
				//将主位图写入到最终显示的BitmapData上
				_final_bd.copyPixels(_fireworks_bd, _main_rect, _0pt);
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
			//为每朵烟花设置随机颜色（方式：全随机）
			var _colors:Array = [Math.random() * 0xFFFFFF, Math.random() * 0xFFFFFF, Math.random() * 0xFFFFFF];
			//用setTimeout错开每个小球的出现时间
			for(var i:int = 0; i < 250; i++){				
				setTimeout(function(color:uint):void
				{
					
					//创建粒子实例
					var _particle:FireworksParticle4 = new FireworksParticle4();							   
					_particle.rotation  = Math.random() * 360;
					_particle.scaleX = _particle.scaleY = Math.random() * 0.3 + 0.7;
					_particle.x = x;
					_particle.y = y;								
					//将白色粒子的出现概率降低至0%
					_particle.color = (Math.random() > 0.9) ? 0xFFFFFF : color;
					//将粒子属性同步到BitmapData中
					syncParticleToBitmapData(_particle);
					//初始化物理学变量：初速度，用三角函数算出两个方向上的分量（这次速度调小，并且带随机的因子）
					_particle.speedX = 8 * Math.random() * Math.cos(_particle.rotation * Math.PI / 180);
					_particle.speedY = 6 * Math.random() * Math.sin(_particle.rotation * Math.PI / 180);
					//初始化物理学变量：向下的加速度（重力加速度）(这次调大点）
					_particle.accelerationY = 0.4;
					//去掉单个粒子的监听代码，取而代之的是将粒子添加到数组，在Timer中统一控制
					//由于没有了MovieClip，所以Object里原有的mc属性删除
					_fireworks_arr.push({particle: _particle});
				}, 200 * int(i / 20), _colors[int(Math.random() * 3)]);
			}
		}		
		
		/**
		 * 将粒子属性同步到BitmapData上
		 * @param particle AbstractParticle 粒子对象
		 **/
		private function syncParticleToBitmapData(particle:AbstractParticle):void
		{
			//确定要绘制到BitmapData上的颜色
			var _color:uint = particle.color;
			var _centerX:Number = particle.x + Math.random() * 3;
			var _centerY:Number = particle.y + Math.random() * 3;
			//获得当前点的颜色
			var _centerColor:uint = _fireworks_bd.getPixel(_centerX, _centerY);
			//用滤色模式计算出结果色
			_color = getScreenColor(_color, _centerColor);
			/**删除原来的发光滤镜应用，改回色彩填充**/
			//用现有的Rectangle避免重复new
			_fillColor_rect.x = _centerX;
			_fillColor_rect.y = _centerY;
			_fireworks_bd.fillRect(_fillColor_rect, _color);
			//随机一个发光粒子
			var _random_bd:BitmapData = _glowParticle_bds[int(Math.random() * 2)];
			//将其绘制到发光的BitmapData上
			//用现有的Rectangle和Point避免重复new
			_copyParticle_point.x = _centerX - 7;
			_copyParticle_point.y = _centerY - 7;
			_glow_bd.copyPixels(_random_bd, _copyParticle_rect, _copyParticle_point);
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
		
		/**
		 * checkTimer运行时调度
		 *
		 **/
		private function checkTimerHandler(event:TimerEvent):void
		{
			var _len:int = _fireworks_arr.length;
			//如果粒子数量大于0，舞台必然会有粒子的存在，也就不需要再做compare这种耗性能的判断了
			if(_needToUseBlur && _len == 0 && _fireworks_bd.getColorBoundsRect(0xFFFFFF, 0x000000, false).width == 0)
			{
				//如果fireworks_bd已经跟原始位图状态一致，就不需要再用模糊滤镜了
				_needToUseBlur = false;
			}
			if(_needToUseGlow && _len == 0)
			{
				_needToUseGlow = false;
			}
		}
		
	}	
}
