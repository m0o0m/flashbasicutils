package sfs2x.extension.egame;

import sfs2x.extension.egame.sever.EgameFactory;
import sfs2x.extension.egame.sever.GameConfig;
import sfs2x.extension.egame.sever.game.EGame;
import sfs2x.extension.egame.sever.request.ELoginRequest;

import com.smartfoxserver.bitswarm.sessions.ISession;
import com.smartfoxserver.v2.core.ISFSEvent;
import com.smartfoxserver.v2.core.SFSEventParam;
import com.smartfoxserver.v2.entities.SFSZone;
import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.entities.data.SFSArray;
import com.smartfoxserver.v2.entities.data.SFSObject;
import com.smartfoxserver.v2.exceptions.SFSException;
import com.smartfoxserver.v2.extensions.BaseServerEventHandler;

public class ELoginEventHandler extends BaseServerEventHandler {

	@Override
	public void handleServerEvent(ISFSEvent event) throws SFSException {
		// TODO Auto-generated method stub
		String userName = (String) event.getParameter(SFSEventParam.LOGIN_NAME);
		//User user =(User) event.getParameter(SFSEventParam.USER);
		//ISFSObject sfso = new SFSObject();
		//The custom data to return to the user after a successful login 
		//用户还没有登录到系统中,所以没有user
		//send("login",sfso,user);
		SFSZone zone =(SFSZone) event.getParameter(SFSEventParam.ZONE);
		ISFSObject outData = (ISFSObject) event.getParameter(SFSEventParam.LOGIN_OUT_DATA);
		GameConfig.gameType = zone.getName();
		EGame game = EgameFactory.createEgame(zone.getName());
		game.setRequest(new ELoginRequest());
		game.sendData((SFSObject)outData);
	}

}
