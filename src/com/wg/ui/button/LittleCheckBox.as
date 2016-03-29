package com.wg.ui.button
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class LittleCheckBox extends LittleButton
	{
		private var _isSelect:Boolean;
		public function LittleCheckBox(con:MovieClip, tit:String)
		{
			super(con, tit);
		}
		
		public function get isSelect():Boolean
		{
			return _isSelect;
		}

		public function set isSelect(value:Boolean):void
		{
			_isSelect = value;
			if(_isSelect)
			{
				this.changeState(LittleButton.ALREADYCLICK);
			}else
			{
				this.changeState(LittleButton.UNCLICK);
			}
		}

		override protected function mouseUpHandler(event:MouseEvent):void
		{
			//状态之前先变换;
			if(this.state != LittleButton.ALREADYCLICK)
			{
				_isSelect = true;
			}else
			{
				_isSelect = false;
			}
			super.mouseUpHandler(event);
		}
	}
}