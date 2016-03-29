package myStruct.logic	
{
	import com.ClientConstants;
	import com.Design;
	import com.Lang;
	import com.assist.utils.PublicFuncStatic;
	import com.assist.utils.TextFieldUtils;
	import com.assist.utils.lang.GameLang;
	import com.assist.view.HtmlText;
	import mydesigndatas.logic.ArmorAttribute;
	import mydesigndatas.logic.Monster;
	import mydesigndatas.logic.MonsterBoatSpeciality;
	import mydesigndatas.logic.PetLevel;
	import mydesigndatas.logic.PetSavvy;
	import mydesigndatas.logic.SkillData;
	import myStruct.base.PetInfoBase;
	import com.panels.tip.tipItem.TipItemParameteForm;
	
	public class PetInfo extends PetInfoBase	
	{
		public var matrixId:int;
		public var isFriendMatrix:Boolean = false;
		
		private var _modelUrl:String="";
		private var _iconUrl:String="";
		private var _expTop:int; 
		
		private var _petLevel:PetLevel;
		public var pet:Monster;
		private var _design:Design = Config.design;
		public var levelName:String = "";
		
		private var _skillDataList:Array;
		
		/**
		 * 类型，用作装备的的时候和人物分开来 
		 */		
		public var type:int =4;
		public const MAXLEVEL:int = Config.data.petData.petParameters.petMaxLevel;
		
		public function PetInfo(initParams:*=null)
		{
			
		}
		public var hasInit:Boolean =false;
		public function init():void
		{
			if(!hasInit)
			{
				if(id != 0){
					
					pet = _design.load(Monster,id);
					if(pet)
					{
						_modelUrl = pet.modelUri.toString();
						_iconUrl =  pet.picUrlButton;
					}
					
					if(_skillDataList)
					{
						_skillDataList.length =0;
						_skillDataList = null;
					}
				}
			}
			hasInit = true;
		}
		
		/**
		 * 种族属性 
		 */		
		private var _monsterBoatSpeciality:MonsterBoatSpeciality
		public function get monsterBoatSpeciality():MonsterBoatSpeciality
		{
			if(!_monsterBoatSpeciality)
			{
				if(pet&&pet.attributeType>1)
				{
					_monsterBoatSpeciality = _design.load(MonsterBoatSpeciality,pet.attributeType);
				}
				else
				{
					_monsterBoatSpeciality = _design.load(MonsterBoatSpeciality,1);
				}
			}
			return _monsterBoatSpeciality
		}
		
		/**
		 * 护甲属性 
		 */	
		private var _armorAttribute:ArmorAttribute;
		public function get armorAttribute():ArmorAttribute
		{
			if(!_armorAttribute)
			{
				if(pet&&pet.armorType>1)
				{
					_armorAttribute = _design.load(ArmorAttribute,pet.armorType);
				}
				else
				{
					_armorAttribute = _design.load(ArmorAttribute,1);
				}
			}
			return _armorAttribute
		}
		
//		private var _clientName:String;
		override public function get name():String
		{
//			if(!_clientName)
//			{
//				_clientName = GameLang.getLang().tableLang(super.name)
//			}
			return (_design.load(Monster, id) as Monster).name;
		}
		
		/**
		 * 根据品节不同，颜色不同的名字
		 */		
		public function get qualityName():String
		{
			var color:int = ClientConstants.getColorByQuality(quality); 
			var str:String = HtmlText.format(pet.name,color)// "<font style='font-weight:normal' color='#" + color.toString(16)  + "'>"+pet.name+"</font>";
			return str
		} 
		
		public function get skillTips():String
		{
			return "";
		}
		
		public function get qualityColor():int
		{
			return ClientConstants.getColorByQuality(quality)
		}
		/**
		 * skilData列表
		 */		
		public function get skillList():Array
		{
			if(!_skillDataList)
			{
				_skillDataList =[];
				var _skillData:SkillData
				for each(var petSkill:PetSkill in skillInfos)
				{
					if(petSkill.skillId!=0)
					{
						_skillData= _design.load(SkillData,[petSkill.skillId,petSkill.level]);
						_skillData.curExp = petSkill.exp;
						_skillDataList.push(_skillData); 
						
						petSkill.skillData = _skillData;
					} 
				}
			}
			
			return _skillDataList;
		}
		
		/**
		 * 主动技能 
		 */	
		public function get activeSkillList():Array
		{
			var tempArr:Array = [];
			
			var allSkillList:Array = skillInfos;
			
			var len:int = allSkillList.length;
			var petSkill:PetSkill;
			for(var i:int =0;i<len;i++)
			{
				petSkill = allSkillList[i] as PetSkill;
				
				if(petSkill.isActivity)
				{
					tempArr.push(petSkill);
				}
			}
			
			return tempArr;
		}
		
		/**
		 * 被动技能 
		 */		
		public function get upPasstiveSkillList():Array
		{
			var tempArr:Array = [];
			
			var allSkillList:Array = skillInfos;
			
			var len:int = allSkillList.length;
			var petSkill:PetSkill;
			for(var i:int =0;i<len;i++)
			{
				petSkill = allSkillList[i] as PetSkill;
				
				if(!petSkill.isActivity)
				{
					tempArr.push(petSkill);
				}
			}
			
			return tempArr;
		}
		
		
		
		private var _currSkillDes:SkillData
		public function get currSkillDes():SkillData
		{
			if(_currSkillDes&&_currSkillDes.id == curSkillID)
			{
				return _currSkillDes;
			}
			
			_currSkillDes= _design.load(SkillData,[curSkillID,1]);
			
			if(!_currSkillDes)
			{
				_currSkillDes = defaultSkill;
			}
			else
			{ 
				for each(var petSkill:PetSkill in skillInfos)
				{
					if(petSkill.skillId == curSkillID)
					{
						_currSkillDes.curExp = petSkill.exp;
						break;
					}
				}
			}
			
			return _currSkillDes; 
		}
		
		public function get defaultSkill():SkillData
		{
			return _design.load(SkillData,[ClientConstants.PET_PUTONG_ACTTACK_ID,1]);
		}
		
		private var oldLevel:int =0; 
		public function get petNextLevel():PetLevel
		{
			if(!_petLevel|| oldLevel != level)
			{
				if(level >= 1){
					if(level >= MAXLEVEL){
						_petLevel = _design.load(PetLevel,level);
					}else{
						_petLevel = _design.load(PetLevel,(level + 1));
					}
				}
			} 
			return _petLevel
		} 
		
		public function getLevelAvvy(targetLevel:int):PetSavvy
		{
			var tempSavvy:PetSavvy
			if(targetLevel == level)
			{
				tempSavvy = petSavvy;
			}
			else
			{
				var levelInterval:int = (int(targetLevel*0.1))*10;
				
				if(levelInterval == 0)
					levelInterval = 1;
				
				tempSavvy =  _design.load(PetSavvy,[targetLevel,levelInterval]);
			}
			
			return tempSavvy;
		}
		
		/**
		 * 获得一定经验后的相关信息
		 * 
		 * 返回一个数组，第一个为得到经验后的等级信息，第二个为升级后剩余的经验
		 */	
		public function getInfoByExp(expNum:Number):Array
		{ 
			var tempPetLevel:PetLevel;
			if(level<MAXLEVEL)
			{
				var petLevels:Array = _design.load(PetLevel);
				var len:int = petLevels.length;
				
				expNum += Number(exp);
				var getUpLevelLeftExp:int =expNum;
				for(var i:int = level;i<len;i++)
				{
					tempPetLevel = petLevels[i];
					
					expNum -= tempPetLevel.requireExp;
					
					if(expNum<0)
					{
						if(i == 0) return null;
						
						return [petLevels[i-1],getUpLevelLeftExp,tempPetLevel]; 
					}else{
						getUpLevelLeftExp = expNum;
					}
				}
			}
			
			
			
			return [null,expNum,petNextLevel];
		}
		
		/**
		 * 获取当前的经验 
		 */		
		public function get currentExp():Number
		{
			if(level<=2)
				return Number(exp);
			
			var tempExp:Number;
			var _petLevel:PetLevel;
			for(var i:int =level;i>2;i--)
			{
				_petLevel = _design.load(PetLevel,i);
				tempExp +=_petLevel.requireExp;
			}
			tempExp += Number(exp);
			return tempExp;
		}
		
		public function get modelUrl():String
		{
			return _modelUrl;
		}
		
		public function get picUrl():String
		{
			return _iconUrl;
		}
		
		public function get expTop():int
		{
			return _expTop;
		}
		
		/**
		 *	得到主动技能个数  
		 * @return 
		 * 
		 */
		public function get activiteSkillNum():int
		{
			return activeSkillList.length; 
		}
		
		/**
		 *	得到被动技能个数 
		 * @return 
		 * 
		 */
		public function get passtiveteSkillNum():int
		{
			return upPasstiveSkillList.length; 
		}
		
		/**
		 * 可以学的技能 
		 */		
		public function get skillsCanBeLearned():Array
		{
			var skillList:Array = [ClientConstants.PET_PUTONG_ACTTACK_ID];
			var petSkill:PetSkill;
			for(var i:int = 0;i<4;i++)
			{
				petSkill = skillInfos[i] as PetSkill;
				if(petSkill&&petSkill.skillId!=0)
				{
					skillList.push(petSkill.skillId);
				}
			}
			
			return skillList;
		}
		
		public function get picUrlButton():String
		{
			return picUrl;
		}
		
		public function get isInFightMatrix():int
		{
			return super.follow;
		}
		
		/**
		 * 相信的属性，所有的
		 */
		private var tipParmeterList:Array=[];
		public function get paramerTips():Array
		{
			var lang:Lang = GameLang.getLang(); 
			tipParmeterList.length=0;
			
			var tipItem:TipItemParameteForm;
			tipItem= TipItemParameteForm.getTipItemForm(TipItemParameteForm.FORMNAME_1,lang.client("生命值:"),hp.toString()); 
			tipParmeterList.push(tipItem);
			tipItem= TipItemParameteForm.getTipItemForm(TipItemParameteForm.FORMNAME_1,lang.client("补给:"),mp.toString()); 
			tipParmeterList.push(tipItem);
			tipItem= TipItemParameteForm.getTipItemForm(TipItemParameteForm.FORMNAME_1,lang.client("物理攻击:"),phisicalAttack.toString()); 
			tipParmeterList.push(tipItem);
			tipItem= TipItemParameteForm.getTipItemForm(TipItemParameteForm.FORMNAME_1,lang.client("物理防御:"),phiDef.toString()); 
			tipParmeterList.push(tipItem);
			tipItem= TipItemParameteForm.getTipItemForm(TipItemParameteForm.FORMNAME_1,lang.client("命中"),hitRate.toString()); 
			tipParmeterList.push(tipItem);
			tipItem= TipItemParameteForm.getTipItemForm(TipItemParameteForm.FORMNAME_1,lang.client("闪避:"),avoidRate.toString()); 
			tipParmeterList.push(tipItem);
			tipItem= TipItemParameteForm.getTipItemForm(TipItemParameteForm.FORMNAME_1,lang.client("士气:"),handSpeed.toString()); 
			tipParmeterList.push(tipItem); 
			return tipParmeterList;
		}
		
		private var _petSavvy:PetSavvy
		public function get petSavvy():PetSavvy
		{
			var levelInterval:int = (int(level*0.1))*10;
			
			if(levelInterval == 0)
				levelInterval = 1;
			
			if(!_petSavvy||_petSavvy.quality!=quality||_petSavvy.level!= levelInterval)
			{
				_petSavvy =  _design.load(PetSavvy,[levelInterval,quality]);
			}
			
			return _petSavvy;
		}
		
		
		/**
		 * 主要的属性，粗略的
		 */		
		public function get paramerMainTips():Array
		{ 
			return paramerTips;
		}
		
		public function get desc():String
		{
			return "";
		}
		
	}
}
