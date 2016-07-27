package sfs2x.extension.egame;

import sfs2x.extension.egame.sever.EgameFactory;
import sfs2x.extension.egame.sever.game.EGame;
import sfs2x.extension.egame.sever.request.E104Request;
import sfs2x.extension.egame.sever.request.E108Request;

import com.smartfoxserver.v2.core.ISFSEvent;
import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.entities.data.SFSObject;
import com.smartfoxserver.v2.exceptions.SFSException;
import com.smartfoxserver.v2.extensions.BaseClientRequestHandler;
import com.smartfoxserver.v2.extensions.BaseServerEventHandler;

public class E104EventHandler extends BaseClientRequestHandler {


	@Override
	public void handleClientRequest(User arg0, ISFSObject arg1) {
		// TODO Auto-generated method stub
		
		
//		EGame game = EgameFactory.getGame();
//		game.setRequest(new E104Request());
//		game.sendData(so);
		SFSObject so = new SFSObject();
		so.putInt("errorCode", 0);
		send("104",so,arg0);
		getApi().logout(arg0);
	}

}
