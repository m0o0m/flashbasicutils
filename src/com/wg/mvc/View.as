package com.wg.mvc
{
	import com.wg.mvc.view.ViewSubBase;

	/**
	 * ...
	 * @author Jason
	 */
	public class View extends ViewBase
	{
		
		public function View()
		{
			return; 
		}
		
		public function getSubView(view:Class):ViewSubBase
		{
			return createObject(view) as ViewSubBase;
		}
		
	}
}