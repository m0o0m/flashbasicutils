package sfs2x.extension.egame.sever.responseData;

import com.smartfoxserver.v2.entities.data.SFSArray;
import com.smartfoxserver.v2.entities.data.SFSObject;


/**
 * @author Administrator
 * @version 1.0
 * @created 27-七月-2016 17:18:25
 */
public class E109RouletteResponse extends EGameResponse {

	public E109RouletteResponse(){

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
		SFSArray betList = new SFSArray();
		so.putSFSArray("betList", betList);
		SFSObject betList_so = new SFSObject();
		betList.addSFSObject(betList_so);
		betList_so.putInt("id", 0);
		betList_so.putDouble("money", -1);
		so.putInt("state", 0);
		so.putDouble("balance", 499.7);
		return so;
	}
}//end E109RouletteResponse