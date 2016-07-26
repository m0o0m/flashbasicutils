package sfs2x.extension.egame.sever.game;

import sfs2x.extension.egame.sever.request.EGameRequest;

import com.smartfoxserver.v2.entities.data.SFSObject;


/**
 * @author Administrator
 * @version 1.0
 * @created 23-七月-2016 18:37:57
 */
public class EGame {

	private EGameRequest request;
	public EGame(){

	}

	public void finalize() throws Throwable {

	}



	/**
	 * 
	 * @param sfsObject
	 */
	public SFSObject sendData(SFSObject sfsObject){
		SFSObject data = getRequest().chooseData(sfsObject);
		return data;
	}

	public EGameRequest getRequest() {
		return request;
	}

	public void setRequest(EGameRequest request) {
		this.request = request;
	}
}//end EGame