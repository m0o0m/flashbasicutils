package com.wg.scene.mapScene.grid
{
	import com.ClientConstants;
	import com.adobe.utils.Base64Decoder;
	import com.wg.scene.astar.ANode;
	import com.wg.scene.astar.AStar;
	import com.wg.scene.astar.NodeGrid;
	import com.wg.scene.utils.GameMathUtil;
	
	import flash.geom.Point;
	import flash.utils.ByteArray;

	public final class SeaMapGridUtil
	{
		private var _grid:NodeGrid;
		private var _astar:AStar;
		
		public function SeaMapGridUtil()
		{
			super();
			
			_astar = new AStar();
		}
		
		public function getNode(colIndex:int, rowIndex:int):SeaMapNode
		{
			if(colIndex < 0 || colIndex > _grid.numCols - 1 || rowIndex < 0 || rowIndex > _grid.numRows - 1) return null;
			
			return SeaMapNode(_grid.getNode(colIndex, rowIndex));
		}
		
		public function get nodeGrid():NodeGrid
		{
			return _grid;
		}
		
		public function initGrid(numCols:int, numRows:int, 
								 compressedBase64NodeLists:String, maskAlphaList:Array):void
		{
			_grid = new NodeGrid();
			_grid.nodeClass = SeaMapNode;
			_grid.setSize(numCols, numRows);
			
			var n:uint = 0;
			var i:uint = 0;

			var baseDecode:Base64Decoder = new Base64Decoder();
			baseDecode.decode(compressedBase64NodeLists);
			var nodeBytes:ByteArray = baseDecode.drain();
			nodeBytes.uncompress();
			
			n = numCols * numRows;
			var nodeByte:int = 0;
			
			for(; i < n; i++)
			{
				var ri:int = i % 8; 
				
				if(ri == 0) nodeByte = nodeBytes.readByte();
				
				var colIndex:int = i % numCols;
				var rowIndex:int = i / numCols;
				
				_grid.getNode(colIndex, rowIndex).walkable = (nodeByte & (1 << ri)) == 0;
			}
			
			n = maskAlphaList != null ? maskAlphaList.length : 0;
			for(i = 0; i < n; i++)
			{
				var maskAlphaArr:Array = String(maskAlphaList[i]).split(",");
				
				var maskAlphaX:int = maskAlphaArr[0];
				var maskAlphaY:int = maskAlphaArr[1];
				
				SeaMapNode(_grid.getNode(maskAlphaX, maskAlphaY)).isMaskAlpha = true;
				SeaMapNode(_grid.getNode(maskAlphaX, maskAlphaY)).enclosureId = 0;
			}
		}
		
		public function setSetEnclosure(xmlList:XMLList):void
		{
			if(!xmlList||!xmlList.hasOwnProperty("enclosure"))
			{
				return;
			}
			xmlList = xmlList.enclosure;
			var len:int =xmlList?xmlList.length():0;
			if(len>0)
			{
				var itemXML:XML;
				var ltx:int;
				var lty:int;
				var rbx:int;
				var rby:int;
				for(var i:int = 0; i < len; i++)
				{
					itemXML = xmlList[i];
					ltx = itemXML.@ltx;
					lty = itemXML.@lty;
					rbx = itemXML.@rbx;
					rby = itemXML.@rby;
					
					for(var m:int = ltx;m<=rbx;m++)
					{
						for(var n:int =lty;n<=rby;n++)
						{
							SeaMapNode(_grid.getNode(m, n)).enclosureId = int(itemXML.@id);
						}
					}
				}
			}
		}
		
		public function getNearestWalkablePointInfo(targetPoint:Object):Object
		{
			var ret:Object;
			var endPosX:int = int(targetPoint.x / ClientConstants.MAP_GRID_WIDTH);
			var endPosY:int = int(targetPoint.y / ClientConstants.MAP_GRID_WIDTH);
			if(endPosX < 0 || endPosY < 0 || endPosX > _grid.numCols - 1 || endPosY > _grid.numRows -1) return null;
			var endNode:ANode = _grid.getNode(endPosX, endPosY);
			if(!endNode.walkable)
			{
				endNode = _grid.findReplacer(endNode);
				endPosX = endNode.x;
				endPosY = endNode.y;
			}
			ret = {x:endPosX * ClientConstants.MAP_GRID_WIDTH, y:endPosY * ClientConstants.MAP_GRID_WIDTH};
			return ret;
		}
		
		public function findPath(targetPoint:Object, currentPoint:Object, awaysFind:Boolean = false):Array
		{
//			var t:int = getTimer();
			var startPosX:int = int(currentPoint.x / ClientConstants.MAP_GRID_WIDTH);
			var startPosY:int = int(currentPoint.y / ClientConstants.MAP_GRID_WIDTH);
			if(startPosX < 0 || startPosY < 0 || startPosX > _grid.numCols - 1 || startPosY > _grid.numRows -1) return null;

			var endPosX:int = int(targetPoint.x / ClientConstants.MAP_GRID_WIDTH);
			var endPosY:int = int(targetPoint.y / ClientConstants.MAP_GRID_WIDTH);
			if(endPosX < 0 || endPosY < 0 || endPosX > _grid.numCols - 1 || endPosY > _grid.numRows -1) return null;
			
			var i:int = 0;
			var n:int = 0;
			
			var startNode:ANode = null;
			var endNode:ANode = null;
			
			startNode = _grid.getNode(startPosX, startPosY);
			
			if(!startNode.walkable) return null;
			
			endNode = _grid.getNode(endPosX, endPosY);
			
			if(!endNode.walkable)
			{
				if(!awaysFind) return null;

				endNode = _grid.findReplacer(endNode);
				
				endPosX = endNode.x;
				endPosY = endNode.y;
			}
			
			if(!endNode.walkable) return null;
			
			if(SeaMapNode(startNode).enclosureId != SeaMapNode(endNode).enclosureId) return null;
			//--
			
			var resultNodesPath:Array = null;
			var hasBarrier:Boolean = _grid.hasBarrier(startPosX, startPosY, endPosX, endPosY);
			if(hasBarrier)
			{
				_grid.setStartNode(startPosX, startPosY);
				_grid.setEndNode(endPosX, endPosY);
				
				if(_astar.findPath(_grid) && _astar.path.length > 0)
				{
					_astar.floyd();
					_astar.floydPath.shift();
					
					resultNodesPath = _astar.floydPath;
				}
			}
			else
			{
				resultNodesPath = [_grid.getNode(endPosX, endPosY)];
			}
			
			//--
			
			if(resultNodesPath == null || resultNodesPath.length == 0) return null;
			
			var resultPoints:Array = [];
			var node:ANode = null;
			
			n = resultNodesPath.length;
			for(i = 0; i < n; i++)
			{
				node = resultNodesPath[i];
				var x:int = node.x * ClientConstants.MAP_GRID_WIDTH +  ClientConstants.MAP_GRID_HALF_WIDTH;
				var y:int = node.y * ClientConstants.MAP_GRID_WIDTH + ClientConstants.MAP_GRID_HALF_WIDTH;
				var p:Object = {x:x, y:y};
				resultPoints.push(p);
			}
			
			return resultPoints;
		}
		
		public function findPath2(targetPoint:Object, current:Object, targetRadius:Number = 0, awaysFind:Boolean = false):Array
		{
			var radius:Number = targetRadius;
			
			var distance:Number = GameMathUtil.distance(targetPoint.x, targetPoint.y, current.x, current.y);
			if(distance < radius)
			{
				return [{x:current.x, y:current.y}];
			}
			
			//寻找访问圈上的一点
			var radian:Number = GameMathUtil.caculateDirectionRadianByTwoPoint2(targetPoint.x, targetPoint.y, current.x, current.y);
			var targetResultP:Point = GameMathUtil.caculatePointOnCircle(targetPoint.x, targetPoint.y, radian, radius);
			
			var targetResultPPosX:int = int(targetResultP.x / ClientConstants.MAP_GRID_WIDTH);
			var targetResultPPosY:int = int(targetResultP.y / ClientConstants.MAP_GRID_WIDTH);
			var targetResultPNode:SeaMapNode = getNode(targetResultPPosX, targetResultPPosY);
			if(targetResultPNode)
			{
				return findPath(targetResultP, current, awaysFind);
			}
			else//圈上的一点不可行走, 访问原始点
			{
				return findPath(targetPoint, current, awaysFind);
			}
		}
	}
}