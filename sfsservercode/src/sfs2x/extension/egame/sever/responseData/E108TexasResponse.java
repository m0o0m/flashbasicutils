package sfs2x.extension.egame.sever.responseData;

import com.smartfoxserver.v2.entities.data.SFSObject;


/**
 * @author Administrator
 * @version 1.0
 * @created 27-七月-2016 16:16:34
 */
public class E108TexasResponse extends EGameResponse {

	public E108TexasResponse(){

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
		so.putInt("errorCode", 0);
		so.putUtfString("bs", "{\"player\":{\"poker\":[308,107],\"type\":0}}");
		so.putBool("nextFlush", false);
		so.putDouble("balance", 319.2);
		return so;
	}
}//end E108TexasResponse