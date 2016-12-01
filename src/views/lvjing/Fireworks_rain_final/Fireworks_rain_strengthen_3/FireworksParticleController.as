package
{
	import com.gemei.particle.core.AbstractParticleController;
	import flash.display.BitmapData;
	import com.gemei.particle.core.AbstractParticle;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;

	public class FireworksParticleController extends AbstractParticleController
	{
		
		private var _target_bd:BitmapData;
		
		private var _glow_bd:BitmapData;
		
		private var _blur_bd:BitmapData;
		
		private var _startParticles:Array;
		
		private var _bombParticles:Array;
		
		private var _currentState:int;
		
		//创建变换矩阵
		private var _matrix:Matrix;
		
		//发光粒子的缓存池
		private static var _glow_caches:Array = [];
		
		public function get currentState():int
		{
			return _currentState;
		}
		
		private const START:int = 1;
		
		private const BOMB:int = 2;
		
		override public function get particles():Array
		{
			var __particles:Array;
			switch(_currentState)
			{
				case START:
					__particles = _startParticles;
					break;
				case BOMB:
					__particles = _bombParticles;
					break;
			}
			return __particles;
		}
		
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
		
		//发光粒子的BitmapData
		private var _glowParticle_bds:Array;
		
		public function get startX():Number
		{
			return _startParticles[0].x;
		}
		
		public function set startX(value:Number):void
		{
			_startParticles[0].x = value;
		}
		
		public function get startY():Number
		{
			return _startParticles[0].x;
		}
		
		public function set startY(value:Number):void
		{
			_startParticles[0].y = value;
		}
		
		public function FireworksParticleController(target_bd:BitmapData, glow_bd:BitmapData, blur_bd:BitmapData)
		{
			// constructor code
			super();
			_target_bd = target_bd;
			_glow_bd = glow_bd;
			_blur_bd = blur_bd;
			init();
		}
		
		private function init():void
		{
			_startParticles = [];
			_bombParticles = [];
			_currentState = START;
			//初始化主位图的矩形区域
			_main_rect = new Rectangle(0, 0, FWConstants.STAGE_BMP_WIDTH, FWConstants.STAGE_BMP_HEIGHT);
			//初始化复制粒子像素时用到的Point对象
			_copyParticle_point = new Point();
			//色彩填充的位图区域
			_fillColor_rect = new Rectangle(-1, -1, 3, 3);
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
			//第二张，给4个像素填充100%不透明度白色，发光滤镜较强，作为较亮的图像
			_glowParticle_bds[1] = new BitmapData(15, 15, true, 0x00000000);
			_glowParticle_bds[1].fillRect(new Rectangle(6, 3, 1, 6), 0xFFFFFFFF);
			_glowParticle_bds[1].applyFilter(_glowParticle_bds[1], _glowParticle_bds[1].rect, _glowParticle_bds[1].rect.topLeft, new GlowFilter(0xFFFFFF, 0.5, 6, 6, 3));
			
			_startParticles = [];
			var _particle:FireworksStartParticle = new FireworksStartParticle();
			_particle.rotation  = Math.random() * 360;
			_particle.scaleX = _particle.scaleY = Math.random() * 0.3 + 0.7;
			//将白色粒子的出现概率降低至0%
			_particle.color = (Math.random() * 255) << 16 | (Math.random() * 255) << 8 | (Math.random() * 255);
			//初始化物理学变量：初速度，这里不用三角函数进行分散，随机因子的影响力也减少，以获得相对集中的烟花簇效果
			_particle.speedX = Math.random() * 2 - 1
			_particle.speedY = -6 + Math.random() * 2;
			//初始化物理学变量：向下的加速度（重力加速度）
			_particle.accelerationY = 0.2;
			_startParticles.push(_particle);
			_matrix = new Matrix();
		}
		
		private function createBombParticles():void
		{
			
		}
		
		override public function move():void
		{
			super.move();
			for each(var item:AbstractParticle in particles)
			{
				item.move();
				syncParticleToBitmapData(item);
				item.move();
				syncParticleToBitmapData(item);
				item.move();
				syncParticleToBitmapData(item);
			}
			if(_currentState == START && _startParticles[0].finished)
			{
				for(var i:int = 0; i < 18; i ++)
				{
					var _particle:FireworksParticle = new FireworksParticle();
					_particle.color = _startParticles[0].color;
					_particle.x = _startParticles[0].x;
					_particle.y = _startParticles[0].y;
					//x速度在-5~5之间随机
					_particle.speedX = 5 * (Math.random() * 2 - 1)
					//y速度反向，大小降低到原来的0~0.8倍
					_particle.speedY = -(_startParticles[0].speedY * 0.8 * Math.random());
					//重力加速度跟起始粒子一致
					_particle.accelerationY = _startParticles[0].accelerationY;
					_bombParticles.push(_particle);
				}
				_currentState = BOMB;
			}else if(_currentState == BOMB)
			{
				for each(var fireItem:AbstractParticle in _bombParticles)
				{
					if(fireItem.finished)
					{
						_bombParticles.splice(_bombParticles.indexOf(fireItem), 1);
					}
				}
			}
		}
		
		/**
		 * 是否完成了它的使命
		 *
		 **/
		override public function get finished():Boolean
		{
			return (_currentState == BOMB && _bombParticles.length == 0);
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
			var _centerColor:uint = _target_bd.getPixel(_centerX, _centerY);
			/**删除原来的发光滤镜应用，改回色彩填充**/
			//用现有的Rectangle避免重复new
			_fillColor_rect.x = _centerX;
			_fillColor_rect.y = _centerY;			
			var _blurColor:uint = _color;			
			if(_currentState == BOMB)
			{
				_blurColor = (Math.random() > 0.6) ? _blurColor : getAddColor(_blurColor, _centerColor);
			}
			//因为blurBd是透明位图，所以要添加alpha通道			
			_blur_bd.fillRect(_fillColor_rect, 0xFF000000 | _blurColor);			
			var _finalColor:uint = _color;
			//用加亮模式计算出结果色
			_finalColor = getAddColor(_finalColor, _centerColor);
			_target_bd.fillRect(_fillColor_rect, _color);
			//随机一个发光粒子
			var _random_bd:BitmapData = _glowParticle_bds[int(Math.random() * 2)];
			//将其绘制到发光的BitmapData上
			//用现有的Rectangle和Point避免重复new
			_copyParticle_point.x = _centerX - 7;
			_copyParticle_point.y = _centerY - 7;
			//根据速度的x和y方向确定旋转的角度，之所以减去PI/2，是因为粒子原始方向就是垂直的90度
			var _rotation:int = (Math.atan2(particle.speedY, particle.speedX) - Math.PI * 0.5) / Math.PI * 180
			//如果没有在缓存池找到当前角度的位图，则创建一张
			if(_glow_caches[_rotation] == undefined)
			{
				//为当前角度创建一张位图
				var _temp_bd:BitmapData = new BitmapData(15, 15, true, 0);
				//重置矩阵
				_matrix.identity();								
				//转弧度
				var _rotationRadian:Number = _rotation * Math.PI / 180;
				_matrix.rotate(_rotationRadian);			
				//为让位图绕中心点旋转，在旋转之后应平移一下
				_matrix.translate(15 * Math.SQRT1_2 * (Math.cos(Math.PI / 4) - Math.cos(Math.PI / 4 + _rotationRadian)),
								  15 * Math.SQRT1_2 * (Math.sin(Math.PI / 4) - Math.sin(Math.PI / 4 + _rotationRadian)));
				//用draw方法生成旋转的BitmapData
				_temp_bd.draw(_random_bd, _matrix);
				//放入到缓存池中
				_glow_caches[_rotation] = _temp_bd;			
			}
			//在这里再通过copyPixels函数平移
			_glow_bd.copyPixels(_glow_caches[_rotation], _copyParticle_rect, _copyParticle_point, null, null, true);
		}
		
		private function add(bg:int, blend:int):int
		{
			return Math.min(bg + blend, 255);
		}
		
		private function lighten(bg:int, blend:int):int
		{
			return bg > blend ? bg : blend;
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
		private function getLightenColor(bgColor:uint, blendColor:uint):uint
		{
    		return getBlendResultColor(bgColor, blendColor, lighten);
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
		
	}
}