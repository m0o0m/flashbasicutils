package sfs2x.extension.egame.sever;

import java.util.HashMap;



/**
 * @author Administrator
 * @version 1.0
 * @created 25-七月-2016 11:18:08
 */
public class GameConfig {

	public static String gameType;
	public  static final String BACCARAT_ZONE =  "Bacc";//"百家乐";
	public  static final String FREEBACCARAT_ZONE =  "FreeBacc";//"免用百家乐";
	public  static final String BLACKJACK_ZONE =  "BlackJack";//"21点";
	public  static final String SAFEBLACKJACK_ZONE =  "SafeBlackJack";//"保险21点";
	public  static final String LONGHU_ZONE =  "LongHu";//龙虎斗";
	public  static final String CARIBBEAN_ZONE =  "Caribbean";//加勒比扑克";
	public  static final String SANGONG_ZONE =  "SanGong";//三公";
	public  static final String SICBO_ZONE =  "ShaiZi";//"骰宝";
	public  static final String YU_ZONE =  "YuXiaXie";//鱼虾蟹";
	public  static final String NIU_ZONE =  "NiuNiu";//牛牛";
	public  static final String ROULETTE_ZONE =  "Roulette";//轮盘";
	public  static final String TEXAS_ZONE =  "Texas";//德州扑克";
	public static HashMap<String,String> hm=new HashMap<String,String>() ;
	public GameConfig(){
	}

	public void finalize() throws Throwable {

	}
	public static String getCurrentGameName(){
		
		return hm.get(gameType);
	}
}//end GameConfig