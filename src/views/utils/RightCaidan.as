package views.utils
{
	import flash.display.MovieClip;
	import flash.events.ContextMenuEvent;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	public class RightCaidan extends MovieClip
	{
		private var leaf:MovieClip;//一个mc,有叶子旋转的动画
		private var flower:MovieClip;//一个mc,一朵花图片
		public function RightCaidan()
		{
			super();
			processMenu();//建立自定义菜单的函数
			//屏蔽右键功能
			stage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN,onRmd);
		}
		
		/**
		 * 
		 * //建立自定义菜单的函数
		 */
		private function processMenu():void
		{
			//创建三个菜单对象
			var leafMenu:ContextMenu=new ContextMenu();
			var flowerMenu:ContextMenu=new ContextMenu();
			var stageMenu:ContextMenu=new ContextMenu();
			//隐藏内建菜单项
			leafMenu.hideBuiltInItems();
			flowerMenu.hideBuiltInItems();
			stageMenu.hideBuiltInItems();
			//添加自定义菜单项并给这些菜单项添加事件侦听器
			var item1:ContextMenuItem = new ContextMenuItem("旋转");
			var item2:ContextMenuItem = new ContextMenuItem("变色");
			var item3:ContextMenuItem = new ContextMenuItem("停止旋转");
			item1.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, rotateLeaf);
			item2.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, changeFlowerColor);
			item3.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, stopRotate);
			leafMenu.customItems.push(item1);
			leafMenu.customItems.push(item3);
			flowerMenu.customItems.push(item2);
			stageMenu.customItems.push(item3);
			contextMenu=stageMenu;//将stageMenu赋予主场景
			leaf.contextMenu=leafMenu;//将leafMenu赋予leaf剪辑
			flower.contextMenu=flowerMenu;//将flowerMenu赋予flower剪辑
		}
		private function rotateLeaf(evt:ContextMenuEvent):void{
			leaf.play();
		}
		private function changeFlowerColor(evt:ContextMenuEvent):void{
			flower.changeColor();//mc的函数,可以改变颜色
		}
		private function stopRotate(evt:ContextMenuEvent):void {
			leaf.stop();
		}
		
		private function changeColor():void {
			var ct:ColorTransform = new ColorTransform();
			ct.color=Math.round(Math.random()*0xFFFFFF);
			//petal.transform.colorTransform =ct;
			ct.color=Math.round(Math.random()*0xFFFFFF);
			//center.transform.colorTransform =ct;
		}
		
		
		private function onRmd(e:MouseEvent):void
		{
			
		} 
	}
}