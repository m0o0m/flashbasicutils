package sfs2x.extension.egame.sever.request;

import java.io.Console;

import sfs2x.extension.egame.sever.GameConfig;
import sfs2x.extension.egame.sever.responseData.EGameResponse;

import com.smartfoxserver.v2.entities.data.SFSObject;


/**
 * @author Administrator
 * @version 1.0
 * @created 25-七月-2016 12:06:42
 */
public class EGameRequest {
	protected EGameResponse response ;
	public String number = "";
	private String className = "";
	
	public EGameRequest(){

	}
	public EGameRequest(String num){
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
		Class c = null;
		className = "sfs2x.extension.egame.sever.responseData."+"E"+number+GameConfig.getCurrentGameName()+"Response";
		try {
			c = Class.forName(className);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  
		try {
			response = (EGameResponse) c.newInstance();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		return response.responseData(obj);
	}
}//end EGameRequest