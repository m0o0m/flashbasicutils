package sfs2x.extension.egame;

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
		SFSObject so = new SFSObject();
		so.putDouble("balacne", 492.7);
		send("104",so,arg0);
	}

}
