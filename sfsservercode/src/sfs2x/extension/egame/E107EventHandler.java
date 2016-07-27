package sfs2x.extension.egame;

import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.entities.data.SFSObject;
import com.smartfoxserver.v2.extensions.BaseClientRequestHandler;


/**
 * @author Administrator
 * @version 1.0
 * @created 27-七月-2016 10:23:14
 */
public class E107EventHandler extends BaseClientRequestHandler {

	public E107EventHandler(){

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
		send("107",so,arg0);
	}
}//end E107EventHandler