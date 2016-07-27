package sfs2x.extension.egame.sever.responseData;

import com.smartfoxserver.v2.entities.data.SFSObject;


/**
 * @author Administrator
 * @version 1.0
 * @created 27-七月-2016 15:21:01
 */
public class E108BlackJackResponse extends EGameResponse {

	public E108BlackJackResponse(){

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
		so.putBool("nextFlush", false);
		so.putDouble("balance", 499.7);
		so.putInt("errorCode", 0);
		so.putInt("ca", 20);
		so.putUtfString("betresult", "{\"player\":[{\"point\":18,\"poker\":[213,308],\"area\":20,\"gold\":1,\"type\":0}],\"banker\":{\"point\":10,\"poker\":[113],\"type\":0}}");
		return so;
	}
}//end E108BlackJackResponse