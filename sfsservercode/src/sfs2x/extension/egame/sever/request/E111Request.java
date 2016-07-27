package sfs2x.extension.egame.sever.request;

import com.smartfoxserver.v2.entities.data.SFSObject;


/**
 * @author Administrator
 * @version 1.0
 * @created 26-七月-2016 18:03:20
 */
public class E111Request extends EGameRequest {

	public E111Request(){

	}
	public E111Request(String num){
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
	};
}//end E111Request