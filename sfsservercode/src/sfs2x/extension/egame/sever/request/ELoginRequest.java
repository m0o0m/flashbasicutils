package sfs2x.extension.egame.sever.request;


/**
 * @author Administrator
 * @version 1.0
 * @created 25-七月-2016 18:23:10
 */
public class ELoginRequest extends EGameRequest {

	public ELoginRequest(){
		number = "Login";
	}
	public ELoginRequest(String num){
		number = num;
	}
	
	public void finalize() throws Throwable {
		super.finalize();
	}
}//end ELoginRequest