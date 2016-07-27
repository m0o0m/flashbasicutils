package sfs2x.extension.egame;

import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.entities.data.SFSObject;
import com.smartfoxserver.v2.extensions.BaseClientRequestHandler;


/**
 * @author Administrator
 * @version 1.0
 * @created 27-七月-2016 10:36:29
 */
public class E105EventHandler extends BaseClientRequestHandler {

	public E105EventHandler(){

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
		so.putDouble("balance", 22.56);//可转换余额;
		so.putInt("errorCode", 0);
		send("105",so,arg0);
	}
}//end E105EventHandler