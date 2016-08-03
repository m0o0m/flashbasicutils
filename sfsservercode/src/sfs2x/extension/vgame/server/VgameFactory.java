package sfs2x.extension.vgame.server;

import com.smartfoxserver.v2.exceptions.SFSException;

import sfs2x.extension.vgame.server.game.HallGame;
import sfs2x.extension.vgame.server.game.VGame;


/**
 * @author Administrator
 * @version 1.0
 * @created 02-八月-2016 16:16:02
 */
public class VgameFactory {

	private static VGame game;

	public VgameFactory(){

	}

	/**
	 * 
	 * @exception Throwable
	 */
	public void finalize()
	  throws Throwable{

	}

	/**
	 * 需要检查game的生命周期;
	 * @param name
	 * 
	 * @param zoneName    name
	 */
	public static VGame createEgame(String zoneName){
		if(zoneName!=""||zoneName != null)
		{
			game = null;
		}
	switch(zoneName){
	case GameConfig.HALL:
		game = new HallGame();
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
	

	public static VGame getGame(){
		return game;
	}

	/**
	 * 
	 * @param game
	 */
	private static void setGame(VGame game){
		VgameFactory.game = game;
	}
}//end VgameFactory