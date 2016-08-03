package sfs2x.extension.vgame.server;

import java.util.HashMap;


/**
 * @author Administrator
 * @version 1.0
 * @created 02-八月-2016 16:16:02
 */
public class GameConfig {

	public static String gameType;
	public static final String HALL = "hall";
	public static HashMap<String,String> hm=new HashMap<String,String>() ;
	public GameConfig(){
	}

	public void finalize() throws Throwable {

	}
	public static String getCurrentGameName(){
		
		return hm.get(gameType);
	}
}//end GameConfig