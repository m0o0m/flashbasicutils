package com.wg.scene.mapScene.layers
{
	
	import com.wg.scene.SceneCamera;
	import com.wg.scene.mapScene.SeaSceneBasic;
	import com.wg.scene.mapScene.layers.terrainItems.BasicTerrainItem;
	import com.wg.scene.mapScene.layers.terrainItems.TerrainImageItem;
	import com.wg.scene.utils.GameMathUtil;
	
	import flash.display.Sprite;
	
	import mymap.sceneInfo.MapSceneInfo;

	public class TerrainSceneLayer extends flash.display.Sprite
//	public class TerrainSceneLayer extends starling.display.Sprite
	{
		public static const MAX_TERRAIN_LOAD_COUNT:int = 3;
		
		public var camera:SceneCamera;
		public var scene:SeaSceneBasic;
		public var mapSceneInfo:MapSceneInfo;
		public var curTerrainLoadCount:int = 0;
		
		private var _terrainItems:Vector.<BasicTerrainItem>;
		private var _backgroundItemWateTime:Number = 0;
		
		
		public function TerrainSceneLayer()
		{
			super();
			
			_terrainItems = new Vector.<BasicTerrainItem>();
		}
		
		public function increaseLoadCount():void
		{
			curTerrainLoadCount++;
		}
		
		public function decreaseLoadCount():void
		{
			curTerrainLoadCount--;
			if(curTerrainLoadCount < 0) curTerrainLoadCount = 0;
		}
		
		public function releaseTerrainItems():void
		{
			if(_terrainItems && _terrainItems.length > 0)
			{
				for(var i:uint = 0, n:uint = _terrainItems.length; i < n; i++)
				{
					_terrainItems[i].releaseTerrainItem();
				}
			}
		}
		
		public function isValidLoad():Boolean
		{
			return curTerrainLoadCount < MAX_TERRAIN_LOAD_COUNT;
		}
		
		public function initializeMap(mapSceneInfo:MapSceneInfo):void
		{
			this.mapSceneInfo = mapSceneInfo;
			
			curTerrainLoadCount = 0;

			initializeTerrainItems(mapSceneInfo.mapId, this, mapSceneInfo.sceneConfigXMl.island.item, 
				TerrainImageItem, "imgPath", "getTownMapBackgroundImgItemURI");
			/*initializeTerrainItems(mapSceneInfo.mapId, this, mapSceneInfo.sceneConfigXMl.effect.item, 
				TerrainEffectItem, "effectPath", "getTownMapBackgroundEffectItemURI");*/
		}
		
		private function initializeTerrainItems(mapId:int,
												itemDisplayContainer:*, 
												items:XMLList, itemIplCls:Class, itemPathKey:String, pathFunctionName:String):void
		{
			var terrainItem:BasicTerrainItem;
			var path:String;
			var x:int;
			var y:int;
			var width:int;
			var height:int; 
			var underSea:Boolean;
			
			var itemXML:XML;
			var n:int = items ? items.length() : 0;
			for(var i:int = 0; i < n; i++)
			{
				itemXML = items[i];
				
				x = itemXML.@posX;
				y = itemXML.@posY;
				width = itemXML.@width;
				height = itemXML.@height;
				path = itemXML["@" + itemPathKey];
				
//test for map 105.
//				if(path != "9112005_11_1.png" && 
//					path != "9112005_11_2.png" &&
//					path != "9112005_11_3.png" &&
//					path != "9112005_11_4.png") continue;
//				
				path = Config.uri[pathFunctionName](mapId, path);
				
				terrainItem = new itemIplCls(this);
				terrainItem.path = path;
				terrainItem.itemX = x;
				terrainItem.itemY = y;
				terrainItem.itemWidth = width;
				terrainItem.itemHeight = height;
				terrainItem.underSea = parseInt(itemXML.@underSea) == -1;
				terrainItem.seaMapInfo = mapSceneInfo;
				terrainItem.camera = camera;
				itemDisplayContainer.addChild(terrainItem);
				_terrainItems.push(terrainItem);
			}
		}
		
		public function clear():void
		{
			if(_terrainItems && _terrainItems.length > 0)
			{
				for(var i:uint = 0, n:uint = _terrainItems.length; i < n; i++)
				{
					_terrainItems[i].dispose();
				}
				
				_terrainItems.length = 0;
			}
		}
		
		public function onFrame(deltaTime:Number):void
		{
			this.x = -GameMathUtil.round(camera.scrollX);// >> 0;
			this.y = -GameMathUtil.round(camera.scrollY);// >> 0;
			
			var terrainItem:BasicTerrainItem = null;
			
			var terrainItemX:Number = 0;
			var terrainItemY:Number = 0;
			var terrainItemWidth:Number = 0;
			var terrainItemHeight:Number = 0;
			
			for(var i:uint = 0, n:uint = _terrainItems.length; i < n; i++)
			{
				terrainItem = _terrainItems[i];
				terrainItem.onFrame(deltaTime);
			}
		}
	}
}