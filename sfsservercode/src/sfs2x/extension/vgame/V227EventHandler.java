package sfs2x.extension.vgame;

import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.entities.data.SFSObject;
import com.smartfoxserver.v2.extensions.BaseClientRequestHandler;


/**
 * @author Administrator
 * @version 1.0
 * @created 03-八月-2016 16:36:50
 */
public class V227EventHandler extends BaseClientRequestHandler {

	public V227EventHandler(){

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
		
		SFSObject so_14436 = new SFSObject();
		 so_14436.putInt("p",94);
		 so_14436.putUtfString("s","15092300018");
		 so_14436.putDouble("t",820697.0499999999);
		 so_14436.putUtfString("g","Dice");
		 

		 send("227",so_14436,arg0);
	}
}//end V227EventHandler