package sfs2x.extension.egame.sever.responseData;

import com.smartfoxserver.v2.entities.data.SFSArray;
import com.smartfoxserver.v2.entities.data.SFSObject;


/**
 * @author Administrator
 * @version 1.0
 * @created 27-七月-2016 16:20:45
 */
public class E110TexasResponse extends EGameResponse {

	private int pts = -1;

	public E110TexasResponse(){

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
		pts++; 
		
		so.putInt("errorCode", 0);
		SFSArray cp = new SFSArray();
		so.putSFSArray("cp", cp);
		cp.addInt(302);
		cp.addInt(103);
		cp.addInt(410);
		if(pts == 0)
		{
			so.putInt("pt", 0);
		}
		if(pts==1)
		{
			so.putInt("pt", 1);
			cp.addInt(210);
		}else if(pts==2)
		{
			so.putInt("pt", 1);
			cp.addInt(309);
			pts = -1;
		}
		so.putDouble("balance", 318.2);
		return so;
	}
}//end E110TexasResponse