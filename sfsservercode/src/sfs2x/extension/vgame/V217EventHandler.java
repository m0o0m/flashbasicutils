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
public class V217EventHandler extends BaseClientRequestHandler {
	public SFSObject so_829 = new SFSObject();
	public V217EventHandler(){
		initData();
	}

	public void finalize() throws Throwable {
		super.finalize();
	}
	public void initData(){
		
		 so_829.putInt("ls",12);
		 so_829.putUtfString("s","14102800002");
		 
	}
	/**
	 * 
	 * @param arg0
	 * @param arg1
	 */
	@Override
	public void handleClientRequest(User arg0, ISFSObject arg1){
		
		 send("227",so_829,arg0);
		
	}
}//end V227EventHandler