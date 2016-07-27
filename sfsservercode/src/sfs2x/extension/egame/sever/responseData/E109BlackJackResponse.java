package sfs2x.extension.egame.sever.responseData;

import com.smartfoxserver.v2.entities.data.SFSArray;
import com.smartfoxserver.v2.entities.data.SFSObject;


/**
 * @author Administrator
 * @version 1.0
 * @created 27-七月-2016 15:21:01
 */
public class E109BlackJackResponse extends EGameResponse {

	public E109BlackJackResponse(){

	}

	/**
	 * 
	 * @exception Throwable Throwable
	 */
	public void finalize()
	  throws Throwable{

	}

	/**
	 * 
	 * @param so    so
	 */
	public SFSObject responseData(SFSObject so){
		so.putUtfString("bankerpoker", "{\"point\":20,\"poker\":[113,310],\"type\":0}");
		so.putInt("state", 0);
		so.putInt("errorCode", 0);
		SFSArray betList = new SFSArray();
		so.putSFSArray("betList", betList);
		SFSObject betList_so = new SFSObject();
		betList.addSFSObject(betList_so);
		betList_so.putInt("id", 20);
		betList_so.putDouble("money", 0);
		so.putDouble("balance", 497.7);
		return so;
	}
}//end E109BlackJackResponse