package sfs2x.extension.egame.sever;

import sfs2x.extension.egame.sever.game.BaccaratGame;
import sfs2x.extension.egame.sever.game.EGame;
import sfs2x.extension.egame.sever.game.SafeBlackJackGame;
import sfs2x.extension.egame.sever.game.SicboGame;


/**
 * @author Administrator
 * @version 1.0
 * @created 25-七月-2016 16:26:40
 */
public class EgameFactory {

	private static EGame game;
	public EgameFactory(){

	}

	public void finalize() throws Throwable {

	}
	/**
	 * 需要检查game的生命周期;
	 * @param name
	 */
	public static EGame createEgame(String zoneName){
		if(zoneName!=""||zoneName != null)
			{
				game = null;
			}
		switch(zoneName){
		case GameConfig.BACCARAT_ZONE:
			game = new BaccaratGame();
			break;
		case GameConfig.SICBO_ZONE:
			game = new SicboGame();
			break;
		case GameConfig.SAFEBLACKJACK_ZONE:
			game = new SafeBlackJackGame();
			break;
		}
	
		if(game ==null)
		{
			throw new Error("没有找到相关的空间:"+zoneName);
		}
		return getGame();
		
	}

	public static EGame getGame() {
		return game;
	}

	private static void setGame(EGame game) {
		EgameFactory.game = game;
	}
	
}//end EgameFactory