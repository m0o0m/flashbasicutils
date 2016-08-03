package sfs2x.extension.vgame;

import sfs2x.extension.vgame.PingEventHandler;
import sfs2x.extension.vgame.server.GameConfig;

import com.smartfoxserver.v2.core.SFSEventType;
import com.smartfoxserver.v2.extensions.SFSExtension;


/**
 * @author Administrator
 * @version 1.0
 * @created 02-八月-2016 16:04:44
 */
public class VGameLogin extends SFSExtension {

	public VGameLogin(){

	}

	public void finalize() throws Throwable {
		super.finalize();
	}
	@Override
	public void destroy(){

	}

	@Override
	public void init(){
		GameConfig.hm.put(GameConfig.HALL, "Hall");
		addEventHandler(SFSEventType.USER_LOGIN, VLoginEventHandler.class);
		addRequestHandler("101",PingEventHandler.class);
		addRequestHandler("104",V104EventHandler.class);
		addRequestHandler("110",V110EventHandler.class);
		addRequestHandler("201",V201EventHandler.class);
		addRequestHandler("202",V202EventHandler.class);
		addRequestHandler("204",V204EventHandler.class);
		addRequestHandler("226",V226EventHandler.class);
		addRequestHandler("227",V227EventHandler.class);
	}
}//end VGameLogin