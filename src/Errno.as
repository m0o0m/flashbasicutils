package	
{
	public class Errno
	{	
		public static const SUCCESS:int = 0;
		public static const CLIENT_ERROR:int = 1;
		public static const SERVER_ERROR:int = 2;
		public static const SERVER_CANNOT_CONNECT:int = 101;
		public static const SERVER_CONNECTION_CLOSED:int = 102;
		public static const PACK_CAPACITY_NOTENOUGH:int = 400;
		public static const DUNGEON_REWARD_CAPACITY_NOTENOUGH:int = 201;
		public static const DUNGEON_QUICKFINISH_FAILED:int = 202;
		public static const DUNGEON_INCREASECHALLENGETIMES_FAILED:int = 203;
		public static const GUARD_REQUEST_FAIL:int = 220;
		public static const GUARD_REQUEST_REFRESH_FAIL:int = 221;
		public static const GUARD_REQUEST_PUTGOODS_FAIL:int = 222;
		public static const GUARD_REQUEST_CONTINUE_FAIL:int = 223;
		public static const GUARD_REQUEST_PUTGOODS_SUCCESS:int = 224;
		public static const GUARD_REQUEST_CONTINUE_SUCCESS:int = 225;
		public static const PATAFUBEN_CHALLENGE_REQUEST_SUCCESS:int = 226;
		public static const PATAFUBEN_CHALLENGE_REQUEST_FAIL:int = 227;
		public static const PATAFUBEN_REFRESH_REQUEST_SUCCESS:int = 228;
		public static const PATAFUBEN_REFRESH_REQUEST_FAIL:int = 229;
		public static const PATAFUBEN_RELIVE_REQUEST_SUCCESS:int = 230;
		public static const PATAFUBEN_RELIVE_REQUEST_FAIL:int = 231;
		public static const PATAFUBEN_AUTO_CHALLENGE_OVER:int = 232;
		public static const ARMY_CHANGE_MEMBER_POSITION_SUCCESS:int = 233;
		public static const ARMY_CHANGE_MEMBER_POSITION_FAIL:int = 234;
		public static const PRESENT_ACTIVATE_CODE_NOT_EXIST:int = 301;
		public static const PRESENT_ACTIVATE_CODE_ALREADY_USED:int = 302;
		public static const PRESENT_APPLY_FAIL:int = 303;
		public static const PRESENT_REGIONID_NOTMATCH:int = 304;
		public static const PRESENT_PLAYERID_NOTMATCH:int = 305;
		public static const PRESENT_REPEAT_SAME:int = 306;
		
		public static const ALL:Array = [
			0,
			1,
			2,
			101,
			102,
			400,
			201,
			202,
			203,
			220,
			221,
			222,
			223,
			224,
			225,
			226,
			227,
			228,
			229,
			230,
			231,
			232,
			233,
			234,
			301,
			302,
			303,
			304,
			305,
			306,
			'__dummy'
		];
		
		public static const LEVEL_NORMAL:Array = [
			101,
			102,
			400,
			201,
			202,
			203,
			220,
			221,
			222,
			223,
			224,
			225,
			226,
			227,
			228,
			229,
			230,
			231,
			232,
			233,
			234,
			301,
			302,
			303,
			304,
			305,
			306,
			'__dummy'
		];
		
		public function Errno() 
		{
		}
	}
}
