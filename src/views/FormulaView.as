package views
{
	import com.wg.scene.astar.NodeGrid;
	
	import fl.controls.CheckBox;
	import fl.controls.LabelButton;
	
	import flash.events.MouseEvent;
	
	import views.formula.AStar.GridView;
	import views.formula.Sanjiao;
	import views.formula.mapScene.Moveformula;

	public class FormulaView extends ViewBase
	{
		private var map1cls:Class;
		public function FormulaView()
		{
			panelName = "formulatools";
			super();
		}
		
		override protected function render():void
		{
			if(!content)
			{
				var maincls:Class = Config.resourceLoader.getClass(panelName);
				content = new maincls();
				this.addChild(content);
				content.mainBtn1.addEventListener(MouseEvent.CLICK,sanjiaoHandler);
				content.mainBtn2.addEventListener(MouseEvent.CLICK,yidongHandler);
				content.mainBtn3.addEventListener(MouseEvent.CLICK,aStarHandler);
				map1cls = Config.resourceLoader.getClass("sanjiaocomp",panelName);
				map2cls = Config.resourceLoader.getClass("movecomp",panelName);
			}
			super.render();
		}
		private var _sanjiao:Sanjiao;
		private function sanjiaoHandler(e:MouseEvent):void
		{
			// TODO Auto Generated method stub
			content.content.removeChildren();
			if(!_sanjiao) _sanjiao = new Sanjiao(new map1cls());
			content.content.addChild(_sanjiao.content);
		}
		private var map2cls:Class;
		private var _move:Moveformula;
		private function yidongHandler(e:MouseEvent):void
		{
			content.content.removeChildren();
			if(!_move) _move = new Moveformula(new map2cls());
			content.content.addChild(_move.content);
		}
		
		private var _grid:NodeGrid;
		private var _gridView:GridView;
		private function aStarHandler(e:MouseEvent):void
		{
			content.content.removeChildren();
			if(_gridView)
			{
				this.addChild(_gridView);
				return;
			}
			_grid=new NodeGrid();
			_grid.setSize(16,10);
			_grid.setStartNode(1, 1);
			_grid.setEndNode(12, 6);
			
			//设置障碍物
			_grid.getNode(8,0).walkable = false;
			_grid.getNode(8,1).walkable = false;
			_grid.getNode(8,2).walkable = false;
			_grid.getNode(8,3).walkable = false;
			_grid.getNode(8,4).walkable = false;
			_grid.getNode(8,5).walkable = false;
			_grid.getNode(8,6).walkable = false;
			_grid.getNode(8,7).walkable = false;
			
			_gridView=new GridView(_grid);
			_gridView.x=100;
			_gridView.y=100;
			content.content.addChild(_gridView);
		}
		
	}
}