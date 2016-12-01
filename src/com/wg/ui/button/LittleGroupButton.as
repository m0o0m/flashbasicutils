package com.wg.ui.button
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 *mc制作的时候 ,将一组按钮包含在一个sprite中;
	 * @author Administrator
	 * 
	 */
	public class LittleGroupButton extends LittleButton
	{
		/**
		 *保存此按钮属于的组名称 ,或是此按钮的id
		 */
		public var groupId:String = "";
		public function LittleGroupButton(con:MovieClip, tit:String)
		{
			super(con, tit);
		}
		
		override public function init():void
		{
			super.init();
			//判断第一次登陆状态;
			/*if(isfirstShow)
			{
				changeState(LittleButton.ALREADYCLICK);
			}else
			{
				changeState(LittleButton.UNCLICK);
			}*/
			ButtonGroupManger.instance.addBtn(this);
		}
		override protected function mouseUpHandler(event:MouseEvent):void
		{
			if(isClick&&clickFunc is Function&&state == LittleButton.UNCLICK)
			{
				isClick = false;
				clickFunc(this);
			}
			ButtonGroupManger.instance.changeState(this);
			
			//统一在管理类中调用super();
//			super.mouseUpHandler(event);
			
		}
		override public function dispose():void
		{
			ButtonGroupManger.instance.removeBtn(this);
			super.dispose();
		}
	}
}