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
public class V114EventHandler extends BaseClientRequestHandler {
	public V114EventHandler(){
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
		SFSObject so_77884 = new SFSObject();
		 so_77884.putUtfString("c","\"vipIsCheckPokerV\":true,\"firstLoginBacc\":false,\"selectedChips\":100,\"chips\":[1,5,10,50,100],\"videoLine\":3,\"isMusicOn\":false,\"14102800003\":true,\"14121200007\":true,\"isSoundOn\":false,\"multipleGameServerIDs\":\"15092300018,15092300021,14102800003,14102800001\",\"14121600013\":true,\"vipIsCheckPoker\":true,\"selectedLimit\":\"1 - 1000\",\"14121200008\":true,\"vipIsAutoFlipFirstPoker\":false,\"14102800002\":true,\"vipIsAutoOpenOtherPoker\":true,\"14121600011\":true,\"14102800001\":true,\"multipleChips\":50,\"14121200009\":true");
		  
		 send("114",so_77884,arg0);
	}
}//end V226EventHandler