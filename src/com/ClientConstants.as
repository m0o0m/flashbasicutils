package com 
{
	import flash.display.DisplayObject;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	
	/**
	 *客户端常量的配置; 
	 * @author Allen
	 * 
	 */
	public class ClientConstants 
	{
		public static const GLOBAL_FILTER_RED:ColorMatrixFilter = new ColorMatrixFilter([1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0]);
		public static const GLOBAL_FILTER_WHITE:ColorMatrixFilter = new ColorMatrixFilter([1, 0, 0, 0, 45, 0, 1, 0, 0, 45, 0, 0, 1, 0, 45, 0, 0, 0, 1, 0])
		public static const GLOBAL_FILTER_GREY:ColorMatrixFilter = new ColorMatrixFilter([0.33, 0.33, 0.33, 0, 0,
																							 0.33, 0.33, 0.33, 0, 0, 
																							 0.33, 0.33, 0.33, 0, 0,
																							  0,   0,   0,  1, 1]);
		public static const GLOBAL_FILTER_Glow:GlowFilter = new GlowFilter(0, 1, 2, 2, 4, 1);
		//发光滤镜 红色
		public static const GLOBAL_FILTER_GlowRed:GlowFilter = new GlowFilter(0xff0000,0.8, 0.5, 0.5);
		//发光滤镜 黄色
		public static const GLOBAL_FILTER_GlowYellow:GlowFilter = new GlowFilter(0xffff00,0.8, 0.5, 0.5);
		public static const GLOBAL_FILTER_SHADOW_SERIOUS:DropShadowFilter = new DropShadowFilter(4);
		//strok
		public static const GLOBAL_FILTER_SHADOW:DropShadowFilter = new DropShadowFilter(0, 45, 0, 1, 2, 2, 10);
		//strok2
		public static const GLOBAL_FILTER_SHADOW2:DropShadowFilter = new DropShadowFilter(4, 45, 0XFFFFFF, 1, 2, 2, 10);
		//timerCounter
		public static const GLOBAL_FILTER_SHADOW_TIMERCOUNTER:DropShadowFilter = new DropShadowFilter(0, 45, 0, 1, 4, 4, 10);
		//timerCounter dps color
		public static const GLOBAL_FILTER_SHADOW_TIMERCOUNTER_COLOR:int = 0xfff2d0;
		//timerCounter txt color 红色
		public static const GLOBAL_TIMERCOUNTER_TEXTCOLOR:int = 0xff2d11;
		//timerCounter end txt color 绿色
		public static const GLOBAL_TIMERCOUNTER_END_TEXTCOLOR:int = 0x1d7a00;
		
		public static const GLOBAL_FILTER_COLOR:ColorMatrixFilter =new ColorMatrixFilter([1,1,1,1,1, 1/3,1/3,1/3,0,0,  1/3,1/3,1/3,0,0, 0,  0,  0,1,0])
		
		public static const GLOABL_FILTER_AVATAR_ROLL_OVER:Array = [new GlowFilter(0xFFA200, 1, 6, 6, 4)];
		//中国
		public static const VERSION_LANGUAGE_CN:String = "cn";
		//英语
		public static const VERSION_LANGUAGE_EN:String = "en";
		//越南
		public static const VERSION_LANGUAGE_VN:String = "vn";
		
		//玩家职业
		public static var PLAYER_JOB:int;
		
		//登录成功
		public static const LOGIN_SUCCESS:int = 1;
		//没有角色
		public static const NOT_HAVE_AVATAR:int = 2;
		//有角色
		public static const HAVE_MANY_AVATAR:int = 3;
		
		//游戏正常尺寸
		public static var STAGE_NORMAL_WIDTH:int = 1000;
		public static var STAGE_NORMAL_HEIGHT:int = 600;
		//游戏最大尺寸
		public static var STAGE_MAX_WIDTH:int =1600 /*1250*/;
		public static var STAGE_MAX_HEIGHT:int =818/* 650*/;
		
		//游戏最小尺寸
		public static var STAGE_MIN_WIDTH:int = 500;
		public static var STAGE_MIN_HEIGHT:int = 400;
		
		//游戏当前尺寸 根据窗口大小改变而改变
		public static var SCREEN_WIDTH:int = STAGE_MAX_WIDTH; //舞台宽度  
		public static var SCREEN_HEIGHT:int = STAGE_MAX_HEIGHT;//舞台高度
		
		//		public static const MAP_TOWN:int = 1;
		//		public static const MAP_DUNGEON:int = 2;
		
		public static const TIP2_WARN:int = 1;
		public static const TIP2_SUCCESS:int = 2;
		public static const TIP2_FAIL:int = 3;
		public static const TIP2_WAIT:int = 4;
		public static const TIP2_NORMAL:int = 5;
		
		public static const ALERT_BUTTON_YES:int=1;
		public static const ALERT_BUTTON_NO:int=2;
		public static const ALERT_BUTTON_CANCEL:int=3;
		
		public static const ITEM_QUALITY_LV0:int = 0xFFFFFF;      //白
		public static const ITEM_QUALITY_LV1:int = 0x51e500;      //绿
		public static const ITEM_QUALITY_LV2:int = 0x00deff;      //蓝
		public static const ITEM_QUALITY_LV3:int = 0xbc90ff;      //紫
		public static const ITEM_QUALITY_LV4:int = 0xffa200;      //橙
		public static const ITEM_QUALITY_LV5:int = 0xFF2A00;      //红
		public static const ITEM_QUALITY_LV6:int = 0xffe432;      //黄
		
		public static const TEXT_LINK_CHECK:String = "check";
		public static const TEXT_LINK_COPY:String = "copy";
		public static const TEXT_LINK_PLAYER:String = "player";
		public static const TEXT_LINK_ITEM:String = "item";
		public static const TEXT_LINK_HTML:String = "html";
		public static const TEXT_LINK_OPENUI:String = "openui";
		public static const TEXT_LINK_SHARE_MAP_POINT:String = "sharePoint";
		public static const TEXT_LINK_NPC:String = "npc";
		public static const TEXT_LINK_PATHFIND:String = "pathfind";
		public static const TEXT_LINK_TEAMINVITE:String = "teamInvite";
		
		public static const TIP_POWER_BATTLE:int = 0;
		public static const TIP_POWER_RANK:int = 1;
		public static const TIP_POWER_MONEY:int = 2;
		public static const TIP_POWER_TILI:int = 3;
		public static const TIP_SPECIAL_BATTLE:int = 4;
		
		public static const NPC_FUNCTION_FUBEN_ENTER:int = 1;
		public static const NPC_FUNCTION_WAREHOUSE:int = 2;
		public static const NPC_FUNCTION_ZHENYING:int = 3; //阵营任务面板
		public static const NPC_FUNCTION_SUPERSHOP:int = 4; 
		public static const NPC_FUNCTION_PAOSHANG_ACCEPT:int = 5; 
		public static const NPC_FUNCTION_PAOSHANG_SUBMIT:int = 6; 
		public static const NPC_FUNCTION_PET_FUBEN_ENTER:int = 7; 
		public static const NPC_FUNCTION_ZHENYING_FUBEN_ENTER:int = 15; 
		public static const NPC_FUNCTION_XUANSHANG:int = 16; 
		public static const NPC_FUNCTION_PA_TA:int = 17; 
		public static const NPC_FUNCTION_ARENA:int = 18; 
		public static const NPC_FUNCTION_STRONGPOINT:int = 19;
		public static const NPC_FUNCTION_ARMY_POINT_CENTER:int = 20; //军团战据点中心
		
		public static const CAMP1_ID:int = 1;  //第一阵营id
		public static const CAMP2_ID:int = 2; //第二阵营id
		
		public static const ACTIVITY_TRADE:int = 1;  //跑商活动id
		public static const ACTIVITY_CAMPBOSS:int = 2; //阵营boss活动id
		public static const ACTIVITY_WORLDBOSS:int = 3; //世界boss活动id
		public static const ACTIVITY_LORDTEAMBOSS:int = 4; //王城入侵者活动id
		
		public static const LINK_TEXT_HOME:int = 1;
		public static const LINK_TEXT_ENHANCE:int = 2;
		public static const LINK_TEXT_HOME_PHYSICALSTRENGTH:int = -1;
		public static const LINK_TEXT_PET:int = 3;
		public static const LINK_TEXT_DAILY:int = 4;
		public static const LINK_TEXT_BRAVE:int = 5;
		
		public static const DELAY_NOTIFY_ADDFRIEND:int = 1;
		public static const DELAY_NOTIFY_GM:int=2;
		public static const DELAY_NOTIFY_ARENA:int = 3;
		public static const DELAY_NOTIFY_OFFLINE:int = 4;
		public static const DELAY_NOTIFY_ONLINE:int = 5;
		public static const DELAY_NOTIFY_NORMAL:int = 6;
		public static const DELAY_NOTIFY_NORMAL1:int = 7;
		public static const DELAY_NOTIFY_YAOQIG_JUNTUAN:int = 8;//邀请军团
		public static const DELAY_NOTIFY_YAOQIG_TEAMDUNGEON:int = 9;//邀请组队
		public static const DELAY_NOTIFY_FRIEND_RECOMMEND:int = 10;//好友推荐
		public static const DELAY_NOTIFY_FRIEND_BLESS:int = 11;//好友祝福
		public static const DELAY_NOTIFY_VIP_OVER:int = 12;//vip过期提示
		
		public static const DELAY_NOTIFY_FLAGS_CALLBACK:int = 4; //点击按钮直接回调flag
		
		public static const VIP_MAX_LEVEL:int = 10;
		/**
		 * 对话任务 
		 */		
		public static const DIALOG_QUEST:Array =
			[
				Constants.QUEST_TITLE_REWARD
			]
		public static const COUNT_QUEST:Array =
			[
				Constants.CONDITION_YAOQIANTIME,
				Constants.CONDITION_JJCFIGHTCOUNTGREATER, 
				Constants.CONDITION_PET_JJC,
//				Constants.CONDITION_PATA_LEVEL,
				Constants.CONDITION_PATA_TIMES,
				Constants.CONDITION_COMPLETE_REWARD_TASK,
				Constants.CONDITION_COMPLETE_GUARD,
				Constants.CONDITION_HOME_GAIN
			]
		
		/**
		 * 任务状态的优先顺序 优先级越高的index越大
		 */		
		public static const QUESTSTATE_OREDR:Array = [
			Constants.QUEST_STATE_ACCEPT,
			Constants.QUEST_STATE_AVAILABLE,
			Constants.QUEST_STATE_COMPLETE 
		];
		
		public static function getColorByQuality(quality:int):int
		{
			var color:int = ClientConstants.ITEM_QUALITY_LV1;
			if(quality == 1){                     
				color = ClientConstants.ITEM_QUALITY_LV1;
			}else if(quality == 2){
				color = ClientConstants.ITEM_QUALITY_LV2;
			}else if(quality == 3){
				color = ClientConstants.ITEM_QUALITY_LV3;
			}else if(quality == 4){
				color = ClientConstants.ITEM_QUALITY_LV4;
			}else if(quality == 5){
				color = ClientConstants.ITEM_QUALITY_LV5;
			}else if(quality == 6){
				color = ClientConstants.ITEM_QUALITY_LV6;
			}
			
			return color;
			
		}
		
		public static const MONEY_TREE_SILVER_ICON:String = '1';
		
		public static const BATTLE_PET_APPEAR_EFFECT:int = 5;
		
		//普通攻击id
		public static const ROLE_PUTONG_ACTTACK_ID:int = 1000;
		//宠物普通攻击id
		public static const PET_PUTONG_ACTTACK_ID:int = 1001;
		
		public static const FIGHT_MOVE_ICON_ID:int = 1;
		
		
		//海底远景alpha
		public static const FAR_VIEW_ALPHA:Number = 0.2;
		//海底近景alpha
		public static const NEAR_VIEW_ALPHA:Number = 0.3;
		
		public static const MASK_ALPHA:Number = 0.5;
		
		//Avatar
		public static const AVATAR_PART_BOAT_DIE_MODEL_ID:int = 2900017;
		
		public static const AVATAR_SINGLE:int = 1;
		public static const AVATAR_ASSEMBLE:int = 2;
		
		public static const AVATAR_SIZE_SMALL:int = 1;
		public static const AVATAR_SIZE_MIDDEL:int = 2;
		public static const AVATAR_SIZE_BIG:int = 3;
		public static const AVATAR_SIZE_HUGE:int = 4;
		public static const AVATAR_SIZE_FLY_SHIP:int = 5;
		
		public static const AVATAR_FONT_SEIZE:int = 12;
		public static const AVATAR_FONT_NAME:String = "Verdana";
		public static const AVATAR_HTML_NAME_TEMPALTE:String = "<b><font face='{0}' color='#{1}' size='{2}'>{3}</font></b>";
		
		public static const SAME_CORPS_HEAD_NAME_COLOR:uint = 0x00deff;
		public static const SAME_CORPS_PK_HEAD_NAME_COLOR:uint = 0x036978;
		
		public static const SELF_SAME_CAMP_HEAD_NAME_COLOR:uint = 0xfff2b7;
		public static const SELF_SAME_CAMP_PK_HEAD_NAME_COLOR:uint = 0xe7cca1;
		
		public static const SAME_CAMP_HEAD_NAME_COLOR:uint = 0x51e500;
		public static const SAME_CAMP_PK_HEAD_NAME_COLOR:uint = 0x017326;
		
		public static const NOT_SAME_CAMP_HEAD_NAME_COLOR:uint = 0x954eff;
		public static const NOT_SAME_CAMP_PK_HEAD_NAME_COLOR:uint = 0xff0000;
		
		public static const MAIN_MONSTER_HEAD_NAME_COLOR:uint = 0xfef900;
		
		public static const NPC_HEAD_NAME_COLOR:uint = 0xffff00;
		public static const OTHER_HEAD_NAME_COLOR:uint = 0xFFFFFF;
		
		public static const ATTACK_MONSTER_NAME_COLOR:uint = 0xff0000;
		public static const UN_ATTACK_MONSTER_NAME_COLOR:uint = 0x51e500;
		
		public static const BOAT_DEATH_SOUND_EFFECT_ID:int = 1;
		public static const MONSTER_DEATH_SOUND_EFFECT_ID:int = 2;
		
		//MAP===================================================================
		public static const MAP_GRID_WIDTH:int = 30;
		public static const MAP_GRID_HALF_WIDTH:int = MAP_GRID_WIDTH >> 1;
		
		public static const WAR_NUM_COLS:int = 8;
		public static const WAR_NUM_ROWS:int = 5;
		public static const WAR_GRID_WIDTH:int = 116;
		public static const WAR_GRID_HEIGHT:int = 90;
		public static const WAR_GRID_HALF_WIDTH:int = WAR_GRID_WIDTH >> 1;
		public static const WAR_GRID_HALF_HEIGHT:int = WAR_GRID_HEIGHT >> 1;
		public static const WAR_GRID_TOTAL_WIDTH:Number = WAR_GRID_WIDTH * WAR_NUM_COLS;
		public static const WAR_GRID_TOTAL_HEIGHT:Number = WAR_GRID_HEIGHT * WAR_NUM_ROWS;
		
		public static const MAP_FROG_OF_WAR_GRID_WIDTH:int = 512;
		public static const HALF_MAP_FROG_OF_WAR_GRID_WIDTH:int = MAP_FROG_OF_WAR_GRID_WIDTH >> 1;
		
		public static const QUARTER_MAP_FROG_OF_WAR_GRID_WIDTH:int = HALF_MAP_FROG_OF_WAR_GRID_WIDTH >> 1;
		public static const THREE_QUARTER_MAP_FROG_OF_WAR_GRID_WIDTH:int = (MAP_FROG_OF_WAR_GRID_WIDTH - QUARTER_MAP_FROG_OF_WAR_GRID_WIDTH) >> 1;
		
		public static const HALF_QUARTER_MAP_FROG_OF_WAR_GRID_WIDTH:int = QUARTER_MAP_FROG_OF_WAR_GRID_WIDTH >> 1;
		public static const THREE_HALF_QUARTER_MAP_FROG_OF_WAR_GRID_WIDTH:int = (MAP_FROG_OF_WAR_GRID_WIDTH - HALF_QUARTER_MAP_FROG_OF_WAR_GRID_WIDTH) >> 1;
		
		public static const MAP_FROG_BITMAP_WIDTH:int = 128;
		
		public static const SHARE_OBJECT_CACHE_MANAGER_SWIP_TIME:int = 60000;//MS
		
		public static const WAR_ACTION_EFFECT_ID:int = 7100006;
		
		public static const WAR_SCLIENT_SKILL_BUFF_TYEPE_ID:int = 2;
		
		public static const WAR_ESCAPE_EFFECT_ID:int = 7100274;
		public static const WAR_ESCAPE_FAILED_EFFECT_ID:int = 7100275;
		
		public static const WEATHER_UPDATE_TIME:Number = 5 * 60; 
		
		//----------------------------------------------------
		
		public static const TAVERN_HERO_STATE_NO_RECRUIT:int = 0;	//未激活 无法招募
		
		public static const TAVERN_HERO_TYPE_JUQING:int = 1;	//剧情将
		public static const TAVERN_HERO_TYPE_JUEWEI:int = 2;	//爵位将
		public static const TAVERN_HERO_TYPE_JUNXIAN:int = 3;	//军衔将
		public static const TAVERN_HERO_TYPE_HERO_CARD:int = 4;	//英雄卡将
		
		public static const SHOP_LABEL_QIANG:int = 1;	//抢购
		public static const SHOP_LABEL_LIMIT:int = 2;	//限购
		public static const SHOP_LABEL_SELL:int = 3;	//打折
		public static const SHOP_LABEL_HOT:int = 4;		//热卖
		
		public static const SUPER_SHOP_HOT_PAGE:String = "hotPage";
		public static const SUPER_SHOP_NOT_HOT_PAGE:String = "notHotPage";
		
		public static const OUT_OFF_GREEN_HAND_LEVEL:int = 45;//新手等级
		public static const OTHER_PLAYER_VISIBLE_LEVEL:int = 5;//其他玩家
		public static const DRAMMA_DIALOG_SHOW_SPEED:Number = 10;//剧情文字显示速度,单位字符每秒， 0表示立即显示
		public static const DRAMMA_DIALOG_MAX_WAIT_CLICK_TIME:Number = 10;//s
		
		public static const SUPERSHOP_BUY_ITEMID:int = 3100003;
		
		//----------------------------------------------------
		
		public static const PLAYER_LEVEL_MAX:int = 80; //玩家最大等级
		public static const MAX_VIP_LEVEL:int = 10;//vip最高等级
		
		public static const VIP_MONTH_CARD_ID:int = 3;
		public static const VIP_SEASON_CARD_ID:int = 4;
		public static const VIP_HALF_YEAR_CARD_ID:int = 5;
		
		public static const VIP_TYPE_NONE:int = 0; //非vip
		public static const VIP_TYPE_DIAMOND:int = 1; //钻石vip
		public static const VIP_TYPE_SUPREMACY:int = 2;	//至尊vip
		
		//家园npc类型
		public static const HOME_NPC_TYPE1:int = 1;
		public static const HOME_NPC_TYPE2:int = 2;
		public static const HOME_NPC_TYPE3:int = 3;
		public static const HOME_NPC_TYPE4:int = 4;
		public static const HOME_NPC_TYPE5:int = 5;
		public static const HOME_NPC_TYPE6:int = 6;
		public static const HOME_NPC_TYPE7:int = 7	;
		
		public static const SEAMAP_FLIGHTICON_OFFSETX:int = 10;//场景地图上飞行Icon与鼠标点击点的偏移量X
		public static const SEAMAP_FLIGHTICON_OFFSETY:int = 10;//场景地图上飞行Icon与鼠标点击点的偏移量Y
		
		public static const OPENGIFTPANEL_BTN_TYPE_CLAIM:int = 1;//1: 领取奖励
		public static const OPENGIFTPANEL_BTN_TYPE_CLAIM_LATER:int = 2;//2：稍后领取
		public static const OPENGIFTPANEL_BTN_TYPE_CLOSE:int = 3;//3：关闭
		public static const OPENGIFTPANEL_BTN_TYPE_CLAIMED:int = 4;//4：已领取
		
		//激活码
		public static var usePackageCodeUrl:String = "";
		public static var packagelist:String = "";
		
		public static var FACTION_WUZI_CENTER_TYPE:int = 1; //物资中心
		public static var FACTION_JINGJI_CENTER_TYPE:int = 2; //经济中心
		public static var FACTION_KEJI_CENTER_TYPE:int = 3;	//科技中心
		public static var FACTION_ZHIHUI_CENTER_TYPE:int = 4;	//指挥中心
		public static var FACTION_FANGYU_CENTER_TYPE:int = 5;	//防御中心
		public static var FACTION_ZAOCHUAN_CENTER_TYPE:int = 6;	//造船厂
		public static var FACTION_ZHANSHU_CENTER_TYPE:int = 7;	//战术中心
		//vk
		public static var THIRD_PART_PLAT_FROM_INTERFACE:String="";// vk与js协议当thirdPartPlatform=vk的时候vk按钮才会出现
		
		public static const ITEM_TYPE_ADDBUFF_HP:int = 11;
		//战斗评分系统
		public static const FIGHTPOINT_TYPE_EQUIPUPDATE:String = "equipUpdate";//装备升级
		public static const FIGHTPOINT_TYPE_EQUIPUPLEVEL:String = "equipUpLevel";//装备升阶
		public static const FIGHTPOINT_TYPE_MORE:String = "more";//更多
		public static const FIGHTPOINT_TYPE_FIRSTRECHARGE:String = "shouchong";//首充
		
		public static const TYPE_PATH_GET_PET:int = 1;
		public static const TYPE_PATH_GET_SHIP:int = 2;
		
		public static const newPopUseItemIdList:Array = [3800001, 3800002, 3800003, 3800004, 3800005, 3800006, 3800007, 3800008, 3800009, 3800010];
	}
}