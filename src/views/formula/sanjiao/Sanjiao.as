package views.formula.sanjiao
{
	import flash.display.MovieClip;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	
	public class Sanjiao
	{
		
		private var c_line_mc:MovieClip;
		private var c_line_mc2:MovieClip;
		private var c_jiaodu_txt:TextField;
		private var c_jiaodu_txt2:TextField;
		private var c_jiaodu_txt3:TextField;
		private var c_jiaodu_txt4:TextField;
		private var c_jiaodu_txt5:TextField;
		private var c_jiaodu_txt6:TextField;
		private var c_jiaodu_txt7:TextField;
		private var c_zuobiao_mc:MovieClip;
		private var c_zuobiao_mc2:MovieClip;
		private var c_line_mc3:MovieClip;
		private var c_zuobiao_mc3:MovieClip;
		private var c_zuobiao_mc4:MovieClip;
		private var _content:MovieClip;
		public function Sanjiao(con:MovieClip)
		{
			_content = con;
			_content.addEventListener(Event.ADDED_TO_STAGE,onStage);
			c_jiaodu_txt = _content.jiaodu_txt;
			c_jiaodu_txt2 = _content.jiaodu_txt2;
			c_jiaodu_txt3 = _content.jiaodu_txt3;
			c_jiaodu_txt4 = _content.jiaodu_txt4;
			c_jiaodu_txt5 = _content.jiaodu_txt5;
			c_jiaodu_txt6 = _content.jiaodu_txt6;
			c_jiaodu_txt7 = _content.jiaodu_txt7;
			c_line_mc = _content.line_mc;
			c_zuobiao_mc = _content.zuobiao_mc;
			c_line_mc2 = _content.line_mc2;
			c_zuobiao_mc2 = _content.zuobiao_mc2;
			c_line_mc3 = _content.line_mc3;
			c_zuobiao_mc3 = _content.zuobiao_mc3;
			c_zuobiao_mc4 = _content.zuobiao_mc4;
		}
		
		public function get content():MovieClip
		{
			return _content;
		}

		protected function onStage(event:Event):void
		{
			// TODO Auto-generated method stub
			_content.removeEventListener(Event.ADDED_TO_STAGE,onStage);
			init();
		}
		private function init():void
		{
			c_line_mc.x = c_zuobiao_mc.x;
			c_line_mc.y = c_zuobiao_mc.y;
			c_line_mc2.x = c_zuobiao_mc2.x;
			c_line_mc2.y = c_zuobiao_mc2.y;
			c_line_mc3.x = c_zuobiao_mc3.x;
			c_line_mc3.y = c_zuobiao_mc3.y;
			_content.stage.addEventListener(MouseEvent.CLICK,onStgeClick);
		}
		
		protected function onStgeClick(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			if(!_content.parent)
			{
				return;
			}
			if(_content.stage.hasEventListener(MouseEvent.MOUSE_MOVE))
			{
				_content.stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMoveHandler);
			}else
			{
				_content.stage.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMoveHandler);
			}
			
		}
		
		protected function onMouseMoveHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			/*
			 * 
			tan:180循环一次,atan:反正切的值也是如此,-90---90,180度循环一次;
			atan2:根据一点在坐标系中的位置,求得此点在坐标系的角度,360循环;返回值范围-180---180,等同于      返回值+360>360?返回值:返回值+360==(0---360);
			*/
			var rotation:Number = Math.atan((_content.mouseY - c_zuobiao_mc.y)/(_content.mouseX - c_zuobiao_mc.x))*(180/Math.PI);
			c_jiaodu_txt.htmlText = "c_line_mc 旋转角度/弧度:"+"<font color='#ff0000'>"+GetNumFun(rotation,2)+"/"+GetNumFun(rotation*(Math.PI/180),2)+"</font>";
			//一条线段,以一端点为坐标系原点,另一点为象限系中的一点,末尾坐标减去原点的坐标,得到一个以(0,0)坐标为原点的象限坐标系;(-180---180)
			var rotation2:Number = Math.atan2((_content.mouseY - c_zuobiao_mc.y),(_content.mouseX - c_zuobiao_mc.x));
			c_jiaodu_txt2.htmlText = "atan2计算结果 旋转角度/弧度:"+"<font color='#ff0000'>"+GetNumFun(rotation2*(180/Math.PI),2)+"/"+GetNumFun(rotation2,2)+"</font>";
			c_line_mc.rotation = rotation2*(180/Math.PI);
			c_jiaodu_txt3.htmlText = "正弦值:"+"<font color='#ff0000'>"+GetNumFun(Math.sin(rotation2),2)+"</font>";
			c_jiaodu_txt4.htmlText = "余弦值:"+"<font color='#ff0000'>"+GetNumFun(Math.cos(rotation2),2)+"</font>";
			c_jiaodu_txt5.htmlText = "正切值:"+"<font color='#ff0000'>"+GetNumFun(Math.tan(rotation2),2)+"</font>";
			c_jiaodu_txt6.htmlText = "反正切值:"+"<font color='#ff0000'>"+GetNumFun(Math.atan(Math.tan(rotation2))*180/Math.PI,2)+"</font>";
			c_jiaodu_txt7.htmlText = "正切值:"+"<font color='#ff0000'>"+GetNumFun((_content.mouseY - c_zuobiao_mc.y),2)+"/"+GetNumFun((_content.mouseX - c_zuobiao_mc.x),2)+"="+GetNumFun((_content.mouseY - c_zuobiao_mc.y)/(_content.mouseX - c_zuobiao_mc.x),2)+"</font>";
			
			tongbu2(rotation,rotation2);
			
			contact_line_Circle(rotation2);
			
			contace_line_line();
		}
		
		/**
		 *根据输入值,计算变换值的rotation; 
		 * @param r1
		 * @param r2
		 * 
		 */
		private function tongbu2(r1:Number,r2:Number):void
		{
			var result:Number = 0;
			r1 = Math.abs(r1);
			//呈现垂直角度跟随变化;
			result = r2*(180/Math.PI)+90;
			c_line_mc2.rotation = result;
			//			trace(c_line_mc2.rotation);
		}
		//		private var l_lArr:Array=new Array(); 
		private var l_ltempsprit:Sprite = new Sprite;
		private function contace_line_line():void{
			Arr = new Array();
			Arr.push({m_type:null});//0
			Arr.push({m_type:"point",m_x:c_zuobiao_mc4.x-100,m_y:c_zuobiao_mc4.y-100});//1
			Arr.push({m_type:"point",m_x:c_zuobiao_mc4.x+100,m_y:c_zuobiao_mc4.y+100});//2
			Arr.push({m_type:"point",m_x:c_zuobiao_mc4.x+60,m_y:c_zuobiao_mc4.y+80});//3
			Arr.push({m_type:"point",m_x:c_zuobiao_mc4.x+80,m_y:c_zuobiao_mc4.y+60});//4
			Arr.push({m_type:"line2",m_p1:1,m_p2:2});    //5
			Arr.push({m_type:"line2",m_p1:3,m_p2:4});    //6
			//以上是两条直线的数组表示，如何求出以上两条直线的交点坐标呢？
			//			l_ltempsprit.graphics.clear();;
			l_ltempsprit.graphics.lineStyle(1,0x00ff00);
			l_ltempsprit.graphics.moveTo(Arr[1].m_x,Arr[1].m_y);
			l_ltempsprit.graphics.lineTo(Arr[2].m_x,Arr[2].m_y);
			
			trace(Arr[2].m_x,Arr[2].m_y);
			l_ltempsprit.graphics.moveTo(Arr[3].m_x,Arr[3].m_y);
			l_ltempsprit.graphics.lineTo(Arr[4].m_x,Arr[4].m_y);
			//			l_ltempsprit.x = c_zuobiao_mc4.x;
			//			l_ltempsprit.y = c_zuobiao_mc4.y;
			_content.addChild(l_ltempsprit);
			//调用下面的函数,求编号为5，6的两直线交点。
			p_l_l(5,6);
		}
		
		/**
		 *求与半径为r的圆的交点; 
		 * 
		 */
		private var Arr:Array=new Array(); 
		private var tempsprit:Sprite = new Sprite;
		private function contact_line_Circle(r2:Number):void
		{
			c_line_mc3.rotation = r2*(180/Math.PI);
			
			
			Arr = new Array();
			Arr.push({m_type:null});//0  
			Arr.push({m_type:"point",m_x:c_zuobiao_mc3.x,m_y:c_zuobiao_mc3.y});//1  
			var temppoint:Point = c_line_mc3.localToGlobal(new Point(c_line_mc3.point2_mc.x,c_line_mc3.point2_mc.y));
			Arr.push({m_type:"point",m_x:temppoint.x,m_y:temppoint.y});//2  
			Arr.push({m_type:"line2",m_p1:1,m_p2:2});   //3  
			Arr.push({m_type:"point",m_x:c_zuobiao_mc3.x,m_y:c_zuobiao_mc3.y});//4  
			Arr.push({m_type:"point",m_x:c_zuobiao_mc3.x+50,m_y:c_zuobiao_mc3.y});//5  
			Arr.push({m_type:"circle",m_center:4,m_point:5});//6 
			
			Arr.push({m_type:"point",m_x:c_zuobiao_mc3.x-100,m_y:c_zuobiao_mc3.y+30});//7 
			Arr.push({m_type:"point",m_x:temppoint.x,m_y:temppoint.y+30});//8
			Arr.push({m_type:"line3",m_p1:7,m_p2:8});   //9  
			//以上是圆6和线3   
			tempsprit.graphics.clear();;
			tempsprit.graphics.lineStyle(1,0x00ff00);
			tempsprit.graphics.moveTo(Arr[1].m_x,Arr[1].m_y);
			tempsprit.graphics.lineTo(Arr[2].m_x,Arr[2].m_y);
			
			tempsprit.graphics.moveTo(Arr[4].m_x,Arr[4].m_y);
			
			//圆的两个控制点信息  
			
			var circle_center:Number =Arr[6].m_center;  
			var circle_point:Number =Arr[6].m_point;  
			
			var circle_center_x:Number =Arr[circle_center].m_x;  
			var circle_center_y:Number =Arr[circle_center].m_y;  
			var circle_point_x:Number =Arr[circle_point].m_x;  
			var circle_point_y:Number =Arr[circle_point].m_y; 
			var circle_radius:Number =Math.sqrt((circle_center_x-circle_point_x)*(circle_center_x-circle_point_x)+(circle_center_y-circle_point_y)*(circle_center_y-circle_point_y))  
			
			tempsprit.graphics.drawCircle(Arr[4].m_x,Arr[4].m_y,circle_radius);
			
			tempsprit.graphics.lineStyle(1,0xff0000);
			
			var arr:Array = chuizu(3,6); 
			
			for(var i:int = 0;i<arr.length;i++)
			{
				tempsprit.graphics.drawCircle(arr[i].x,arr[i].y,5);
			}
			
			tempsprit.graphics.moveTo(Arr[7].m_x,Arr[7].m_y);
			tempsprit.graphics.lineTo(Arr[8].m_x,Arr[8].m_y);
			var arr2:Array = chuizu(9,6); 
			for(var j:int = 0;j<arr2.length;j++)
			{
				tempsprit.graphics.drawCircle(arr2[j].x,arr2[j].y,5);
			}
			
			_content.addChild(tempsprit);
		}
		/**
		 *直线与圆的交点的坐标; 
		 * @param line
		 * @param circle
		 * @return 
		 * 
		 */
		private function chuizu(line:Number,circle:Number):Array{  
			
			
			//圆的两个控制点信息  
			
			var circle_center:Number =Arr[circle].m_center;  
			var circle_point:Number =Arr[circle].m_point;  
			
			var circle_center_x:Number =Arr[circle_center].m_x;  
			var circle_center_y:Number =Arr[circle_center].m_y;  
			var circle_point_x:Number =Arr[circle_point].m_x;  
			var circle_point_y:Number =Arr[circle_point].m_y;  
			
			//线的两个控制点信息  
			
			var line_p1:Number =Arr[line].m_p1;  
			var line_p2:Number =Arr[line].m_p2;  
			
			var line_p1_x:Number =Arr[line_p1].m_x;  
			var line_p1_y:Number =Arr[line_p1].m_y;  
			var line_p2_x:Number =Arr[line_p2].m_x;  
			var line_p2_y:Number =Arr[line_p2].m_y;  
			
			//线k b  
			
			var line_k:Number =(line_p2_y-line_p1_y)/(line_p2_x-line_p1_x);  
			var line_b:Number =line_p1_y-line_k*line_p1_x;  
			//半径   
			
			var circle_radius:Number =Math.sqrt((circle_center_x-circle_point_x)*(circle_center_x-circle_point_x)+(circle_center_y-circle_point_y)*(circle_center_y-circle_point_y))  
			//计算  
			var A:Number =1+line_k*line_k;  
			var B:Number =-2*circle_center_x+2*line_k*line_b-2*line_k*circle_center_y;  
			var C:Number =circle_center_x*circle_center_x+(line_b-circle_center_y)*(line_b-circle_center_y)-circle_radius*circle_radius;  
			var DELTA:Number =B*B-4*A*C;  
			var x1:Number =(-B+Math.sqrt(DELTA))/(2*A);  
			var x2:Number =(-B-Math.sqrt(DELTA))/(2*A);  
			var y1:Number =line_k*x1+line_b;  
			var y2:Number =line_k*x2+line_b;
			var arr:Array = new Array();
			
			if (DELTA>0){  
				//				trace("point1:"+x1,y1,"point2:"+x2,y2); 
				arr.push(new Point(x1,y1));
				arr.push(new Point(x2,y2));
			}else if (DELTA==0){  
				//				trace("point:"+x1,y1); 
				arr.push(new Point(x1,y1));
			}else{  
				//				trace("无交点")  
			}
			return arr;
		}  
		/**
		 *两条直线的交点 的坐标
		 * @param line1
		 * @param line2
		 * @return 
		 * 
		 */
		private function p_l_l(line1:Number,line2:Number){
			
			var line1_p1=Arr[line1].m_p1;
			var line1_p2=Arr[line1].m_p2;
			var line2_p1=Arr[line2].m_p1;
			var line2_p2=Arr[line2].m_p2;
			
			var line1_p1_x=Arr[line1_p1].m_x;
			var line1_p1_y=Arr[line1_p1].m_y;
			var line1_p2_x=Arr[line1_p2].m_x;
			var line1_p2_y=Arr[line1_p2].m_y;
			
			var line2_p1_x=Arr[line2_p1].m_x;
			var line2_p1_y=Arr[line2_p1].m_y;
			var line2_p2_x=Arr[line2_p2].m_x;
			var line2_p2_y=Arr[line2_p2].m_y;
			
			var line1_k=(line1_p1_x-line1_p2_x)/(line1_p1_y-line1_p2_y);
			var line1_b=line1_p1_y- line1_k*line1_p1_x;
			var line2_k=(line2_p1_x-line2_p2_x)/(line2_p1_y-line2_p2_y);
			var line2_b=line2_p1_y- line2_k*line2_p1_x;
			
			var node_x=(line1_b-line2_b)/(line2_k-line1_k);
			var node_y= (line2_k*line1_b-line1_k*line2_b)/(line2_k-line1_k);
			
			trace(node_x,node_y);
		}
		/**
		 *根据值画圆, 
		 * 
		 */
		private function drawCircle(radius:Number,fill:Boolean,color:Number):Sprite
		{
			var cicrlesprit:Sprite = new Sprite();
			if(fill)
			{
				cicrlesprit.graphics.beginFill(color);
			}
			cicrlesprit.graphics.lineStyle(1,color);
			cicrlesprit.graphics.drawCircle(0,0,radius);
			//			cicrlesprit.x = center.x;
			//			cicrlesprit.y = center.y;
			return cicrlesprit;
		}
		private function GetNumFun(n:Number,count:int):Number
		{
			var str:String=n.toString();
			var str2:String="";
			var isPoint:Boolean=false;
			for(var i:int=0;i<str.length;i++)
			{
				if(count>0)
				{
					str2=str2+str.charAt(i);
					if(str.charAt(i-1)==".")
					{
						isPoint=true;
					}
					if(isPoint==true)
					{
						count--;
					}
				}
			}
			return Number(str2);
		}
	}
}