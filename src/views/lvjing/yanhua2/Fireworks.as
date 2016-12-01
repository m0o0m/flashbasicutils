package views.lvjing.yanhua2  {	
	import com.gemei.particle.core.AbstractParticle;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.ConvolutionFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import views.lvjing.yanhua.AbstractLvjing;

	[SWF(backgroundColor="#000000")]
	public class Fireworks extends AbstractLvjing {				
	
		//存储烟花粒子的数组
		private var _fireworks_arr:Array;
		
		//生成烟花效果所使用的BitmapData
		private var _fireworks_bd:BitmapData;
		
		//显示BitmapData的位图
		private var _fireworks_bm:Bitmap;
		
		//将高手写的模糊滤镜先抄过来
		private var cf:ConvolutionFilter = new ConvolutionFilter(3, 3, [1, 1, 1, 1, 32, 1, 1, 1, 1],41.8,0);
		
		//空白的BitmapData（用于比较）
		private var _empty_bd:BitmapData;
		
		//检查部分耗性能的行为是否需要进行的Timer
		private var _check_timer:Timer;
		
		//是否需要应用模糊滤镜
		private var _needToUseBlur:Boolean;
		
		private var _lastBound:Rectangle;
		
		public function Fireworks(con:MovieClip) {
			// constructor code
			super(con);
			init();
		}		
		private function init():void{
			//初始化位图
			_fireworks_bd = new BitmapData(FWConstants.STAGE_BMP_WIDTH, FWConstants.STAGE_BMP_HEIGHT, false, 0x000000);
			//获得原始fireworks_bd的副本
			_empty_bd = _fireworks_bd.clone();
			_fireworks_bm = new Bitmap(_fireworks_bd);
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
			//创建了粒子，自然要开始使用模糊
			_needToUseBlur = true;
		}
		private function enterFrameHandler(event:Event):void
		{
			//如果不需要用模糊操作，就意味着舞台不存在粒子，也就不用再渲染画面了。
			if(!_needToUseBlur)
			{
				return;
			}
			//先锁定BitmapData以避免不必要的渲染损耗
			_fireworks_bd.lock();
			//遍历所有的烟花粒子
			for each(var _fireworks_item:Object in _fireworks_arr)
			{
				var _fireworks_mc:MovieClip = _fireworks_item.mc;
				var _particle:FireworksParticle = _fireworks_item.particle;
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
			/* 为BitmapData应用模糊滤镜，使得所有粒子都淡出到舞台上
			 * 参数说明：
			 * sourceBitmapData仍是自己，所以该参数的值跟要操作的对象一致
			 * sourceRect和destPoint分别取位图整个矩形区域和（0，0）点，意味着整个位图应用滤镜
			 * filter就用高手写的那个
			 */
			_fireworks_bd.applyFilter(_fireworks_bd, _fireworks_bd.rect, _fireworks_bd.rect.topLeft, cf);
			//BitmapData操作完成，解锁
			var _thisBound:Rectangle = _fireworks_bd.getColorBoundsRect(0xFFFFFF, 0x000000, false);
			_fireworks_bd.unlock(_lastBound ? _thisBound.union(_lastBound) : _thisBound);
			_lastBound = _thisBound;
		}
		/**
		 * 创建一朵烟花
		 * @param x Number 烟花的x坐标
		 * @param y Number 烟花的y坐标
		 **/
		private function createFireworks(x:Number, y:Number):void
		{
			//为每朵烟花设置随机颜色（方式：60%的概率全随机，40%的概率白色）
			var _color:uint = Math.random() * 0xFFFFFF;
			//用setTimeout错开每个小球的出现时间
			for(var i:int = 0; i < 500; i++){				
				setTimeout(function(color:uint):void
						   {
							   
							   //创建粒子实例
							   var _particle:FireworksParticle = new FireworksParticle();							   
								_particle.rotation  = Math.random() * 360;
								_particle.scaleX = _particle.scaleY = Math.random() * 0.3 + 0.7;
								_particle.x = x;
								_particle.y = y;								
								
								_particle.color = (Math.random() > 0.6) ? 0xFFFFFF : color;
								//将粒子属性同步到BitmapData中
								syncParticleToBitmapData(_particle);
								//初始化物理学变量：初速度，用三角函数算出两个方向上的分量（这次速度调小，并且带随机的因子）
								_particle.speedX = 6 * Math.random() * Math.cos(_particle.rotation * Math.PI / 180);
								_particle.speedY = 6 * Math.random() * Math.sin(_particle.rotation * Math.PI / 180);
								//初始化物理学变量：向下的加速度（重力加速度）(这次调小点）
								_particle.accelerationY = 0.2;
								//去掉单个粒子的监听代码，取而代之的是将粒子添加到数组，在enterFrame中统一控制
								//由于没有了MovieClip，所以Object里原有的mc属性删除
								_fireworks_arr.push({particle: _particle});
						   }, 100 * int(i / 100), _color);
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
			//学高手的代码，先在粒子的（x，y）坐标上为一个像素点设置颜色
			_fireworks_bd.setPixel(_centerX, _centerY, _color);
			
		}
		
		/**
		 * checkTimer运行时调度
		 *
		 **/
		private function checkTimerHandler(event:TimerEvent):void
		{
			var _len:int = _fireworks_arr.length;
			//如果粒子数量大于0，舞台必然会有粒子的存在，也就不需要再做compare这种耗性能的判断了
			if(_needToUseBlur && _len == 0 && _fireworks_bd.compare(_empty_bd) == 0)
			{
				//如果fireworks_bd已经跟原始位图状态一致，就不需要再用模糊滤镜了
				_needToUseBlur = false;
			}
		}
		
		override public function reset():void
		{
			_con.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			//监听鼠标左键按下事件
			_con.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			_check_timer.stop();
			_check_timer.removeEventListener(TimerEvent.TIMER, checkTimerHandler);
		}
	}	
}
