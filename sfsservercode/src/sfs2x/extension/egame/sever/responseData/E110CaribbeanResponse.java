package sfs2x.extension.egame.sever.responseData;

import com.smartfoxserver.v2.entities.data.SFSObject;


/**
 * @author Administrator
 * @version 1.0
 * @created 27-七月-2016 15:39:13
 */
public class E110CaribbeanResponse extends EGameResponse {

	public E110CaribbeanResponse(){

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
		so.putDouble("blance", 316.2);
		so.putInt("errorcode", 0);
		so.putInt("na", 0);
		return so;
	}
}//end E110CaribbeanResponse