package com.wg.mvc
{
	import com.wg.logging.Log;
	import com.wg.mvc.command.interfaces.ICommand;

    public class Controller extends ControllerBase
    {		
        public function Controller(data:Data, view:View)
        {
			super(data, view);
            return;
        }
		
		public function getSubCommand(cls:Class):ICommand
		{
			// TODO Auto Generated method stub
			if(!cls)
			{
				Log.error("传入的对像为空");
			}
			return new cls();
		}
	}
}
