package sfs2x.extension.egame.sever.request;

import com.smartfoxserver.v2.entities.data.SFSObject;


/**
 * @author Administrator
 * @version 1.0
 * @created 26-七月-2016 16:41:50
 */
public class E110Request extends EGameRequest {

	public E110Request(){

	}
	public E110Request(String num){
		number = num;
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
	 * @param obj    obj
	 */
	public SFSObject chooseData(SFSObject obj){
		return super.chooseData(obj);
	}
}//end E110Request