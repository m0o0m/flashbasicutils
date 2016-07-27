package sfs2x.extension.egame.sever;

import com.smartfoxserver.v2.exceptions.SFSException;
import com.smartfoxserver.v2.exceptions.SFSLoginException;

import sfs2x.extension.egame.sever.game.BaccaratGame;
import sfs2x.extension.egame.sever.game.BlackJackGame;
import sfs2x.extension.egame.sever.game.CaribbeanGame;
import sfs2x.extension.egame.sever.game.EGame;
import sfs2x.extension.egame.sever.game.FreeBaccaratGame;
import sfs2x.extension.egame.sever.game.LonghuGame;
import sfs2x.extension.egame.sever.game.NiuGame;
import sfs2x.extension.egame.sever.game.RouletteGame;
import sfs2x.extension.egame.sever.game.SafeBlackJackGame;
import sfs2x.extension.egame.sever.game.SangongGame;
import sfs2x.extension.egame.sever.game.SicboGame;
import sfs2x.extension.egame.sever.game.TexasGame;
import sfs2x.extension.egame.sever.game.YuGame;


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
	 * @throws SFSException 
	 */
	public static EGame createEgame(String zoneName) {
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
		case GameConfig.BLACKJACK_ZONE:
			game = new BlackJackGame();
			break;
		case GameConfig.CARIBBEAN_ZONE:
			game = new CaribbeanGame();
			break;
		case GameConfig.FREEBACCARAT_ZONE:
			game = new FreeBaccaratGame();
			break;
		case GameConfig.LONGHU_ZONE:
			game = new LonghuGame();
			break;
		case GameConfig.NIU_ZONE:
			game = new NiuGame();
			break;
		case GameConfig.ROULETTE_ZONE:
			game = new RouletteGame();
			break;
		case GameConfig.SANGONG_ZONE:
			game = new SangongGame();
			break;
		case GameConfig.TEXAS_ZONE:
			game = new TexasGame();
			break;
		case GameConfig.YU_ZONE:
			game = new YuGame();
			break;
		}
	
		if(game ==null)
		{
			//throw new Error("没有找到相关的空间:"+zoneName);
			try {
				throw new SFSException("没有找到相关的空间:"+zoneName);
			} catch (SFSException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
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