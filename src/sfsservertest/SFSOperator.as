package sfsservertest
{
	import com.smartfoxserver.v2.SmartFox;
	
	import flash.display.MovieClip;

	public class SFSOperator
	{
		protected var sfs:SmartFox;
		protected var content:MovieClip;
		public function SFSOperator(_sfs:SmartFox,_content:MovieClip)
		{
			sfs = _sfs;
			content = _content;
		}
		protected function dTrace(msg:String):void
		{
			content.ta_debug.text += "-- " + msg + "\n";
		}
	}
}