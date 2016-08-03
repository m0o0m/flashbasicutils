package sfs2x.extension.vgame.server.responseData;

import com.smartfoxserver.v2.entities.data.SFSObject;


/**
 * @author Administrator
 * @version 1.0
 * @created 02-八月-2016 16:16:03
 */
public abstract class VGameResponse {

	public VGameResponse(){

	}

	/**
	 * 
	 * @exception Throwable
	 */
	public void finalize()
	  throws Throwable{

	}

	/**
	 * 
	 * @param outData    so
	 */
	public abstract SFSObject responseData(SFSObject outData);
}//end VGameResponse