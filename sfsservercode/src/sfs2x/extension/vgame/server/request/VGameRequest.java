package sfs2x.extension.vgame.server.request;

import com.smartfoxserver.v2.entities.data.SFSObject;

import sfs2x.extension.vgame.server.GameConfig;
import sfs2x.extension.vgame.server.responseData.VGameResponse;


/**
 * @author Administrator
 * @version 1.0
 * @created 02-八月-2016 16:16:03
 */
public class VGameRequest {

	private String className = "";
	public String number = "";
	protected VGameResponse response;

	public VGameRequest(){

	}

	/**
	 * 
	 * @param num
	 */
	public VGameRequest(String num){

	}

	/**
	 * 
	 * @exception Throwable Throwable
	 */
	public void finalize()
	  throws Throwable{

	}

	/**
	 * 在这里处理游戏种类与消息种类的具体的结合的具体代码执行; 这里通过反射封装了这种具体的判断;
	 * 
	 * @param obj    obj
	 */
	public SFSObject chooseData(SFSObject obj){
		Class c = null;
		className = "sfs2x.extension.vgame.server.responseData."+"V"+number+GameConfig.getCurrentGameName()+"Response";
		try {
			c = Class.forName(className);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  
		try {
			response = (VGameResponse) c.newInstance();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		return response.responseData(obj);
	}
}//end VGameRequest