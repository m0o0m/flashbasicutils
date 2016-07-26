package sfs2x.extension.egame.sever.responseData;

import com.smartfoxserver.v2.entities.data.SFSObject;

import sfs2x.extension.egame.sever.responseData.EGameResponse;

/**
 * @author Administrator
 * @version 1.0
 * @created 26-七月-2016 10:06:12
 */
public class E104SicboResponse extends EGameResponse {

	public E104SicboResponse(){

	}

	public void finalize() throws Throwable {
		super.finalize();
	}
	/**
	 * 
	 * @param outData    so
	 */
	public SFSObject responseData(SFSObject outData){
		outData.putDouble("balacne", 492.7);
		return outData;
	}

}//end E104SicboResponse