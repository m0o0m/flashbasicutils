package com.wg.scene.astar
{
	import flash.utils.getTimer;
	
	public class StraightAstar
	{
		private var _open:Binary;
		private var _closed:Array;
		
		private var _grid:NodeGrid;
		private var _endNode:ANode;
		private var _startNode:ANode;
		private var _path:Array;
		private var _heuristic:Function = manhattan;
		private var _straightCost:Number = 1.0;
		
		public function StraightAstar()
		{
		}
		
		public function findPath(grid:NodeGrid):Boolean
		{
			_grid = grid;
			_open = new Binary("f");
			_closed = new Array();
			
			_startNode = _grid.startNode;
			_endNode = _grid.endNode;
			
			_startNode.g = 0;
			_startNode.h = _heuristic(_startNode);
			_startNode.f = _startNode.g + _startNode.h;
			
			return search();
		}
		
		public function search():Boolean
		{
			var node:ANode = _startNode;
			
			while(node != _endNode)
			{
				var startX:int = 0 > node.x - 1 ? 0 : node.x - 1;
				var endX:int = _grid.numCols - 1 < node.x + 1 ? _grid.numCols - 1 : node.x + 1;
				
				var startY:int = 0 > node.y - 1 ? 0 : node.y - 1;
				var endY:int = _grid.numRows - 1 < node.y + 1 ? _grid.numRows - 1 : node.y + 1;
				
				for(var i:int = startX; i <= endX; i++)
				{
					for(var j:int = startY; j <= endY; j++)
					{
						var test:ANode = _grid.getNode(i, j);
						
						if(test == node || !test.walkable ||
							(test.x != node.x && test.y != node.y))
						{
							continue;
						}
						
						var cost:Number = _straightCost;
						
						var g:Number = node.g + cost * test.costMultiplier;
						var h:Number = _heuristic(test);
						var f:Number = g + h;
						
						var isInOpen:Boolean = _open.indexOf(test) != -1;
						if(isInOpen || _closed.indexOf(test) != -1)
						{
							if(test.f > f)
							{
								test.f = f;
								test.g = g;
								test.h = h;
								test.parent = node;
								
								if(isInOpen) _open.updateNode( test );
							}
						}
						else
						{
							test.f = f;
							test.g = g;
							test.h = h;
							test.parent = node;
							_open.push( test );
						}
					}
				}
				
				_closed.push(node);
				
				if(_open.length == 0)
				{
					trace("no path found");
					
					return false
				}
				
				node = _open.shift() as ANode;
			}
			
			buildPath();
			
			return true;
		}
		
		private function buildPath():void
		{
			_path = new Array();
			var node:ANode = _endNode;
			_path.push(node);
			
			while(node != _startNode)
			{
				node = node.parent;
				_path.unshift(node);
			}
		}
		
		private function manhattan(node:ANode):Number
		{
			return Math.abs(node.x - _endNode.x) * _straightCost + Math.abs(node.y + _endNode.y) * _straightCost;
		}
		
		//---------------------------------------get/set functions-----------------------------//
		
		public function get path():Array
		{
			return _path;
		}
	}
}
