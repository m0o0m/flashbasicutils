package sfs2x.extension.egame.sever.request;

import com.smartfoxserver.v2.entities.data.SFSObject;


/**
 * @author Administrator
 * @version 1.0
 * @created 25-七月-2016 16:55:54
 * 10.	CMD:109 发牌结束获取结果
 */
public class E109Request extends EGameRequest {

	public E109Request(){

	}
	public E109Request(String num){
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
}//end E109Request