package sfs2x.extension.egame.sever.responseData;

import com.smartfoxserver.v2.entities.data.SFSObject;


/**
 * @author Administrator
 * @version 1.0
 * @created 27-七月-2016 17:18:24
 */
public class E108RouletteResponse extends EGameResponse {

	public E108RouletteResponse(){

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
		so.putDouble("balance", 499.7);
		so.putInt("errorCode", 0);
		SFSObject pokers = new SFSObject();
		so.putSFSObject("pokers", pokers);
		pokers.putUtfString("b", "4");
		return so;
	}
}//end E108RouletteResponse