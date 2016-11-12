package views
{
	import com.wg.scene.astar.NodeGrid;
	
	import flash.events.MouseEvent;
	
	import fl.controls.CheckBox;
	import fl.controls.LabelButton;
	
	import views.formula.Sanjiao;
	import views.formula.AStar.GridView;
	import views.formula.basicAnimate.BasicAnmateMC;
	import views.formula.hitest.HitTest_Test;
	import views.formula.mapScene.Moveformula;
	import views.formula.tanhuangmove.BallMC;
	import views.formula.tanhuangmove.BallMC2;
	import views.formula.tanhuangmove.BallMC3;
	import views.formula.tanhuangmove.BallMC4;
	import views.formula.tanhuangmove.Tanhuangmanager;
	import views.formula.tanhuangmove.Tanhuangmanager2;
	import views.formula.tanhuangmove.Tanhuangmanager3;
	import views.formula.tanhuangmove.Tanhuangmanager4;

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
				content.mainBtn4.addEventListener(MouseEvent.CLICK,basicAnimHandler);
				content.mainBtn5.addEventListener(MouseEvent.CLICK,basicHitHandler);
				content.mainBtn6.addEventListener(MouseEvent.CLICK,tanhuangMoveHandler);
				map1cls = Config.resourceLoader.getClass("sanjiaocomp",panelName);
				map2cls = Config.resourceLoader.getClass("movecomp",panelName);
				map3cls = Config.resourceLoader.getClass("basicanimcomp",panelName);
				BallMC.Ball = Config.resourceLoader.getClass("ball",panelName);
				BallMC2.Ball = Config.resourceLoader.getClass("ball",panelName);
				BallMC3.Ball = Config.resourceLoader.getClass("ball",panelName);
				BallMC4.Ball = Config.resourceLoader.getClass("ball",panelName);
				//map3cls = Config.resourceLoader.getClass("basicanimcomp",panelName);
			}
			super.render();
		}
		private var _sanjiao:Sanjiao;
		/**
		 *三角函数模拟 
		 * @param e
		 * 
		 */
		private function sanjiaoHandler(e:MouseEvent):void
		{
			// TODO Auto Generated method stub
			content.content.removeChildren();
			if(!_sanjiao) _sanjiao = new Sanjiao(new map1cls());
			content.content.addChild(_sanjiao.content);
		}
		private var map2cls:Class;
		private var _move:Moveformula;
		/**
		 *人物场景移动 
		 * @param e
		 * 
		 */
		private function yidongHandler(e:MouseEvent):void
		{
			content.content.removeChildren();
			if(!_move) _move = new Moveformula(new map2cls());
			content.content.addChild(_move.content);
		}
		
		private var _grid:NodeGrid;
		private var _gridView:GridView;
		/**
		 *A星寻路 
		 * @param e
		 * 
		 */
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
		private var basicanimMc:BasicAnmateMC;
		private var map3cls:Class;
		
		private function basicAnimHandler(e:MouseEvent):void
		{
			content.content.removeChildren();
			if(!basicanimMc) basicanimMc = new BasicAnmateMC(new map3cls());
			content.content.addChild(basicanimMc.content);
		}
		
		/**
		 *碰撞检测代码 
		 * @param e
		 * 
		 */
		private var hitTest_test:HitTest_Test;
		
		private function basicHitHandler(e:MouseEvent):void
		{
			content.content.removeChildren();
			if(!hitTest_test) hitTest_test = new HitTest_Test();
			content.content.addChild(hitTest_test);
		}
		
		/**
		 *弹簧运动 
		 * @param e
		 * 
		 */
		private var tanhuangmanager:Tanhuangmanager4;
		private function tanhuangMoveHandler(e:MouseEvent):void
		{
			content.content.removeChildren();
			if(!tanhuangmanager) tanhuangmanager = new Tanhuangmanager4();
			content.content.addChild(tanhuangmanager);
			tanhuangmanager.startMove();
		}
		
		override protected function dispose():void
		{
			if(tanhuangmanager)
			{
				tanhuangmanager.dispose();
				content.content.removeChild(tanhuangmanager);
				tanhuangmanager = null;
			}
		}
	}
	
}