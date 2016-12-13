package  wg.utils.colorUtils { 
	public class ConvertColor{ 
		/**
		 * 将RGB转为HSB
		 * @param r int 红色通道值
		 * @param g int 绿色通道值
		 * @param b int 蓝色通道值
		 * @return 一个包含h，s和b三个属性的对象（色相0~360，饱和度0~100，亮度0~100）
		 **/
		public static function RGBToHSB(r:int,g:int,b:int):Object{ 
			var hsb:Object = new Object(); 
			//HSB模式需要经常用到RGB中的最大，最小值，故先拿个变量存起来
			var max:Number = Math.max(r,g,b); 
			var min:Number = Math.min(r,g,b); 
			//饱和度和亮度的计算比较简单，按着公式来写即可
			hsb.s = (max != 0) ? (max - min) / max * 100: 0; 
			hsb.b = max / 255 * 100; 
			//h比较麻烦，要分情况，但是写起来也不算复杂
			if(hsb.s == 0){ 
				hsb.h = 0; 
			}else{ 
				switch(max){ 
					case r: 
						hsb.h = ((g - b)/(max - min)*60 + 360) % 360; 
						break; 
					case g: 
						hsb.h = (b - r)/(max - min)*60 + 120; 
						break; 
					case b: 
						hsb.h = (r - g)/(max - min)*60 + 240; 
						break; 
				} 
			}
			//这段代码拿来防止数值溢出的，实际上，只要计算的时候小心点，控制上下限的操作可有可无
			hsb.h = Math.min(360, Math.max(0, Math.round(hsb.h))) 
			hsb.s = Math.min(100, Math.max(0, Math.round(hsb.s))) 
			hsb.b = Math.min(100, Math.max(0, Math.round(hsb.b)))  
			return hsb; 
		} 
		/**
		 * 将HSB转为RGB（色相0~360，饱和度0~100，亮度0~100）
		 * @param h int 色相值
		 * @param s int 饱和度值
		 * @param b int 亮度值
		 * @return 一个包含r，g和b三个属性的对象
		 **/
		public static function HSBToRGB(h:int,s:int,b:int):Object{ 
			var rgb:Object = new Object();
			//按RGB转HSB的公式，拿到最大和最小值
			var max:Number = (b*0.01)*255; 
			var min:Number = max*(1-(s*0.01)); 
			//然后根据色相的运算方法，确定max和min值花落谁家
			if(h == 360){ 
				h = 0; 
			}
			if(s == 0){ 
				rgb.r = rgb.g = rgb.b = b*(255*0.01) ; 
			}else{ 
				var _h:Number = Math.floor(h / 60);                 
				switch(_h){ 
					case 0: 
						rgb.r = max;
						rgb.g = min+h * (max-min)/ 60; 
						rgb.b = min; 
						break; 
					case 1: 
						rgb.r = max-(h-60) * (max-min)/60; 
						rgb.g = max; 
						rgb.b = min; 
						break; 
					case 2: 
						rgb.r = min ; 
						rgb.g = max; 
						rgb.b = min+(h-120) * (max-min)/60; 
						break; 
					case 3: 
						rgb.r = min; 
						rgb.g = max-(h-180) * (max-min)/60; 
						rgb.b =max; 
						break; 
					case 4: 
						rgb.r = min+(h-240) * (max-min)/60; 
						rgb.g = min; 
						rgb.b = max; 
						break; 
					case 5: 
						rgb.r = max; 
						rgb.g = min;
						rgb.b = max-(h-300) * (max-min)/60; 
						break; 
					case 6: 
						rgb.r = max; 
						rgb.g = min+h  * (max-min)/ 60; 
						rgb.b = min; 
						break; 
				}
				//不多说了，也是防止数据溢出的代码
				rgb.r = Math.min(255, Math.max(0, Math.round(rgb.r))); 
				rgb.g = Math.min(255, Math.max(0, Math.round(rgb.g))); 
				rgb.b = Math.min(255, Math.max(0, Math.round(rgb.b))); 
			} 
			return rgb; 
		} 
		
		public static function RGBToHSL(r:int,g:int,b:int):Object
		{
			var innerR:Number = r / 255;
			var innerG:Number = g / 255;
			var innerB:Number = b / 255;
			var hsl:Object = new Object();
			var min:Number = Math.min(innerR, innerG, innerB);
			var max:Number = Math.max(innerR, innerG, innerB);
			var delta:Number = max - min;
			hsl.l = (max + min) / 2;
			if(delta == 0){
				hsl.h = 0;
				hsl.s = 0
			}else{
				if (hsl.l < 0.5 ){
					hsl.s = delta / (max + min);
				}else{
					hsl.s = delta / ( 2 - max - min);
				}				
				if(hsl.s == 0){ 
					hsl.h = 0; 
				}else{ 
					switch(max){ 
						case innerR: 
							hsl.h = ((innerG - innerB)/(max - min) * 60 + 360) % 360; 
							break;
						case innerG: 
							hsl.h = (innerB - innerR)/(max - min) * 60 + 120; 
							break; 
						case innerB: 
							hsl.h = (innerR - innerG)/(max - min) * 60 + 240; 
							break; 
					} 
				}
			}
			hsl.l *= 100;
			hsl.s *= 100;
			return hsl;
		}		
		
		/**
		 * 将HSL转为RGB(h=0~360,s=0~100,l=0~100)
		 * 
		 **/
		public static function HSLToRGB(h:int, s:int, l:int):Object{
			var rgb:Object = new Object();
			var innerH:Number = h / 360;
			var innerS:Number = s / 100;
			var innerL:Number = l /100;	
			if ( s == 0 ){
				rgb.r = innerL * 255; 
				rgb.g = innerL * 255;
				rgb.b = innerL * 255;
			}else{
				var var2:Number;
				if ( innerL < 0.5 ){
					var2 = innerL * ( 1 + innerS );
				}else{
					var2 = ( innerL + innerS ) - ( innerS * innerL );
				}
				var var1:Number = 2 * innerL - var2;
				rgb.r = 255 * HueToRGB( var1, var2, innerH + ( 1 / 3 ) ) ;
				rgb.g = 255 * HueToRGB( var1, var2, innerH );
				rgb.b = 255 * HueToRGB( var1, var2, innerH - ( 1 / 3 ) );	
			}
			return rgb;
		}
		
		private static function HueToRGB( v1:Number, v2:Number, vH:Number):Number{
			if ( vH < 0 ) vH += 1;
			if ( vH > 1 ) vH -= 1;
			if ( ( 6 * vH ) < 1 ) return ( v1 + ( v2 - v1 ) * 6 * vH );
			if ( ( 2 * vH ) < 1 ) return ( v2 );
			if ( ( 3 * vH ) < 2 ) return ( v1 + ( v2 - v1 ) * ( ( 2 / 3 ) - vH ) * 6 );
			return ( v1 )
		}	
	} 
}
