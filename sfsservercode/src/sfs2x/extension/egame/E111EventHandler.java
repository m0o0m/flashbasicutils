package sfs2x.extension.egame;

import sfs2x.extension.egame.sever.EgameFactory;
import sfs2x.extension.egame.sever.game.EGame;
import sfs2x.extension.egame.sever.request.E109Request;
import sfs2x.extension.egame.sever.request.E111Request;

import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.entities.data.SFSObject;
import com.smartfoxserver.v2.extensions.BaseClientRequestHandler;


/**
 * @author Administrator
 * @version 1.0
 * @created 26-七月-2016 18:02:43
 */
public class E111EventHandler extends BaseClientRequestHandler {

	public E111EventHandler(){

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
		game.setRequest(new E111Request("111"));
		game.sendData(so);
		
		send("111",so,arg0);
	}
}//end E111EventHandler