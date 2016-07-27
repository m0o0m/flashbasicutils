package sfs2x.extension.egame.sever.responseData;

import com.smartfoxserver.v2.entities.data.SFSArray;
import com.smartfoxserver.v2.entities.data.SFSObject;


/**
 * @author Administrator
 * @version 1.0
 * @created 27-七月-2016 16:16:34
 */
public class E109TexasResponse extends EGameResponse {

	public E109TexasResponse(){

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
		SFSArray pmp = new SFSArray();
		so.putSFSArray("pmp", pmp);
		pmp.addInt(410);
		pmp.addInt(210);
		pmp.addInt(309);
		pmp.addInt(308);
		pmp.addInt(107);
		so.putUtfString("bankerPoker", "{\"poker\":[402,401],\"type\":2}");
		so.putInt("win", 1);
		so.putDouble("rm", -4);
		so.putInt("state", 0);
		so.putInt("errorCode", 0);
		SFSArray bmp = new SFSArray();
		so.putSFSArray("bmp", bmp);
		bmp.addInt(410);
		bmp.addInt(210);
		bmp.addInt(302);
		bmp.addInt(402);
		bmp.addInt(401);
		so.putDouble("balance",  316.2);
		return so;
	}
}//end E109TexasResponse