package sfs2x.extension.egame.sever.responseData;

import com.smartfoxserver.v2.entities.data.SFSArray;
import com.smartfoxserver.v2.entities.data.SFSObject;


/**
 * @author Administrator
 * @version 1.0
 * @created 27-七月-2016 17:25:52
 */
public class E110BlackJackResponse extends EGameResponse {

	public E110BlackJackResponse(){

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
		so.putInt("na", 20);
		SFSArray poker = new SFSArray();
		so.putSFSArray("poker", poker);
		poker.addInt(213);
		poker.addInt(308);
		poker.addInt(102);
		so.putInt("errorCode", 0);
		so.putInt("type", 0);
		so.putInt("point", 20);
		
		return so;
	}
}//end E110BlackJackResponse