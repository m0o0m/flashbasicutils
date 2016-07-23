package sfs2x.extension.egame;

import com.smartfoxserver.v2.core.ISFSEvent;
import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.entities.data.SFSArray;
import com.smartfoxserver.v2.entities.data.SFSObject;
import com.smartfoxserver.v2.exceptions.SFSException;
import com.smartfoxserver.v2.extensions.BaseClientRequestHandler;
import com.smartfoxserver.v2.extensions.BaseServerEventHandler;

public class E109EventHandler extends BaseClientRequestHandler {


	@Override
	public void handleClientRequest(User arg0, ISFSObject arg1) {
		// TODO Auto-generated method stub
		SFSObject so = new SFSObject();
		so.putInt("state", 0);
		SFSArray sa = new SFSArray();
		so.putSFSArray("betList", sa);
		SFSObject sa_so = new SFSObject();
		sa.addSFSObject(sa_so);
		sa_so.putInt("id", 502);
		sa_so.putDouble("money", -5);
		so.putDouble("balance", 496.7);
		send("109",so,arg0);
	}

}
