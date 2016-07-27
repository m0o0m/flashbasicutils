package sfs2x.extension.egame.sever.responseData;

import com.smartfoxserver.v2.entities.data.SFSObject;


/**
 * @author Administrator
 * @version 1.0
 * @created 27-七月-2016 17:58:37
 */
public class E111CaribbeanResponse extends EGameResponse {

	public E111CaribbeanResponse(){

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
		so.putInt("r", 3);
		SFSObject p = new SFSObject();
		so.putSFSObject("p", p);
		
		return so;
	}
}//end E111CaribbeanResponse