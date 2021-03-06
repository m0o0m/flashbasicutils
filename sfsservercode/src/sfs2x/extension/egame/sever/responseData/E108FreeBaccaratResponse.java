package sfs2x.extension.egame.sever.responseData;

import com.smartfoxserver.v2.entities.data.SFSObject;


/**
 * @author Administrator
 * @version 1.0
 * @created 27-七月-2016 15:51:35
 */
public class E108FreeBaccaratResponse extends EGameResponse {

	public E108FreeBaccaratResponse(){

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
		so.putBool("nextPass", true);
		so.putInt("errorCode", 0);
		SFSObject pokers = new SFSObject();
		so.putSFSObject("pokers", pokers);
		pokers.putUtfString("b", "308,101,0;9;0");
		pokers.putUtfString("p", "208,211,0;8;0;1");
		pokers.putBool("nextFlush", false);
		pokers.putDouble("balance", 499.7);
		return so;
	}
}//end E108FreeBaccaratResponse