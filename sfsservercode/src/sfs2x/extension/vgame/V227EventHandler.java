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
	public SFSObject so = new SFSObject();
	public V227EventHandler(){
		initData();
	}

	public void finalize() throws Throwable {
		super.finalize();
	}
	public void initData(){
		
		so.putInt("p",176);
		 so.putUtfString("s","14102800002");
		 so.putDouble("t",820697.0499999999);
		 so.putUtfString("g","Baccarat");
		
	}
	/**
	 * 
	 * @param arg0
	 * @param arg1
	 */
	@Override
	public void handleClientRequest(User arg0, ISFSObject arg1){
		
		
		 

		 send("227",so,arg0);
		 
	}
}//end V227EventHandler