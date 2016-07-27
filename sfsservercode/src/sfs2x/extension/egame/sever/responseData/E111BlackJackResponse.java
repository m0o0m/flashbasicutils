package sfs2x.extension.egame.sever.responseData;

import com.smartfoxserver.v2.entities.data.SFSArray;
import com.smartfoxserver.v2.entities.data.SFSObject;


/**
 * @author Administrator
 * @version 1.0
 * @created 27-七月-2016 17:25:52
 */
public class E111BlackJackResponse extends EGameResponse {

	public E111BlackJackResponse(){

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
		so.putInt("na", 0);
		so.putInt("errorCode", 0);
		so.putInt("type", 2);
		so.putInt("point", 30);
		SFSArray poker = new SFSArray();
		so.putSFSArray("poker", poker);
		poker.addInt(211);
		poker.addInt(411);
		poker.addInt(211);
		so.putDouble("balance", 492.2);
		
		return so;
	}
}//end E111BlackJackResponse