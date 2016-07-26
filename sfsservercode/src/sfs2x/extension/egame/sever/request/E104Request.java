package sfs2x.extension.egame.sever.request;

import com.smartfoxserver.v2.entities.data.SFSObject;


/**
 * @author Administrator
 * @version 1.0
 * @created 25-七月-2016 16:55:54
 * 5.	CMD:104 退出
 */
public class E104Request extends EGameRequest {

	public E104Request(){
	}

	/**
	 * 
	 * @param num
	 */
	public E104Request(String num){
		number = num;
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
	 * @param obj    obj
	 */
	public SFSObject chooseData(SFSObject obj){
		return super.chooseData(obj);
	}
}//end E104Request