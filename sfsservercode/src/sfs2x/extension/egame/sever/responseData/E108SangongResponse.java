package sfs2x.extension.egame.sever.responseData;

import com.smartfoxserver.v2.entities.data.SFSObject;


/**
 * @author Administrator
 * @version 1.0
 * @created 27-七月-2016 17:11:48
 */
public class E108SangongResponse extends EGameResponse {

	public E108SangongResponse(){

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
		pokers.putUtfString("b", "301,409,201;1");
		pokers.putUtfString("p", "307,206,408;1;0;0|107,404,413;1;1;0|110,308,210;8;1;1|412,102,305;7;1;0");
		pokers.putDouble("balance", 316.7);
		return outData;
	}
}//end E108SangongResponse