package sfs2x.extension.vgame.server.game;

import sfs2x.extension.vgame.server.request.VGameRequest;

import com.smartfoxserver.v2.entities.data.SFSObject;


/**
 * @author Administrator
 * @version 1.0
 * @created 02-八月-2016 16:16:02
 */
public class VGame {

	private VGameRequest request;

	public VGame(){

	}

	/**
	 * 
	 * @exception Throwable
	 */
	public void finalize()
	  throws Throwable{

	}

	public VGameRequest getRequest(){
		return request;
		
	}

	/**
	 * 
	 * @param sfsObject    sfsObject
	 */
	public SFSObject sendData(SFSObject sfsObject){
		SFSObject data = getRequest().chooseData(sfsObject);
		return data;
	}

	/**
	 * 
	 * @param request
	 */
	public void setRequest(VGameRequest request){
		this.request = request;
	}
}//end VGame