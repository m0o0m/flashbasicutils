package views.formula.AStar
{
	    import com.wg.scene.astar.ANode;
	import com.wg.scene.astar.AStar;
	import com.wg.scene.astar.NodeGrid;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	 
	    public class GridView extends Sprite
	    {
		        private var _cellSize:int=20;
		        private var _grid:NodeGrid;
		 
		        //构造函数
		        public function GridView(grid:NodeGrid)
		        {
			            _grid=grid;
			            drawGrid();
			            findPath();
			            addEventListener(MouseEvent.CLICK, onGridClick);
		        }
		 
		        //画格子
		        public function drawGrid():void
		        {
			            graphics.clear();
			            for (var i:int=0; i < _grid.numCols; i++)
			            {
				                for (var j:int=0; j < _grid.numRows; j++)
				                {
					                    var node:ANode=_grid.getNode(i, j);
					                    graphics.lineStyle(0);
					                    graphics.beginFill(getColor(node));
					                    graphics.drawRect(i * _cellSize, j * _cellSize, _cellSize, _cellSize);
				                }
			            }
		        }
		 
		        //取得节点颜色
		        private function getColor(node:ANode):uint
		        {
			            if (!node.walkable)
			            {
				                return 0;
			            }
			            if (node == _grid.startNode)
			            {
				                return 0xffff00;
			            }
			            if (node == _grid.endNode)
			            {
				                return 0xff0000;
			            }
			            return 0xffffff;
		        }
		 
		        //网格点击事件
		        private function onGridClick(event:MouseEvent):void
		        {
			            var xpos:int=Math.floor(event.localX / _cellSize);
			            var ypos:int=Math.floor(event.localY / _cellSize);
			            _grid.setWalkable(xpos, ypos, !_grid.getNode(xpos, ypos).walkable);
			            drawGrid();
			            findPath();
		        }
		 
		        //寻找路径
		        private function findPath():void
		        {
			            var astar:AStar=new AStar;
			            if (astar.findPath(_grid))
			            {
				                showVisited(astar);
				                showPath(astar);
			            }
		        }
		 
		        //显示open列表与close列表
		        private function showVisited(astar:AStar):void
		        {
			             
			            var opened:*=astar.openArray.data;
			            for (var i:int=0; i < opened.length; i++)
			            {
				                var node:ANode = opened[i] as ANode;
				                 
				                graphics.beginFill(0xcccccc);//灰色
				                if (node==_grid.startNode){
					                    graphics.beginFill(0xffff00);
				                }
				                 
				                graphics.drawRect(opened[i].x * _cellSize, opened[i].y * _cellSize, _cellSize, _cellSize);
				                graphics.endFill();
			            }
			             
			            var closed:*=astar.closedArray;
						for(var j:* in closed)
						{
				                 
				                graphics.beginFill(0xffff00); //黄              
				                 
				                graphics.drawRect(j.x * _cellSize, j.y * _cellSize, _cellSize, _cellSize);
				                graphics.endFill();
						}
			            /*for (i=0; i < closed.length; i++)
			            {
				                node = opened[i] as ANode;
				                 
				                graphics.beginFill(0xffff00);               
				                 
				                graphics.drawRect(closed[i].x * _cellSize, closed[i].y * _cellSize, _cellSize, _cellSize);
				                graphics.endFill();
			            }*/
		        }
		 
		        //显示路径
		        private function showPath(astar:AStar):void
		        {
			            var path:Array=astar.path;
			            for (var i:int=0; i < path.length; i++)
			            {
				                graphics.lineStyle(0);
				                graphics.beginFill(0);
				                graphics.drawCircle(path[i].x * _cellSize + _cellSize / 2, path[i].y * _cellSize + _cellSize / 2, _cellSize / 3);
			            }
		        }
	    }
}