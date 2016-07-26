package sfs2x.extension.egame.sever.request;

import com.smartfoxserver.v2.entities.data.SFSObject;


/**
 * @author Administrator
 * @version 1.0
 * @created 25-七月-2016 16:55:54
 * 9.	CMD:108 下注
 */
public class E108Request extends EGameRequest {

	public E108Request(){
	}
	public E108Request(String num){
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
}//end E108Request