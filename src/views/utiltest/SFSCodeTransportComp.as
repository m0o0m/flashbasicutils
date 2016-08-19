package views.utiltest
{
	import com.wg.utils.stringUtils.StringUtil;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class SFSCodeTransportComp
	{
		private var _content:MovieClip;
		private var dataStr:String;
		private var dataArr:Array = new Array();
		private var codeArr:Array;
		
		public function SFSCodeTransportComp(mc:MovieClip)
		{
			_content = mc;
			init();
		}
		
		private function init():void
		{
			// TODO Auto Generated method stub
			_content.start_btn.addEventListener(MouseEvent.CLICK,startClickHandler);
		}
		private function startClickHandler(e:MouseEvent):void{
			splitStr();
			transfor();
		}
		
		private function transfor():void
		{
			// TODO Auto Generated method stub
			codeArr = new Array();
			var el:CodeElement = new CodeElement();
			el.code = "SFSObject so = new SFSObject();";
			el.level = 0;
			el.codetype = "sfs_object";
			codeArr.push(el);
			for(var i:int = 0;i<dataArr.length;i++)
			{
				var el2:CodeElement = new CodeElement();
				var tempstr:String = dataArr[i]+"end";
				var objectType:String = StringUtil.getBetween(tempstr,"(",")");
				var key:String = StringUtil.getBetween(tempstr,") ",": ");
				var value:String = StringUtil.getBetween(tempstr,": ","end");//这里是object的处理方式
				if(!value) value = StringUtil.getBetween(tempstr,") ","end");//这里是数组的处理方式
				var level:int = StringUtil.strAmount(tempstr,"\t");
				el2.level = level;
				el2.key = key;
				el2.value = value;
				if(el.isParent)
				{
					el2.parent = el;
				}else
				{
					el2.parent = el.parent;
				}
				el2.codetype = objectType;
				
				el = el2;
				codeArr.push(el2);
			}
			_content.code_txt.text = codeArr.join(" ");
		}
		
		private function splitStr():void
		{
			// TODO Auto Generated method stub
			dataStr = _content.data_txt.text;
			dataArr = dataStr.split("\r");
			//_content.code_txt.text = dataArr.join();
		}
	}
}
