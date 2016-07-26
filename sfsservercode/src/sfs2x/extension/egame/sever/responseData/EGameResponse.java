package sfs2x.extension.egame.sever.responseData;

import com.smartfoxserver.v2.entities.data.SFSObject;


/**
 * @author Administrator
 * @version 1.0
 * @created 25-七月-2016 12:06:42
 */
public abstract class EGameResponse {

	public EGameResponse(){

	}
	public void finalize() throws Throwable {

	}
	/**
	 * 
	 * @param outData    so
	 */
	public abstract SFSObject responseData(SFSObject outData);
}//end EGameResponse