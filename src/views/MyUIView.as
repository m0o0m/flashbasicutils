package views
{
	import com.wg.ui.button.ButtonGroupManger;
	import com.wg.ui.button.LittleButton;
	import com.wg.ui.button.LittleCheckBox;
	import com.wg.ui.button.LittleGroupButton;
	import com.wg.ui.button.RichLittleButton;
	import com.wg.ui.list.BoxRenderer;
	import com.wg.ui.list.CircleRenderer;
	import com.ui.list.ItemList;
	import com.wg.ui.list.List;
	import com.wg.ui.list.ListEvent;
	import com.wg.ui.scrollBar.ScrollBar;
	import com.wg.ui.text.InputTextField;
	import com.wg.ui.text.LunboTextField;
	
	import flash.display.MovieClip;
	import flash.text.TextField;

	public class MyUIView extends ViewBase
	{
		public function MyUIView()
		{
			panelName = "myui";
			super();
		}
		private var picMcCls:Class;
		override protected function render():void
		{
			if(!content)
			{
				var maincls:Class = Config.resourceLoader.getClass(panelName);
				content = new maincls();
				this.addChild(content);
				picMcCls = Config.resourceLoader.getClass("NumMc",panelName);
//				var itemlistCls:Class = Config.resourceLoader.getClass("NumMc",panelName);
				initbuttons();
				initList();
				initScrollBar();
				initTxt();
			}
			super.render();
		}
		private function initbuttons():void
		{
			var littlebtn:LittleButton = new LittleButton(content.onebtn,"正常");
			littlebtn.hasClickState = false;
			littlebtn.init();
			//				littlebtn.dispose();
			
			var littlebtn2:LittleButton = new LittleButton(content.onebtn1,"Lock");
			littlebtn2.hasClickState = false;
			littlebtn2.isLock = true;
			littlebtn2.init();
			
			var littlebtn3:LittleButton = new LittleButton(content.onebtn2,"有状态");
			littlebtn3.init();
			
			var littlebtn4:LittleButton = new LittleButton(content.onebtn3,"颜色切换");
			littlebtn4.setTxtColor(0x00ff00,0xff0000);
			littlebtn4.init();
			
			var nameArr:Array = ["name1","name2","name3","name4","name5"];
			for (var i:int = 0; i < nameArr.length; i++) 
			{
				var tempbtn:LittleGroupButton = new LittleGroupButton(content.tabbuttons["btn"+i],nameArr[i]);
				tempbtn.gameType = "test";
				tempbtn.init();
			}
			ButtonGroupManger.instance.changeState(tempbtn);
			
			var littlebtn5:LittleCheckBox = new LittleCheckBox(content.checkbox,"是否选中");
			littlebtn5.setTxtColor(0x00ff00,0xff0000);
			littlebtn5.init();
			var richbtnArr:Array = [];
			for (var j:int = 0; j <= 6; j++) 
			{
				var littlebtn6:RichLittleButton = new RichLittleButton(content["richbtn"+j],"",new picMcCls() as MovieClip);
				
				richbtnArr.push(littlebtn6);
				richbtnArr[j].picIndex = j+1;
				richbtnArr[j].init();
			}
			
			for (var i2:int = 0; i2 < 6; i2++) 
			{
				var tempbtn:LittleGroupButton = new LittleGroupButton(content.topbtn2_mc["btn"+i2],i2.toString());
				tempbtn.gameType = "test2";
				tempbtn.init();
			}
			ButtonGroupManger.instance.changeState(tempbtn);
		}

		private function initList():void
		{
			var images:Array = new Array();
			for(var i:int = 0; i < 9; i++){
				var item:Object = new Object();
				item.imgPath = i + ".png";
				images.push(item);
			}
			
			var t:CircleRenderer;
			var t2:BoxRenderer;
			
			var list:List = new List(images,"com.wg.ui.list.CircleRenderer");
			list.addEventListener(ListEvent.MOVE_ON_ITEM,selectedFun);
			list.y = 0;
			content.list_bg_mc.addChild(list);
			
			var list2:List = new List(images,"com.wg.ui.list.BoxRenderer");
			list2.addEventListener(ListEvent.SELECTED_ITEM,selectedFun2);
			list2.y = 180;
			content.list_bg_mc.addChild(list2);
		}
		
		private function selectedFun(event:ListEvent):void{
			content.list_bg_mc.label.text = "鼠标停留在当前的索引为：" + event.index;
		}
		
		private function selectedFun2(event:ListEvent):void{
			content.list_bg_mc.label2.text = "选中的索引为：" + event.index;
		}
		
		private var _scroll:ScrollBar;
		private var topLittleButtonArr:Array = [];
		private function initScrollBar():void
		{
			_scroll =new ScrollBar(_stage,content["scroll_mc"],content["mask_mc"],content["slider_mc"],content["scroll_bg"]);
			
			_scroll.direction="L";				 //方向——左右滚动为"H"，上下滚动为"L"。[默认:"L"]
			_scroll.tween=2;       		 	 //缓动——1为不缓动，数字越大缓动越明显。[默认:5]
			_scroll.elastic=false;  			 //滑块拉伸——如果滑块是位图，建议选择false。[默认:flase]
			_scroll.lineAbleClick=true;		 //滚动条背景可点击——可点击(true)/不可点击(false),[默认:false]
			_scroll.mouseWheel=true;			 //支持鼠标滚轮——支持(true)/不支持(false),[默认:false]
			//			_scroll.UP=upControl;				 //分配上/左((L版/H版)滚动条按钮,不需要此按钮可以去除
			//			_scroll.DOWN=downControl;		     //分配下/右((L版/H版)滚动条按钮,不需要此按钮可以去除
			_scroll.stepNumber=20;				 //步数——包括鼠标滚轮、点击滚动条背景、单击左右/上下按钮，所跳动的距离，单位为像素。[默认:15]
			
			_scroll.init();					 //自动刷新滚动条
		}
		
		private function initTxt():void
		{
			var tempInputMc:InputTextField = new InputTextField(content["txt_mc"]);
			tempInputMc.inputFunc = textInputFunc;
			tempInputMc.outputFunc = textOutputFunc;
			tempInputMc.init();
			
			var lunbo:LunboTextField = new LunboTextField(content.luoboMc);
		}
		
		private function textOutputFunc(txt:InputTextField):void
		{
			// TODO Auto Generated method stub
		}
		
		private function textInputFunc(txt:InputTextField):void
		{
			// TODO Auto Generated method stub
			
		}
	}
}