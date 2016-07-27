package sfs2x.extension.egame;

import sfs2x.extension.egame.sever.EgameFactory;
import sfs2x.extension.egame.sever.game.EGame;
import sfs2x.extension.egame.sever.request.E109Request;
import sfs2x.extension.egame.sever.request.E110Request;

import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.entities.data.SFSObject;
import com.smartfoxserver.v2.extensions.BaseClientRequestHandler;


/**
 * @author Administrator
 * @version 1.0
 * @created 26-七月-2016 16:42:27
 */
public class E110EventHandler extends BaseClientRequestHandler {

	public E110EventHandler(){

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
		EGame game = EgameFactory.getGame();
		game.setRequest(new E110Request("110"));
		SFSObject so = new SFSObject();
		game.sendData(so);
		
		send("110",so,arg0);
	}
}//end E110EventHandler