package sfs2x.extension.egame.sever.responseData;

import com.smartfoxserver.v2.entities.data.SFSArray;
import com.smartfoxserver.v2.entities.data.SFSObject;


/**
 * @author Administrator
 * @version 1.0
 * @created 27-七月-2016 15:29:02
 */
public class E109CaribbeanResponse extends EGameResponse {

	public E109CaribbeanResponse(){

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
	 * @param so    so
	 */
	public SFSObject responseData(SFSObject so){
		so.putUtfString("bankerPoker", "{\"poker\":[312,113,305,107,204],\"type\":10}");
		so.putInt("state", 0);
		so.putInt("errorCode", 0);
		SFSArray betList = new SFSArray();
		so.putSFSArray("betList", betList);
		betList.addUtfString("{\"hg\":-10,\"hb\":10,\"a\":2,\"g\":1,\"bg\":1,\"dbg\":2,\"w\":-1}");
		so.putDouble("balance", 497.7);
		return so;
	}
}//end E109CaribbeanResponse