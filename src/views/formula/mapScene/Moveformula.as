package views.formula.mapScene
{
	import com.wg.utils.mathUtils.MathUtil;
	
	import fl.controls.Button;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.media.Camera;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	
	public class Moveformula
	{
		private var _content:MovieClip;
		public function Moveformula(con:MovieClip)
		{
			_content = con;
			_content.addEventListener(Event.ADDED_TO_STAGE,addToStage);
		}
		
		protected function addToStage(event:Event):void
		{
			// TODO Auto-generated method stub
			_content.removeEventListener(Event.ADDED_TO_STAGE,addToStage);
//			_content.addEventListener(Event.ENTER_FRAME,enterFrameHandler);
			_content.start_btn.addEventListener(MouseEvent.CLICK,onstartHandler);
			_content.play_era.addEventListener(MouseEvent.CLICK,onmoveAeraHandler);
			_content.zhezhao_mc.x = _content.play_era.x;
			_content.zhezhao_mc.y = _content.play_era.y;
			_content.play_era.mask = _content.zhezhao_mc;
			_player  =_content.play_era.player_mc;
			_map_mc = _content.play_era.map_mc;
			_map_mc.x = 0;
			_map_mc.y= 0;
			mapGlobalPostionPoint.x = -_map_mc.x+_player.x;
			mapGlobalPostionPoint.y = -_map_mc.y+_player.y;
			_camera_area = _content.play_era;
			
			
			initAvartar();
		}
		
		private var _speed:Number;//像素/毫秒
		
		private var _startPoint:Point;//移动起始位置
		private var _endPoint:Point;//移动结束位置
		
		/**
		 * //当前帧移动的距离;
		 */
		private var _currentEFmovePoint:Point = new Point();
		private var _areadyMovePoint:Point = new Point();//从开始到现在已经移动多少距离,不是位置;
		
		private var _currentTime:Number;//运动的当前时间;
		private var _startTime:Number;//开始时间;
		private var _timequantum:Number;//每帧耗费时间;
		private var _lastEnterframeStartTime:Number;//上亿帧开始时间;
		private var _isStart:Boolean;//是否正在运动中;
		
		
		private var _player:MovieClip;
		private var _map_mc:MovieClip;
		private var _camera_area:MovieClip;
		
		
		//地图初始位置为(0,0);
		/**
		 * player在地图中的位置;
		 * 所有对象的值都有一个统一的值进行协调和计算,防止对象之间移动的不准确;
		 */
		private var mapGlobalPostionPoint:Point = new Point(0,0);
		
		
		protected function onstartHandler(event:MouseEvent = null):void
		{
			// TODO Auto-generated method stub
			var buttontext:Button;
			if(!event)
			{
				 buttontext = _content.start_btn;
			}else
			{
				buttontext = ((event.target) as Button);
			}
			
			if(buttontext.label == "开始")
			{
				buttontext.label = "结束";
				_speed = (Number(_content.speed_text.text)/1000);
				_startPoint = new Point(_player.x,_player.y);
				var temparr:Array = _content.zhongdian_text.text.split(",");
				_endPoint = new Point(temparr[0],temparr[1]);
				_lastEnterframeStartTime = _startTime = getTimer();
				_currentTime = 0;
				_content.totaltime_text.text = (Point.distance(_startPoint,_endPoint)/_speed).toFixed(2);
				//执行完后再执行enterframe
				_isStart = true;
			}else
			{
				//buttontext.label = "开始";
				//_isStart = false;
				stopMove();
			}
			
		}
		
		/**
		 *获取终点信息; 
		 * @param e
		 * globalToLocal:全局,是根容器全局;
		 * localToGlobal:
		 * 将pointParent中的点Point转换为根容器坐标;
		 * pointParent.localToGlobal(new Point(point.x,point.y)); 
		 */
		private function onmoveAeraHandler(e:MouseEvent):void
		{
			_content.addEventListener(Event.ENTER_FRAME,enterFrameHandler);
			var temppoint:Point = _content.play_era.globalToLocal(new Point(_content.stage.mouseX,_content.stage.mouseY));
//			trace(_content.stage.mouseX,_content.parent.mouseX,_content.mouseX,_content.play_era.mouseX);
			_content.zhongdian_text.text = String(temppoint.x.toFixed(2))+","+String(temppoint.y.toFixed(2));
			
			//如果正在运动中;
			if(_isStart)
			{
				stopMove();
			}
			onstartHandler();
		}
		
		protected function enterFrameHandler(event:Event):void
		{
			// TODO Auto-generated method stub
			if(!_isStart) return;
			_timequantum = getTimer() - _lastEnterframeStartTime;
			_lastEnterframeStartTime = getTimer();
			_currentTime = getTimer() - _startTime;
			
			jisuanMoveXY();
			
			refreashData();
		}
		public function get content():MovieClip
		{
			return _content;
		}
		
/*		private var _time:Timer;
		private function timerInit():void
		{
			// TODO Auto Generated method stub
			var timerepeat:int = int(Number(_content.time_text.text)*1000);
			_time = new Timer(timerepeat);
			_time.addEventListener(TimerEvent.TIMER,onTimer);
//			_time.start();
		}*/
		
/*		protected function onTimer(event:TimerEvent):void
		{
			// TODO Auto-generated method stub
			
			
		}*/
		
		private function refreashData():void
		{
			_content.time_text.text = String(_timequantum.toFixed(2));
			_content.currenttime_text.text = String(_currentTime.toFixed(2));
			
			var currentpostion:Point = jisuanXianding(_player.x + _currentEFmovePoint.x,_player.y + _currentEFmovePoint.y);
			_player.x = currentpostion.x;
			_player.y = currentpostion.y;
			
			movemap();
			
			_content.play_era.zhedang_mc.x = _map_mc.x;
			_content.play_era.zhedang_mc.y = _map_mc.y;
		}
		
		/**
		 *计算每帧移动的值;每帧时间不同,所以每帧都要运算; 
		 * @return 
		 * 
		 */
		
		private function jisuanMoveXY():void
		{
			var jiaodu:Number = Math.atan2(_endPoint.y - _startPoint.y,_endPoint.x - _startPoint.x );
			var tempx:Number  = _speed*_timequantum*Math.cos(jiaodu);
			var tempy:Number = _speed*_timequantum*Math.sin(jiaodu);
			
			_areadyMovePoint.x += tempx;
			_areadyMovePoint.y += tempy;
			
			mapGlobalPostionPoint.x += tempx;
			mapGlobalPostionPoint.y += tempy;
			
			_currentEFmovePoint.x = tempx;
			_currentEFmovePoint.y = tempy;
			//如果下一步不可移动,那么停止移动;
			if(checkkeepMove(mapGlobalPostionPoint.x,mapGlobalPostionPoint.y))
			{
				//不符合移动,减去预计算;
				mapGlobalPostionPoint.x -= tempx;
				mapGlobalPostionPoint.y -= tempy;
				stopMove();
				return;
			}
			
			
			var len:Number = Point.distance(_startPoint,_endPoint);
			var len2:Number = Math.sqrt(Math.pow(_areadyMovePoint.x,2)+Math.pow(_areadyMovePoint.y,2));
			//移动到位置;
			if(len2>len)
			{
				stopMove();
				return;
			}
		}
		
		private function stopMove():void
		{
			_content.start_btn.label = "开始";
			_isStart = false;
			
			_currentEFmovePoint.x = 0;
			_currentEFmovePoint.y = 0;
			
			_areadyMovePoint.x = 0;
			_areadyMovePoint.y = 0;
			_content.removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
		}
		
		//==============player移动区域的计算;================
		
		private var _xdStartX:int = 100;
		private var _xdStartY:int = 50;
		private var _xdStartPoint:Point = new Point(_xdStartX,_xdStartY);
		private var _xdWidth:int = 300;
		private var _xdHeight:int = 100;
		private var _cameraWidth:int = 535;
		private var _cameraHeight:int = 245;
		private var _opeaAreaArr:Array = new Array(5);
		
		/**
		 * 限定区域是动态的设定,会根据情况改变区域;
		 * 限定区域分为五块;
		 * 
		 * 1,2,3限定x
		 * 4,2,5限定y
		 * 
		 */
		private function jisuanXianding(nextX:Number,nextY:Number):Point
		{
			if(_map_mc.x>=0)//1区打开
			{
				_opeaAreaArr[0] = 1;
				_xdStartPoint.x = 0;
			}else
			{
				_opeaAreaArr[0] = 0;
				_xdStartPoint.x = _xdStartX;
			}
			
			if(_map_mc.x<= (_cameraWidth - _map_mc.width))//3区打开
			{
				_opeaAreaArr[2] = 1;
				_xdWidth = _cameraWidth - _xdStartPoint.x;
			}else
			{
				_opeaAreaArr[2] = 0;
				_xdWidth = 300;
			}
			
			if(_map_mc.y>=0)//4区打开
			{
				_opeaAreaArr[3] = 1;
				_xdStartPoint.y = 0;
			}else
			{
				_opeaAreaArr[3] = 0;
				_xdStartPoint.y = _xdStartY;
			}
			
			if(_map_mc.y<=(_cameraHeight -_map_mc.height ))//5区打开
			{
				_opeaAreaArr[4] = 1;
				_xdHeight = _cameraHeight - _xdStartPoint.y;
			}else
			{
				_opeaAreaArr[4] = 0;
				_xdHeight = 100;
			}
			
			//将限定区域限定在镜头内;
			_xdWidth = MathUtil.between(_xdWidth,0,_cameraWidth);
			_xdHeight = MathUtil.between(_xdHeight,0,_cameraHeight);
			
			
			var tempPoint:Point = new Point();
			tempPoint.x = MathUtil.between(nextX,_xdStartPoint.x,_xdStartPoint.x+_xdWidth);
			tempPoint.y = MathUtil.between(nextY,_xdStartPoint.y,_xdStartPoint.y+_xdHeight);
			
			drawBianjie();
			return tempPoint;
		}
		
		/**
		 *画出player移动区域 
		 * 
		 */
		private function drawBianjie():void
		{
			_camera_area.graphics.clear();
			_camera_area.graphics.lineStyle(1,0x000000);
			_camera_area.graphics.drawRect(_xdStartPoint.x,_xdStartPoint.y,_xdWidth,_xdHeight);
		}
		
		//==========移动地图=============
		
		
		/**
		 *只有在第二区域才会移动地图; 
		 * @return 
		 * 当从其它区域进入2区的时候,有可能出现_player位置等于边界值的情况;
		 * 可能还需要一个限定区域,防止地图被用完,出现背景图;
		 */
		private function movemap():void
		{
/*			var tempbln:Boolean = _opeaAreaArr.every(
				callback);
			
			function callback(item:*, index:int, array:Array):Boolean
			{
				if(item!=0)
				{
					return false;
				}
				return true;
			}
*///			if(tempbln)
//			{
				if(_player.x ==  _xdStartPoint.x || _player.x == (_xdStartPoint.x+_xdWidth))
				{
					_map_mc.x = -(mapGlobalPostionPoint.x - _player.x);
				}
				
				if(_player.y ==  _xdStartPoint.y || _player.y == (_xdStartPoint.y+_xdHeight))
				{
					_map_mc.y = -(mapGlobalPostionPoint.y - _player.y);
				}
				
				
			/*	if(_opeaAreaArr[0])
				{
					_map_mc.x = 0;
				}
				if(_opeaAreaArr[2])
				{
					_map_mc.x = _cameraWidth - _map_mc.width;
				}
				if(_opeaAreaArr[3])
				{
					_map_mc.y = 0;
				}
				if(_opeaAreaArr[4])
				{
					_map_mc.y = _cameraHeight - _map_mc.height;
				}*/
//			}
				moveAvartar();
		}
		//============刷新     avartar  ================

		private var _avartarlist:Vector.<MapAvartar> = new Vector.<MapAvartar>();
		private function initAvartar():void
		{
			for (var i:int = 0; i < 5; i++) 
			{
				_avartarlist[i] = new MapAvartar(_content.play_era["avartar"+i+"_mc"]);
				_avartarlist[i].x = _avartarlist[i].inMapPositionX;
				_avartarlist[i].y = _avartarlist[i].inMapPositionY;
				_content.play_era.addChild(_avartarlist[i]);
			}
			
		}
		
		/**
		 *地图元素的位置跟地图的位移是一致的; 
		 * 当地图起始位置为0,0 时,也是地图其它元素位移 的距离
		 */
		private function moveAvartar():void
		{
			for (var i:int = 0; i < _avartarlist.length; i++) 
			{
				_avartarlist[i].moveTo(_map_mc.x,_map_mc.y);
			}
		}
		
		//===============添加不可移动区域===============
		private var hitbitmapData:BitmapData;
		private function checkkeepMove(globeX:Number,globeY:Number):Boolean
		{
			if(!hitbitmapData)
			{
				hitbitmapData = new BitmapData(_content.play_era.zhedang_mc.width,_content.play_era.zhedang_mc.height,true,0xffffff);
				hitbitmapData.draw( _content.play_era.zhedang_mc);
			}
			
			if(hitbitmapData&&hitbitmapData.getPixel32(globeX,globeY))
			{
				return true;
			}
			
			return false;
		}
	}
}