package com.wg.scene.mapScene.grid
{
	import com.wg.scene.astar.ANode;

	public class SeaMapNode extends ANode
	{
		public var isMaskAlpha:Boolean = false;
		
		//封闭区域，0标识不是封闭区域
		public var enclosureId:int;
		
		public function SeaMapNode(x:int, y:int)
		{
			super(x, y);
		}
	}
}