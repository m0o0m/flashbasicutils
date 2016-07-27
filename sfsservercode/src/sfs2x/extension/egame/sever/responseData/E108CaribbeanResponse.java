package sfs2x.extension.egame.sever.responseData;

import com.smartfoxserver.v2.entities.data.SFSObject;


/**
 * @author Administrator
 * @version 1.0
 * @created 27-七月-2016 15:29:03
 */
public class E108CaribbeanResponse extends EGameResponse {

	public E108CaribbeanResponse(){

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
		so.putUtfString("betresult", "{\"player\":[{\"g\":1,\"poker\":[306,203,111,404,406],\"a\":2,\"hg\":10,\"type\":1}],\"banker\":{\"poker\":[312],\"type\":0}}");
		so.putInt("ca", 2);
		so.putInt("errorcode", 0);
		so.putBool("nextFlush", false);
		so.putDouble("balance", 318.2);
		return so;
	}
}//end E108CaribbeanResponse