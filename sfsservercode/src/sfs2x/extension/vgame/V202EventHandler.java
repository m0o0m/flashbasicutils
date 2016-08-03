package sfs2x.extension.vgame;

import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.entities.data.SFSObject;
import com.smartfoxserver.v2.extensions.BaseClientRequestHandler;


/**
 * @author Administrator
 * @version 1.0
 * @created 03-八月-2016 16:44:22
 */
public class V202EventHandler extends BaseClientRequestHandler {

	public V202EventHandler(){

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
		SFSObject so_54013 = new SFSObject();
		 so_54013.putUtfString("s","15092300018");
		 so_54013.putInt("a",1);
		 so_54013.putInt("l",30);
		 send("202",so_54013,arg0);
	}
}//end V202EventHandler