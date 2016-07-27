package sfs2x.extension.egame.sever.responseData;

import com.smartfoxserver.v2.entities.data.SFSObject;


/**
 * @author Administrator
 * @version 1.0
 * @created 27-七月-2016 14:57:30
 */
public class E108NiuResponse extends EGameResponse {

	public E108NiuResponse(){

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
	public SFSObject responseData(SFSObject outData){
		outData.putInt("errorCode", 0);
		SFSObject pokers = new SFSObject();
		outData.putSFSObject("pokers", pokers);
		pokers.putUtfString("b", "403,409,306,402,201;1");
		pokers.putUtfString("p", "301,413,109,406,411;6;1;0|111,102,204,206,104;6;1;0|410,211,207,210,103;10;1;1|107,404,212,112,311;1;1;0");
		pokers.putDouble("balance", 316.7);
		return outData;
	}
}//end E108NiuResponse