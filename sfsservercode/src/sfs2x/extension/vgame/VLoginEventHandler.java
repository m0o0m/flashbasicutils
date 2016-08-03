package sfs2x.extension.vgame;

import sfs2x.extension.vgame.server.GameConfig;
import sfs2x.extension.vgame.server.VgameFactory;
import sfs2x.extension.vgame.server.game.VGame;
import sfs2x.extension.vgame.server.request.VLoginRequest;

import com.smartfoxserver.v2.core.ISFSEvent;
import com.smartfoxserver.v2.core.SFSEventParam;
import com.smartfoxserver.v2.entities.SFSZone;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.entities.data.SFSObject;
import com.smartfoxserver.v2.exceptions.SFSException;
import com.smartfoxserver.v2.extensions.BaseServerEventHandler;


/**
 * @author Administrator
 * @version 1.0
 * @created 02-八月-2016 16:04:44
 */
public class VLoginEventHandler extends BaseServerEventHandler {

	public VLoginEventHandler(){

	}

	public void finalize() throws Throwable {
		super.finalize();
	}
	/**
	 * 
	 * @param event
	 * @exception SFSException
	 */
	@Override
	public void handleServerEvent(ISFSEvent event)
	  throws SFSException{
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
		VGame game = VgameFactory.createEgame(zone.getName());
		game.setRequest(new VLoginRequest("Login"));
		game.sendData((SFSObject)outData);
	}
}//end VLoginEventHandler