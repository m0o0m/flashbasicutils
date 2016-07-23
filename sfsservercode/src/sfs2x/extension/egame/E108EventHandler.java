package sfs2x.extension.egame;

import com.smartfoxserver.v2.core.ISFSEvent;
import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.entities.data.SFSObject;
import com.smartfoxserver.v2.exceptions.SFSException;
import com.smartfoxserver.v2.extensions.BaseClientRequestHandler;
import com.smartfoxserver.v2.extensions.BaseServerEventHandler;

public class E108EventHandler extends BaseClientRequestHandler {


	@Override
	public void handleClientRequest(User arg0, ISFSObject arg1) {
		// TODO Auto-generated method stub
		SFSObject so = new SFSObject();
		so.putInt("errorCode", 0);
		SFSObject so_so = new SFSObject();
		so.putSFSObject("pokers", so_so);
		so_so.putUtfString("b", "1,3,4;8");
		so_so.putDouble("balance", 496.7);
		
		send("108",so,arg0);
	}

}
