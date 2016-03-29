package  mydesigndatas.logic	
{
	import mydesigndatas.base.ErrorLangBase;

	public class ErrorLang extends ErrorLangBase	
	{
		private var _uri:URI;

		public function ErrorLang(initParams:*, uri:URI)
		{
			super(initParams);
			_uri = uri;
		}
	}
}
