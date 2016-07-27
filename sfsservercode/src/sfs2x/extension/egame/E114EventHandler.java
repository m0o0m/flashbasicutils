package sfs2x.extension.egame;

import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.entities.data.SFSObject;
import com.smartfoxserver.v2.extensions.BaseClientRequestHandler;


/**
 * @author Administrator
 * @version 1.0
 * @created 26-七月-2016 18:30:57
 */
public class E114EventHandler extends BaseClientRequestHandler {

	public E114EventHandler(){

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
		so.putInt("errorCode", 0);
		so.putInt("na", 0);
		send("114",so,arg0);
	}
}//end E114EventHandler