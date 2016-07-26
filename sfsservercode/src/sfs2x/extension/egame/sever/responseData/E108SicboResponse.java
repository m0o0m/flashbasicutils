package sfs2x.extension.egame.sever.responseData;

import com.smartfoxserver.v2.entities.data.SFSObject;

/**
 * @author Administrator
 * @version 1.0
 * @created 26-七月-2016 10:12:00
 */
public class E108SicboResponse extends EGameResponse {

	public E108SicboResponse(){

	}

	public void finalize() throws Throwable {
		super.finalize();
	}
	/**
	 * 
	 * @param outData    so
	 */
	public SFSObject responseData(SFSObject outData){
		outData.putInt("errorCode", 0);
		SFSObject so_so = new SFSObject();
		outData.putSFSObject("pokers", so_so);
		so_so.putUtfString("b", "1,3,4;8");
		so_so.putDouble("balance", 496.7);
		return outData;
	}
}//end E108SicboResponse