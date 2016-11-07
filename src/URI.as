package
{
	public class URI
	{
		public var panelPath:String = "assets/panels/";
		public var simpleMapPath:String = "assets/simplemap/";
		public var townMapPath:String = "assets/map/town/";
		public var mapPath:String = "assets/map/";
		public var buttonIconPath:String = "assets/icons/roles/Button/";
		public var commonPath:String = "assets/common/";
		
		public var warBuffEffectPath:String = "assets/war/buffEffects/";
		public var warBuffIconPath:String = "assets/war/buffIcon/";
		public var npcQuestStatePath:String = "assets/tags/quest/";
		
		public var rolePath:String = "assets/roles/";
		public function URI()
		{
		}
		public function getBoatSuitActiveEffectURI(id:*):String
		{
			return (this.rolePath + "ModelEffect/ModelSuitActive/" + id + ".swf");
		}
		public function getNpcHeadMcURI(id:*) : String
		{
			return (npcQuestStatePath + id + ".swf");
		} 
		public function getPataIslandURI(index:int):String
		{
			return ("assets/map/ectype/paTa/" + index + ".swf");
		}
		
		public function get resourceCommonKey():String
		{
			return "common";
		}
		
		public function getWarBuffIconURI(id:*):String
		{
			return (warBuffIconPath + id + ".png");
		}
		public function getRoleSailURI(id:*):String
		{
			return (this.rolePath + "ModelSail/" + id + ".swf");
		}
		public function getRoleBoatWaterURI(id:*):String
		{
			return (this.rolePath + "ModelWave/" + id + ".swf");
		}
		public function getRoleBoatShadowURI(id:*):String
		{
			return (this.rolePath + "ModelShadow/" + id + ".swf");
		}
		public function getRoleArtilleryURI(id:*):String
		{
			return (this.rolePath + "ModelCannon/" + id + ".swf");
		}
		public function getMonsterWaterURI(id:*):String
		{
			return (this.rolePath + "ModelMonsterWave/" + id + ".swf");
		}
		public function getWarBuffEffectURI(id:*):String
		{
			return (warBuffEffectPath + id + ".swf");
		}
		public function getRoleAttackTargetMarkURI():String
		{
			return (this.rolePath + "ModelEffect/attackTargetMark.swf");
		}
		public function getCommonURI(id:*):String
		{
			return (this.commonPath + id + ".swf");
		}
		public function getSeaWaveURI():String
		{
			return getCommonURI("seaWave");
		}
		public function getRoleBeAttackEffectURI(id:*):String
		{
			return (this.rolePath + "ModelEffect/ModelBeAttackEffect/" + id + ".swf");
		}
		
		public function getRoleAttackTargetMark2URI():String
		{
			return this.rolePath + "ModelEffect/attackTargetMark2.swf";
		}
		public function getRoleURI(id:*):String
		{
			return this.rolePath + id + ".swf";
		}
		public function getPanelURI(panel:String) : String
		{
			return (this.panelPath + panel + ".swf");
		}
		public function getSimpleMapURI(panel:String) : String
		{
			return (this.simpleMapPath + panel + ".swf");
		}
		public function getTownMapConfigURI(id:*):String
		{
			return this.townMapPath + id + "/map.xml";
		}
		
		public function getTownMapSmallURI(id:*):String
		{
			return this.townMapPath + id + "/small.swf";
		}
		public function getSceneWeatherURI(type:int):String
		{
			return mapPath + "weather_effects/" + type + ".swf";
		}
		public function getMapSceneEffectePath(effectId:*):String
		{
			return "assets/effect/sceneEffect/" + effectId + ".swf";
		}
		
		public function getTownMapBackgroundImgItemURI(mapId:*, fileName:String):String
		{
			return (this.townMapPath + mapId + "/backgroundItems/imgs/" + fileName);
		}
		
		
		public function getButtonIconPath(id:*) :String
		{
			return buttonIconPath + id + ".png";
		}
		
		
		/*================simplemapload=================*/
		public var modulePath:String = "modules/";
		public var roleIconPath:String="assets/icons/roles/small/";
		public var musicPath:String = "assets/music/";
		public var portalPath:String = "assets/tags/portal/";
		public var npcIconPath:String = "assets/icons/roles/big/";
		
		public function getModuleURI(value:String):String{
			return (this.modulePath + value + ".swf");
		}
		
		public function getIconURI(id:*) : String
		{
			return this.getURI(roleIconPath + id + ".png");
		}
		
		private function getURI(str:String):String
		{
			return str;
		}
		
		public function getRoleScreenStandURI(value:int):String{
			return this.getURI("assets/roles/" + "stand/" + value + ".swf");
		}
		public function getScreenURI():String{
			return this.getURI("assets/roles/");
		}
		public function getRoleScreenRunURI(value:int):String{
			return this.getURI(rolePath + "run/" + value + ".swf");
		}
		
		public function getMusicPath(value:*):String {
			return this.getURI(this.musicPath + value + ".mp3");
		}
		public function getNpcHeadFuncURI(id:*) : String
		{
			return this.getURI(npcQuestStatePath + id + ".png");
		}
		public function getPortalURI(value:*):String{
			return this.getURI(portalPath + value + ".swf");
		}
		public function getNpcIconURI(id:*) : String
		{
			return this.getURI(npcIconPath + id + ".swf")
		}
	}
}