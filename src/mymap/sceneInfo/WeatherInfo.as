package mymap.sceneInfo
{
	import com.wg.scene.utils.GameMathUtil;

	public class WeatherInfo
	{
		public var type:int;//0 晴天 1 雨天 2雪天
		public var proba:int;//天气概率 0-100
		public var dark:int;//dark：0-100
		
		public var hasWeatherChanged:Boolean = false;
		public var hasWeather:Boolean = false;
		
		public function updateWeather():void
		{
			var result:Boolean = GameMathUtil.randomTrueByProbability(proba * 0.5 * 0.01);
			hasWeatherChanged = hasWeather != result;
			hasWeather = result;
		}
	}
}