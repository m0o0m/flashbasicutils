package  views.lvjing.yanhua3.geom
{

	public class BlendModeUtil
	{
		
		/**
		 * 正常算法  
		 */
		public static function normal(bg:int, blend:int):uint
		{
			return blend;
		}
		
		/**
		 * 正片叠底算法 
		 */
		public static function multiply(bg:int, blend:int):uint
		{
			return bg * blend / 255;
		}
		
		/**
		 * 颜色加深算法 
		 */
		public static function colorBurn(bg:int, blend:int):uint
		{
			return Math.max(0, bg - (255 - blend) * (255 - bg) / blend);
		}
		
		/**
		 * 线性加深算法 
		 */
		public static function linearBurn(bg:int, blend:int):uint
		{
			return bg + blend - 255;
		}
		
		/**
		 * 滤色算法 
		 * 
		 */
		public static function screen(bg:int, blend:int):uint
		{
			return 255 - (255 - bg) * (255 - blend) / 255;
		}
		
		/**
		 * 变亮算法 
		 * 
		 */
		public static function lighten(bg:int, blend:int):uint
		{
			return Math.max(bg, blend);
		}
		
		/**
		 * 变暗算法 
		 * 
		 */
		public static function darken(bg:int, blend:int):uint
		{
			return Math.min(bg, blend);
		}
		
		/**
		 * 增加算法（线性减淡） 
		 * 
		 */
		public static function add(bg:int, blend:int):uint
		{
			return Math.min(bg + blend, 255);
		}
		
		/**
		 * 减去算法
		 * 
		 */
		public static function subtract(bg:int, blend:int):uint
		{
			return Math.max(bg + blend, 0);
		}
		
		/**
		 * 叠加算法
		 * 
		 */
		public static function overlay(bg:int, blend:int):uint
		{
			if(bg < 128)
			{
				return bg * blend / 128;
			}else
			{			
				return (255 - blend) * (255 - bg) / 128;
			}
		}
		
		/**
		 * 柔光算法
		 * 
		 */
		public static function softLight(bg:int, blend:int):uint
		{
			//当混合色R<128，结果R=基色R+(2*混合色R-255)*(基色R-基色R*基色R/255)/255，
			if(blend < 128)
			{
				return bg + (2 * blend - 255) * (bg - bg * bg / 255) / 255;
			}else//当混合色R>=128，结果R=基色R+(2*混合色R-255)*(sqrt(基色R/255)*255-基色R)/255。
			{			
				return bg + (2 * blend - 255) * (Math.sqrt(bg / 255) * 255 - bg) / 255;
			}
		}
		
		/**
		 * 强光算法 
		 * 
		 */
		public static function hardLight(bg:int, blend:int):uint
		{
			if(blend < 128)
			{
				return bg * blend / 128;
			}else
			{			
				return (255 - blend) * (255 - bg) / 128;
			}
		}
		
		/**
		 * 亮光算法 
		 * 
		 */
		public static function vividLight(bg:int, blend:int):uint
		{
			if(blend < 128)
			{
				return 255 - (255 - bg) / (2 * blend) * 255;
			}else
			{			
				return bg / (2 * (255 - blend)) * 255;
			}
		}
		
		/**
		 * 线性光算法 
		 * 
		 */
		public static function linearLight(bg:int, blend:int):uint
		{
			return Math.max(0, Math.min(255, 2 * blend + bg - 255));
		}
		
		/**
		 * 点光算法 
		 * 
		 */
		public static function pinLight(bg:int, blend:int):uint
		{
			if(bg < 2 * blend - 255)
			{
				return 2 * blend - 255;
			}else if(bg < 2 * blend)
			{
				return bg;
			}else
			{
				return Math.min(255, 2 * blend);
			}
		}
		
		/**
		 * 颜色减淡算法 
		 * 
		 */
		public static function colorDodge(bg:int, blend:int):uint
		{
			return Math.min(255, bg / (255 - blend) * 255);
		}
		
		/**
		 * 实色混合算法 
		 * 
		 */
		public static function hardMix(bg:int, blend:int):uint
		{
			if(bg + blend < 255)
			{
				return 0;
			}else
			{
				return 255;
			}
		}
		
		/**
		 * 差值算法 
		 * 
		 */
		public static function difference(bg:int, blend:int):uint
		{
			var diff:int = bg - blend
			return diff < 0 ? -diff : diff;
		}
		
		/**
		 * 排除算法 
		 * 
		 */
		public static function exclusion(bg:int, blend:int):uint
		{
			return Math.max(0, Math.min(255, (bg + blend) - bg * blend / 128));
		}
		
		/**
		 * 划分算法 
		 * 
		 */
		public static function divide(bg:int, blend:int):uint
		{
			return Math.max(0, Math.min(255, blend / bg * 255));
		}
		
		/**
		 * 溶解模式（DISSOLVE）
		 *
		 **/
		public static function getDissolveColor(bgColor:uint, blendColor:uint):uint
		{
			//无透明通道时，效果与normal一致
			return getNormalColor(bgColor, blendColor);
		}
		
		/**
		 * 溶解模式（含透明通道）（DISSOLVE）
		 *
		 **/
		public static function getDissolveColor32(bgColor:uint, blendColor:uint):uint
		{			
			//全透明色不进行混合
			if(blendColor > 0)
			{
				//alpha等于显示混合色的概率
				var blendPossibility:Number = (blendColor >> 24 & 0xFF) / 0xFF;
				var rand:Number = Math.random();
				//分块随机
				if(rand < blendPossibility)
				{
					//因为alpha失效，所以要给混合色的alpha通道设置为最大值，即全不透明
					return 0xFF000000 | blendColor;
				}else
				{
					return bgColor;
				}
			}else
			{
				return bgColor;
			}
		}
		
		/**
		 * 正常模式（NORMAL）
		 *
		 **/
		public static function getNormalColor(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor(bgColor, blendColor, normal);
		}
		
		/**
		 * 正常模式（含透明通道）（NORMAL）
		 *
		 **/
		public static function getNormalColor32(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor32(bgColor, blendColor, normal);
		}
		
		/**
		 * 变暗模式（MULTIPLY）
		 *
		 **/
		public static function getDarkenColor(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor(bgColor, blendColor, darken);
		}
		
		
		/**
		 * 变暗叠底模式（含透明通道）（MULTIPLY）
		 *
		 **/
		public static function getDarkenColor32(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor32(bgColor, blendColor, darken);
		}
		
		/**
		 * 正片叠底模式（MULTIPLY）
		 *
		 **/
		public static function getMultiplyColor(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor(bgColor, blendColor, multiply);
		}
	
		
		/**
		 * 正片叠底模式（含透明通道）（MULTIPLY）
		 *
		 **/
		public static function getMultiplyColor32(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor32(bgColor, blendColor, multiply);
		}
		
		/**
		 * 颜色加深模式（COLOR BURN）
		 *
		 **/
		public static function getColorBurnColor(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor(bgColor, blendColor, colorBurn);
		}
		
		
		/**
		 * 颜色加深模式（含透明通道）（COLOR BURN）
		 *
		 **/
		public static function getColorBurnColor32(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor32(bgColor, blendColor, colorBurn);
		}
		
		/**
		 * 线性加深模式（LINEAR BURN）
		 *
		 **/
		public static function getLinearBurnColor(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor(bgColor, blendColor, linearBurn);
		}				
		
		/**
		 * 线性加深模式（含透明通道）（LINEAR BURN）
		 *
		 **/
		public static function getLinearBurnColor32(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor32(bgColor, blendColor, linearBurn);
		}		
		
		/**
		 * 深色模式（DARKER COLOR）
		 *
		 **/
		public static function getDarkerColorColor(bgColor:uint, blendColor:uint):uint
		{
			var bgR:int = (bgColor >> 16) & 0xFF;
			var bgG:int = (bgColor >> 8) & 0xFF;
			var bgB:int = bgColor & 0xFF;
			var blendR:int = (blendColor >> 16) & 0xFF;
			var blendG:int = (blendColor >> 8) & 0xFF;
			var blendB:int = blendColor & 0xFF;
			if(bgR + bgG + bgB >= blendR + blendG + blendB)
			{
				return blendColor;
			}else
			{
				return bgColor;
			}
		}
		
		/**
		 * 深色模式（含透明通道）（ DARKER COLOR）
		 *
		 **/
		public static function getDarkerColorColor32(bgColor:uint, blendColor:uint):uint
		{
			var color:uint = getDarkenColor(bgColor, blendColor);
			return getBlendResultColor32(bgColor, blendColor, normal);
		}
		
		/**
		 * 滤色模式（SCREEN）
		 *
		 **/
		public static function getScreenColor(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor(bgColor, blendColor, screen);
		}
		
		/**
		 * 滤色模式（SCREEN）
		 *
		 **/
		public static function getScreenColor32(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor32(bgColor, blendColor, screen);
		}
		
		/**
		 * 增加（线性减淡）模式（ADD）
		 *
		 **/
		public static function getAddColor(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor(bgColor, blendColor, add);
		}
		
		/**
		 * 增加（线性减淡）模式（ADD）
		 *
		 **/
		public static function getAddColor32(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor32(bgColor, blendColor, add);
		}
		
		/**
		 * 减去模式（SUBTRACT）
		 *
		 **/
		public static function getSubtractColor(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor(bgColor, blendColor, subtract);
		}
		
		/**
		 * 减去模式（SUBTRACT）
		 *
		 **/
		public static function getSubtractColor32(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor32(bgColor, blendColor, subtract);
		}
		
		/**
		 * 加亮模式（LIGHTEN）
		 *
		 **/
		public static function getLightenColor(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor(bgColor, blendColor, lighten);
		}
		
		/**
		 * 加亮模式（LIGHTEN）
		 *
		 **/
		public static function getLightenColor32(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor32(bgColor, blendColor, lighten);
		}
		
		/**
		 * 叠加模式（OVERLAY）
		 *
		 **/
		public static function getOverlayColor(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor(bgColor, blendColor, overlay);
		}
		
		/**
		 * 叠加模式（OVERLAY）
		 *
		 **/
		public static function getOverlayColor32(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor32(bgColor, blendColor, overlay);
		}
		
		/**
		 * 柔光模式（SOFTLIGHT）
		 *
		 **/
		public static function getSoftLightColor(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor(bgColor, blendColor, softLight);
		}
		
		/**
		 * 柔光模式（SOFTLIGHT）
		 *
		 **/
		public static function getSoftLightColor32(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor32(bgColor, blendColor, softLight);
		}
		
		/**
		 * 强光模式（HARDLIGHT）
		 *
		 **/
		public static function getHardLightColor(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor(bgColor, blendColor, hardLight);
		}
		
		/**
		 * 强光模式（HARDLIGHT）
		 *
		 **/
		public static function getHardLightColor32(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor32(bgColor, blendColor, hardLight);
		}
		
		/**
		 * 亮光模式（VIVID_LIGHT）
		 *
		 **/
		public static function getVividLightColor(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor(bgColor, blendColor, vividLight);
		}
		
		/**
		 * 亮光模式（VIVID_LIGHT）
		 *
		 **/
		public static function getVividLightColor32(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor32(bgColor, blendColor, vividLight);
		}
		
		/**
		 * 线性光模式（LINEAR_LIGHT）
		 *
		 **/
		public static function getLinearLightColor(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor(bgColor, blendColor, linearLight);
		}
		
		/**
		 * 线性光模式（LINEAR_LIGHT）
		 *
		 **/
		public static function getLinearLightColor32(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor32(bgColor, blendColor, linearLight);
		}
		
		/**
		 * 点光模式（PIN_LIGHT）
		 *
		 **/
		public static function getPinLightColor(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor(bgColor, blendColor, pinLight);
		}
		
		/**
		 * 点光模式（PIN_LIGHT）
		 *
		 **/
		public static function getPinLightColor32(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor32(bgColor, blendColor, pinLight);
		}
		
		/**
		 * 实色混合模式（HARD_MIX）
		 *
		 **/
		public static function getHardMixColor(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor(bgColor, blendColor, hardMix);
		}
		
		/**
		 * 实色混合模式（HARD_MIX）
		 *
		 **/
		public static function getHardMixColor32(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor32(bgColor, blendColor, hardMix);
		}		
		
		/**
		 * 颜色减淡模式（COLOR_DODGE）
		 *
		 **/
		public static function getColorDodgeColor(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor(bgColor, blendColor, colorDodge);
		}
		
		/**
		 * 颜色减淡模式（COLOR_DODGE）
		 *
		 **/
		public static function getColorDodgeColor32(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor32(bgColor, blendColor, colorDodge);
		}
		
		/**
		 * 浅色模式（LIGHTER COLOR）
		 *
		 **/
		public static function getLighterColorColor(bgColor:uint, blendColor:uint):uint
		{
			var bgR:int = (bgColor >> 16) & 0xFF;
			var bgG:int = (bgColor >> 8) & 0xFF;
			var bgB:int = bgColor & 0xFF;
			var blendR:int = (blendColor >> 16) & 0xFF;
			var blendG:int = (blendColor >> 8) & 0xFF;
			var blendB:int = blendColor & 0xFF;
			if(bgR + bgG + bgB < blendR + blendG + blendB)
			{
				return blendColor;
			}else
			{
				return bgColor;
			}
		}
		
		/**
		 * 浅色模式（含透明通道）（ LIGHTER COLOR）
		 *
		 **/
		public static function getLighterColor32(bgColor:uint, blendColor:uint):uint
		{
			var color:uint = getDarkenColor(bgColor, blendColor);
			return getBlendResultColor32(bgColor, blendColor, normal);
		}
		
		/**
		 * 差值模式（DIFFERENCE）
		 *
		 **/
		public static function getDifferenceColor(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor(bgColor, blendColor, difference);
		}
		
		/**
		 * 差值模式（含透明通道）（ DIFFERENCE）
		 *
		 **/
		public static function getDifferenceColor32(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor(bgColor, blendColor, difference);
		}
		
		/**
		 * 排除模式（EXCLUSION）
		 *
		 **/
		public static function getExclusionColor(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor(bgColor, blendColor, exclusion);
		}
		
		/**
		 * 排除模式（含透明通道）（ EXCLUSION）
		 *
		 **/
		public static function getExclusionColor32(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor(bgColor, blendColor, exclusion);
		}
		
		/**
		 * 划分模式（DIVIDE）
		 *
		 **/
		public static function getDivideColor(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor(bgColor, blendColor, divide);
		}
		
		/**
		 * 划分模式（含透明通道）（ DIVIDE）
		 *
		 **/
		public static function getDivideColor32(bgColor:uint, blendColor:uint):uint
		{
			return getBlendResultColor(bgColor, blendColor, divide);
		}
		
		/**
		 * 颜色模式（COLOR）
		 *
		 **/
		public static function getColorColor(bgColor:uint, blendColor:uint):uint
		{
			return getExactHSBColor(bgColor, blendColor, true, true, false);
		}
		
		/**
		 * 颜色模式（COLOR）
		 *
		 **/
		public static function getColorColor32(bgColor:uint, blendColor:uint):uint
		{
			return getExactHSBColor32(bgColor, blendColor, true, true, false);
		}
		
		/**
		 * 色相模式（COLOR）
		 *
		 **/
		public static function getHueColor(bgColor:uint, blendColor:uint):uint
		{
			return getExactHSBColor(bgColor, blendColor, true, false, false);
		}
		
		/**
		 * 色相模式（COLOR）
		 *
		 **/
		public static function getHueColor32(bgColor:uint, blendColor:uint):uint
		{
			return getExactHSBColor32(bgColor, blendColor, true, false, false);
		}
		
		/**
		 * 饱和度模式（SATURATION）
		 *
		 **/
		public static function getSaturationColor(bgColor:uint, blendColor:uint):uint
		{
			return getHSBColor(bgColor, blendColor, false, true, false);
		}
		
		/**
		 * 饱和度模式（SATURATION）
		 *
		 **/
		public static function getSaturationColor32(bgColor:uint, blendColor:uint):uint
		{
			return getHSBColor32(bgColor, blendColor, false, true, false);
		}
		
		/**
		 * 明度模式（LUMOSITY）
		 *
		 **/
		public static function getLumosityColor(bgColor:uint, blendColor:uint):uint
		{
			return getExactHSBColor(bgColor, blendColor, false, false, true);
		}
		
		/**
		 * 明度模式（LUMOSITY）
		 *
		 **/
		public static function getLumosityColor32(bgColor:uint, blendColor:uint):uint
		{
			return getExactHSBColor32(bgColor, blendColor, false, false, true);
		}
		
		public static function getBlendResultColor(bgColor:uint,blendColor:uint,blendFunc:Function):uint
		{
			var bgR:int = (bgColor >> 16) & 0xFF;
			var bgG:int = (bgColor >> 8) & 0xFF;
			var bgB:int = bgColor & 0xFF;
			var blendR:int = (blendColor >> 16) & 0xFF;
			var blendG:int = (blendColor >> 8) & 0xFF;
			var blendB:int = blendColor & 0xFF;
			var resultR:int = blendFunc(bgR, blendR);
			var resultG:int = blendFunc (bgG, blendG);
			var resultB:int = blendFunc (bgB, blendB);
			return resultR << 16 | resultG << 8 | resultB; 
		}
		
		public static function getBlendResultColor32(bgColor:uint,blendColor:uint,blendFunc:Function):uint{
			var bgA:Number = (bgColor >> 24 & 0xFF) / 0xFF;
			var bgR:int = (bgColor >> 16) & 0xFF;
			var bgG:int = (bgColor >> 8) & 0xFF;
			var bgB:int = bgColor & 0xFF;
			var blendA:Number = (blendColor >> 24 & 0xFF) / 0xFF;
			var blendR:int = (blendColor >> 16) & 0xFF;
			var blendG:int = (blendColor >> 8) & 0xFF;
			var blendB:int = blendColor & 0xFF;			
			var blendResultR:int = blendFunc(bgR, blendR);
			var blendResultG:int = blendFunc(bgG, blendG);
			var blendResultB:int = blendFunc(bgB, blendB);
			var alphaResultA:Number = (1 - (1 - bgA) * (1 - blendA));
			var alphaResultR:int,alphaResultG:int,alphaResultB:int;			
			alphaResultR = (bgR * bgA * (1 - blendA) + blendResultR * blendA * bgA + blendR * blendA * (1 - bgA)) / alphaResultA;
			alphaResultG = (bgG * bgA * (1 - blendA) + blendResultG * blendA * bgA + blendG * blendA * (1 - bgA))  / alphaResultA;
			alphaResultB = (bgB * bgA * (1 - blendA) + blendResultB * blendA * bgA + blendB * blendA * (1 - bgA))  / alphaResultA;
			return (alphaResultA * 0xFF) << 24 | alphaResultR << 16 | alphaResultG << 8 | alphaResultB;
		}		
		
		/**
		 * 颜色模式（COLOR）
		 *
		 **/
		public static function getHSBColor(bgColor:uint, blendColor:uint, blendH:Boolean, blendS:Boolean, blendL:Boolean):uint
		{
			var bgR:int = (bgColor >> 16) & 0xFF;
			var bgG:int = (bgColor >> 8) & 0xFF;
			var bgB:int = bgColor & 0xFF;
			var blendR:int = (blendColor >> 16) & 0xFF;
			var blendG:int = (blendColor >> 8) & 0xFF;
			var blendB:int = blendColor & 0xFF;
			//背景色的明度和HSL数值
			var bgLum:int = (0.3086 * bgR + 0.6094 * bgG + 0.0820 * bgB) * 100 / 255;	
			var bgHSL:Object = ConvertColor.RGBToHSL(bgR, bgG, bgB);	
			//混合色的明度和HSL数值
			var blendLum:int = (0.3086 * blendR + 0.6094 * blendG + 0.0820 * blendB) * 100 / 255;	
			var blendHSL:Object = ConvertColor.RGBToHSL(blendR, blendG, blendB);	
			//根据参数确定结果色的成分
			var resultRGB:Object = ConvertColor.HSLToRGB(blendH ? blendHSL.h : bgHSL.h, blendS ? blendHSL.s : bgHSL.s, blendL ? blendLum : bgLum);
			return resultRGB.r << 16 | resultRGB.g << 8 | resultRGB.b;
		}		
		
		public static function getHSBColor32(bgColor:uint, blendColor:uint, blendH:Boolean, blendS:Boolean, blendL:Boolean):uint
		{
			var bgA:Number = ((bgColor >> 24) & 0xFF) / 0xFF;
			var bgR:int = (bgColor >> 16) & 0xFF;
			var bgG:int = (bgColor >> 8) & 0xFF;
			var bgB:int = bgColor & 0xFF;	
			var blendA:Number = ((blendColor >> 24) & 0xFF) / 0xFF;
			var blendR:int = (blendColor >> 16) & 0xFF;
			var blendG:int = (blendColor >> 8) & 0xFF;
			var blendB:int = blendColor & 0xFF;
			//背景色的明度和HSL数值
			var bgLum:int = (0.3086 * bgR + 0.6094 * bgG + 0.0820 * bgB) * 100 / 255;	
			var bgHSL:Object = ConvertColor.RGBToHSL(bgR, bgG, bgB);	
			//混合色的明度和HSL数值
			var blendLum:int = (0.3086 * blendR + 0.6094 * blendG + 0.0820 * blendB) * 100 / 255;	
			var blendHSL:Object = ConvertColor.RGBToHSL(blendR, blendG, blendB);	
			//根据参数确定结果色的成分
			var resultRGB:Object = ConvertColor.HSLToRGB(blendH ? blendHSL.h : bgHSL.h, blendS ? blendHSL.s : bgHSL.s, blendL ? blendLum : bgLum);
			var alphaResultA:Number = (1 - (1 - bgA) * (1 - blendA));	
			var blendResultR:int = resultRGB.r;
			var blendResultG:int = resultRGB.g;
			var blendResultB:int = resultRGB.b;			
			var alphaResultR:int,alphaResultG:int,alphaResultB:int;
			alphaResultR = (bgR * bgA * (1 - blendA) + blendResultR * blendA * bgA + blendR * blendA * (1 - bgA)) / alphaResultA;
			alphaResultG = (bgG * bgA * (1 - blendA) + blendResultG * blendA * bgA + blendG * blendA * (1 - bgA))  / alphaResultA;
			alphaResultB = (bgB * bgA * (1 - blendA) + blendResultB * blendA * bgA + blendB * blendA * (1 - bgA))  / alphaResultA;
			return (alphaResultA * 0xFF) << 24 | alphaResultR << 16 | alphaResultG << 8 | alphaResultB;
		}		

		public static function getExactHSBColor(bgColor:uint, blendColor:uint, blendH:Boolean, blendS:Boolean, blendL:Boolean):uint
		{
			var bgR:int = (bgColor >> 16) & 0xFF;
			var bgG:int = (bgColor >> 8) & 0xFF;
			var bgB:int = bgColor & 0xFF;	
			var blendR:int = (blendColor >> 16) & 0xFF;
			var blendG:int = (blendColor >> 8) & 0xFF;
			var blendB:int = blendColor & 0xFF;
			var lumosity:Boolean = !blendH && !blendS;
			var A:int = lumosity ? (bgR - bgB) : (blendR - blendB);
			var B:int = lumosity ? (bgG - bgB) : (blendG - blendB);
			var C:int = lumosity ? (0.299 * blendR + 0.587 * blendG + 0.114 * blendB) : (0.299 * bgR + 0.587 * bgG + 0.114 * bgB);			
			var blendResultR:int = Math.max(0, Math.min(255, 0.701 * A - 0.587 * B + C));
			var blendResultG:int = Math.max(0, Math.min(255, -0.299 * A + 0.413 * B + C));
			var blendResultB:int = Math.max(0, Math.min(255, -0.299 * A - 0.587 * B + C));
			var lumDiffer:int = C - (0.299 * blendResultR + 0.587 * blendResultG + 0.114 * blendResultB);
			var blendHSL:Object = ConvertColor.RGBToHSL(blendResultR, blendResultG, blendResultB);
			blendHSL.l = Math.max(0, Math.min(100, blendHSL.l + lumDiffer * 100 / 255));
			if(!blendS && !lumosity)
			{
				var bgHSL:Object = ConvertColor.RGBToHSL(bgR, bgG, bgB);
				blendHSL.s = bgHSL.s;
			}
			var blendRGB:Object = ConvertColor.HSLToRGB(blendHSL.h, blendHSL.s, blendHSL.l);
			blendResultR = blendRGB.r;
			blendResultG = blendRGB.g;
			blendResultB = blendRGB.b;
			return blendResultR << 16 | blendResultG << 8 | blendResultB;
		}
		
		public static function getExactHSBColor32(bgColor:uint, blendColor:uint, blendH:Boolean, blendS:Boolean, blendL:Boolean):uint
		{
			var bgA:Number = ((bgColor >> 24) & 0xFF) / 0xFF;
			var bgR:int = (bgColor >> 16) & 0xFF;
			var bgG:int = (bgColor >> 8) & 0xFF;
			var bgB:int = bgColor & 0xFF;	
			var blendA:Number = ((blendColor >> 24) & 0xFF) / 0xFF;
			var blendR:int = (blendColor >> 16) & 0xFF;
			var blendG:int = (blendColor >> 8) & 0xFF;
			var blendB:int = blendColor & 0xFF;
			var lumosity:Boolean = !blendH && !blendS;
			var A:int = lumosity ? (bgR - bgB) : (blendR - blendB);
			var B:int = lumosity ? (bgG - bgB) : (blendG - blendB);
			var C:int = lumosity ? (0.299 * blendR + 0.587 * blendG + 0.114 * blendB) : (0.299 * bgR + 0.587 * bgG + 0.114 * bgB);			
			var alphaResultA:Number = (1 - (1 - bgA) * (1 - blendA));	
			var blendResultR:int = Math.max(0, Math.min(255, 0.701 * A - 0.587 * B + C));
			var blendResultG:int = Math.max(0, Math.min(255, -0.299 * A + 0.413 * B + C));
			var blendResultB:int = Math.max(0, Math.min(255, -0.299 * A - 0.587 * B + C));
			var lumDiffer:int = C - (0.299 * blendResultR + 0.587 * blendResultG + 0.114 * blendResultB);
			var blendHSL:Object = ConvertColor.RGBToHSL(blendResultR, blendResultG, blendResultB);
			blendHSL.l = Math.max(0, Math.min(100, blendHSL.l + lumDiffer * 100 / 255));
			if(!blendS && !lumosity)
			{
				var bgHSL:Object = ConvertColor.RGBToHSL(bgR, bgG, bgB);
				blendHSL.s = bgHSL.s;
			}
			var blendRGB:Object = ConvertColor.HSLToRGB(blendHSL.h, blendHSL.s, blendHSL.l);
			blendResultR = blendRGB.r;
			blendResultG = blendRGB.g;
			blendResultB = blendRGB.b;
			var alphaResultR:int,alphaResultG:int,alphaResultB:int;
			//trace(blendResultR, blendResultG, blendResultB);
			alphaResultR = (bgR * bgA * (1 - blendA) + blendResultR * blendA * bgA + blendR * blendA * (1 - bgA)) / alphaResultA;
			alphaResultG = (bgG * bgA * (1 - blendA) + blendResultG * blendA * bgA + blendG * blendA * (1 - bgA))  / alphaResultA;
			alphaResultB = (bgB * bgA * (1 - blendA) + blendResultB * blendA * bgA + blendB * blendA * (1 - bgA))  / alphaResultA;
			return (alphaResultA * 0xFF) << 24 | alphaResultR << 16 | alphaResultG << 8 | alphaResultB;
		}
		
		public static function getBlendColorAlpha(bgColor:uint, blendColor:uint):uint
		{
			var bgAlpha:Number = ((bgColor >> 24) & 0xFF) / 255;
			var blendAlpha:Number = ((blendColor >> 24) & 0xFF) / 255;
			return getBlendAlpha(bgAlpha, blendAlpha) * 255;
		}
		
		public static function getBlendAlpha(bgAlpha:Number, blendAlpha:Number):Number
		{
			if(bgAlpha >=1 || blendAlpha >=1)
			{
				return 1;
			}
			return 1 - (1 - blendAlpha)  * (1 - bgAlpha);
		}
		
	}
}