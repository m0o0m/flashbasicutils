package views.lvjing.yanhua3  {	
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

	[SWF(backgroundColor="#000000")]
	/**
	 *处理单个粒子的特效 
	 */
	public class Fireworks3 extends AbstractLvjing {				
	
		//存储烟花粒子的数组
		private var _fireworks_arr:Array;
		
		//生成烟花效果所使用的BitmapData
		private var _fireworks_bd:BitmapData;
		
		//显示BitmapData的位图
		private var _fireworks_bm:Bitmap;
		
		//将高手写的模糊滤镜先抄过来
		private var cf:ConvolutionFilter = new ConvolutionFilter(3, 3, [1, 1, 1, 1, 32, 1, 1, 1, 1],41.8,0);
		
		private var _lastBound:Rectangle;
		
		//检查部分耗性能的行为是否需要进行的Timer
		private var _check_timer:Timer;
		
		//是否需要应用模糊滤镜
		private var _needToUseBlur:Boolean;
		
		private var _needToUseGlow:Boolean;
		
		public function Fireworks3(con:MovieClip) {
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
		private function init():void{
			//初始化位图
			_fireworks_bd = new BitmapData(FWConstants.STAGE_BMP_WIDTH, FWConstants.STAGE_BMP_HEIGHT, false, 0x000000);
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
			_needToUseBlur = true;
		}
		private function enterFrameHandler(event:Event):void
		{
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
			var _thisBound:Rectangle = _fireworks_bd.getColorBoundsRect(0xFFFFFF, 0x000000, false)
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
			//为每朵烟花设置随机颜色（方式：全随机）
			var _colors:Array = [Math.random() * 0xFFFFFF, Math.random() * 0xFFFFFF, Math.random() * 0xFFFFFF];
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
								//将白色粒子的出现概率降低至10%
								_particle.color = (Math.random() > 0.9) ? 0xFFFFFF : color;
								//将粒子属性同步到BitmapData中
								syncParticleToBitmapData(_particle);
								//初始化物理学变量：初速度，用三角函数算出两个方向上的分量（这次速度调小，并且带随机的因子）
								_particle.speedX = 3 * Math.random() * Math.cos(_particle.rotation * Math.PI / 180);
								_particle.speedY = 3 * Math.random() * Math.sin(_particle.rotation * Math.PI / 180);
								//初始化物理学变量：向下的加速度（重力加速度）(这次调小点）
								_particle.accelerationY = 0.032;
								//去掉单个粒子的监听代码，取而代之的是将粒子添加到数组，在enterFrame中统一控制
								//由于没有了MovieClip，所以Object里原有的mc属性删除
								_fireworks_arr.push({particle: _particle});
						   }, 100 * int(i / 100), _colors[int(Math.random() * 3)]);
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
			//控制粒子颜色的随机数
			var _randomNumber:Number = Math.random();
			if(_randomNumber > 2 / 3)
			{
				//1/3的概率按原颜色显示
				//取得当前位置的点的颜色，然后用Screen混合模式的公式算得新值
				var _centerColor:uint = _fireworks_bd.getPixel(_centerX, _centerY);
				_fireworks_bd.setPixel(_centerX, _centerY, BlendModeUtil.getScreenColor(_centerColor, _color));
				//下面四句代码同上
				var _centerY1Color:uint = _fireworks_bd.getPixel(_centerX, _centerY+1);
				_fireworks_bd.setPixel(_centerX, _centerY+1, Math.random() > 0.75 ? BlendModeUtil.getScreenColor(_centerY1Color, _color) : _color);
				var _centerX1Color:uint = _fireworks_bd.getPixel(_centerX+1, _centerY);
				_fireworks_bd.setPixel(_centerX+1, _centerY, Math.random() > 0.75 ? BlendModeUtil.getScreenColor(_centerX1Color, _color) : _color);
			}else if(_randomNumber > 1 / 2)
			{
				//1/3的概率显示白色（删除白色强化的部分）
				_fireworks_bd.setPixel(_centerX, _centerY, 0xFFFFFF);
				//强化效果，让白色有发光的感觉
				//_fireworks_bd.setPixel(_centerX, _centerY+1, 0xDEDEDE);
				//_fireworks_bd.setPixel(_centerX+1, _centerY, 0xDEDEDE);
			}else
			{
				//1/3的概率不设置颜色，意为变暗
			}
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
