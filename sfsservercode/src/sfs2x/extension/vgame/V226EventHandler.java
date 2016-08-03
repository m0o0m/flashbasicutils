package sfs2x.extension.vgame;

import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.entities.data.SFSObject;
import com.smartfoxserver.v2.extensions.BaseClientRequestHandler;


/**
 * @author Administrator
 * @version 1.0
 * @created 03-八月-2016 16:33:06
 */
public class V226EventHandler extends BaseClientRequestHandler {

	public V226EventHandler(){

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
		SFSObject so_56018 = new SFSObject();
		 so_56018.putUtfString("g","Dice");
		 so_56018.putUtfString("s","15092300018");
		 so_56018.putUtfString("dn","Hogoxes");
		 so_56018.putUtfString("du","/imgs/f180fe3a-8ea8-41ea-9195-43a45bb7c21d.272.jpg");
		 send("226",so_56018,arg0);
	}
}//end V226EventHandler