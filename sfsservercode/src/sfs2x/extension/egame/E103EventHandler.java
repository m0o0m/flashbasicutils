package sfs2x.extension.egame;

import sfs2x.extension.egame.sever.EgameFactory;
import sfs2x.extension.egame.sever.game.EGame;
import sfs2x.extension.egame.sever.request.E103Request;

import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.entities.data.SFSObject;
import com.smartfoxserver.v2.extensions.BaseClientRequestHandler;


/**
 * @author Administrator
 * @version 1.0
 * @created 26-七月-2016 11:35:27
 */
public class E103EventHandler extends BaseClientRequestHandler {

	public E103EventHandler(){

	}

	public void finalize() throws Throwable {
		super.finalize();
	}
	/**
	 * 
	 * @param arg0
	 * @param arg1
	 */
	@Override
	public void handleClientRequest(User arg0, ISFSObject arg1){
		SFSObject so = new SFSObject();
		EGame game = EgameFactory.getGame();
		game.setRequest(new E103Request("103"));
		game.sendData(so);
		send("103",so,arg0);
	}
}//end E103EventHandler