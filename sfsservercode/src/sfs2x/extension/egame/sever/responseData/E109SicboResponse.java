package sfs2x.extension.egame.sever.responseData;

import com.smartfoxserver.v2.entities.data.SFSArray;
import com.smartfoxserver.v2.entities.data.SFSObject;


/**
 * @author Administrator
 * @version 1.0
 * @created 26-七月-2016 10:12:09
 */
public class E109SicboResponse extends EGameResponse {

	public E109SicboResponse(){

	}

	public void finalize() throws Throwable {
		super.finalize();
	}
	/**
	 * 
	 * @param outData    so
	 */
	public SFSObject responseData(SFSObject outData){
		outData.putInt("state", 0);
		SFSArray sa = new SFSArray();
		outData.putSFSArray("betList", sa);
		SFSObject sa_so = new SFSObject();
		sa.addSFSObject(sa_so);
		sa_so.putInt("id", 502);
		sa_so.putDouble("money", -5);
		outData.putDouble("balance", 496.7);
		
		return outData;
	}
}//end E109SicboResponse