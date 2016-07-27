package sfs2x.extension.egame.sever.responseData;

import com.smartfoxserver.v2.entities.data.SFSObject;


/**
 * @author Administrator
 * @version 1.0
 * @created 27-七月-2016 16:52:21
 */
public class E108LonghuResponse extends EGameResponse {

	public E108LonghuResponse(){

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
		so.putBool("nextFlush", false);
		so.putDouble("balance", 499.7);
		so.putInt("errorCode", 0);
		SFSObject pokers = new SFSObject();
		so.putSFSObject("pokers", pokers);
		pokers.putUtfString("b", "211");
		pokers.putUtfString("p", "308");
		return so;
	}
}//end E108LonghuResponse