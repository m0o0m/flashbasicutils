package views
{
	import com.wg.layout.Layout;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class LayoutView extends ViewBase
	{
		public var isModal:Boolean = false;
		public function LayoutView()
		{
			panelName = "layout";
			super();
		}
		override protected function render():void
		{
			if(!content)
			{
				trace(String(this));
				var maincls:Class = Config.resourceLoader.getClass(panelName);
				var mc1cls:Class =  Config.resourceLoader.getClass("MC1",panelName);
				
				
				content = new maincls();
				this.addChild(content);
				Config.layout = new Layout();
				Config.layout.init(_stage);
				Config.layout.name = "_layout";
				addChild(Config.layout);
				
				
				var tempbln:Boolean;
				content.show_btn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
				{
					tempbln = !tempbln;
					Config.layout.showDebug(tempbln);
				}
				);
				/*==========================================================*/
				content.add1_btn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
				{
					var mc1:MovieClip = new mc1cls();
					mc1.txt.text = "mc1";
					Config.layout.panelLayer.addView("superView1",mc1);
				}
				);
				content.add2_btn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
				{
					var mc2:MovieClip = new mc1cls();
					mc2.txt.text = "mc2";
					Config.layout.panelLayer.addView("superView2",mc2);
				}
				);
				content.close1_btn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
				{
					Config.layout.panelLayer.closeView("superView1");
				}
				);
				
				content.close2_btn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
				{
					Config.layout.panelLayer.closeView("superView2");
				}
				);
				/*========================================*/
				
				content.coxitadd1_btn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
				{
					var mc1:MovieClip = new mc1cls();
					mc1.txt.text = "mc1";
					Config.layout.panelLayer.addView("coexistViews1",mc1);
				}
				);
				content.coxitadd2_btn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
				{
					var mc2:MovieClip = new mc1cls();
					mc2.txt.text = "mc2";
					Config.layout.panelLayer.addView("coexistViews2",mc2);
				}
				);
				content.coxitclose1_btn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
				{
					Config.layout.panelLayer.closeView("coexistViews1");
				}
				);
				
				content.coxitclose2_btn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
				{
					Config.layout.panelLayer.closeView("coexistViews2");
				}
				);
				/*==========================================================*/
				content.normaladd1_btn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
				{
					var normalmc1:MovieClip = new mc1cls();
					normalmc1.txt.text = "mc1";
					Config.layout.panelLayer.addView("normalView1",normalmc1);
				}
				);
				content.normaladd2_btn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
				{
					var normalmc2:MovieClip = new mc1cls();
					normalmc2.scaleX = 2;
					normalmc2.txt.text = "mc2";
					Config.layout.panelLayer.addView("normalView2",normalmc2);
				}
				);
				content.normalclose1_btn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
				{
					Config.layout.panelLayer.closeView("normalView1");
				}
				);
				
				content.normalclose2_btn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
				{
					Config.layout.panelLayer.closeView("normalView2");
				}
				);
				
			}
			
			super.render();
		}
	}
}