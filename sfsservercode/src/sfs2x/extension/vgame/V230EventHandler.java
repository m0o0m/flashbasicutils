package sfs2x.extension.vgame;

import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.entities.data.SFSArray;
import com.smartfoxserver.v2.entities.data.SFSObject;
import com.smartfoxserver.v2.extensions.BaseClientRequestHandler;


/**
 * @author Administrator
 * @version 1.0
 * @created 03-八月-2016 17:09:34
 */
public class V230EventHandler extends BaseClientRequestHandler {

	public V230EventHandler(){

	}

	public void finalize() throws Throwable {
		super.finalize();
	}
	/**
	 * 
	 * @param arg0
	 * @param arg1
	 */
	@Override
	public void handleClientRequest(User arg0, ISFSObject arg1){
		SFSObject so_44161 = new SFSObject();
		 SFSArray so_44161_sa_63580 = new SFSArray();
		so_44161.putSFSArray("arr",so_44161_sa_63580);
		 SFSObject so_44161_sa_63580_so_9796 = new SFSObject();
		so_44161_sa_63580.addSFSObject(so_44161_sa_63580_so_9796);
		 so_44161_sa_63580_so_9796.putUtfString("s","15092300018");
		 so_44161_sa_63580_so_9796.putInt("a",1);
		 so_44161_sa_63580_so_9796.putUtfString("du","/imgs/f180fe3a-8ea8-41ea-9195-43a45bb7c21d.272.jpg");
		 so_44161_sa_63580_so_9796.putUtfString("dn","Hogoxes");
		 so_44161_sa_63580_so_9796.putInt("l",30);
		 so_44161_sa_63580_so_9796.putUtfString("g","Dice");
		  SFSObject so_44161_sa_63580_so_1021 = new SFSObject();
		so_44161_sa_63580.addSFSObject(so_44161_sa_63580_so_1021);
		 so_44161_sa_63580_so_1021.putUtfString("s","14102800001");
		 so_44161_sa_63580_so_1021.putInt("a",3);
		 so_44161_sa_63580_so_1021.putUtfString("du","/imgs/9876f5b8-1e47-4c82-97bb-9cfc694546fb.667.jpg");
		 so_44161_sa_63580_so_1021.putUtfString("dn","Jeffery");
		 so_44161_sa_63580_so_1021.putInt("l",0);
		 so_44161_sa_63580_so_1021.putUtfString("g","Baccarat");
		  SFSObject so_44161_sa_63580_so_40542 = new SFSObject();
		so_44161_sa_63580.addSFSObject(so_44161_sa_63580_so_40542);
		 so_44161_sa_63580_so_40542.putUtfString("s","14102800002");
		 so_44161_sa_63580_so_40542.putInt("a",2);
		 so_44161_sa_63580_so_40542.putUtfString("du","/imgs/04d67304-06fa-4907-b6aa-e601dc470e4b.692.jpg");
		 so_44161_sa_63580_so_40542.putUtfString("dn","Peter");
		 so_44161_sa_63580_so_40542.putInt("l",0);
		 so_44161_sa_63580_so_40542.putUtfString("g","Baccarat");
		  SFSObject so_44161_sa_63580_so_60279 = new SFSObject();
		so_44161_sa_63580.addSFSObject(so_44161_sa_63580_so_60279);
		 so_44161_sa_63580_so_60279.putUtfString("s","14102800003");
		 so_44161_sa_63580_so_60279.putInt("a",2);
		 so_44161_sa_63580_so_60279.putUtfString("du","/imgs/5316f24c-1cdc-4cea-8986-1c51efa859ea.707.jpg");
		 so_44161_sa_63580_so_60279.putUtfString("dn","Juliana");
		 so_44161_sa_63580_so_60279.putInt("l",0);
		 so_44161_sa_63580_so_60279.putUtfString("g","Baccarat");
		  SFSObject so_44161_sa_63580_so_44965 = new SFSObject();
		so_44161_sa_63580.addSFSObject(so_44161_sa_63580_so_44965);
		 so_44161_sa_63580_so_44965.putUtfString("s","14121200008");
		 so_44161_sa_63580_so_44965.putInt("a",2);
		 so_44161_sa_63580_so_44965.putUtfString("du","/imgs/e4d0d831-1a9a-4e1f-9294-9d66afb255da.317.jpg");
		 so_44161_sa_63580_so_44965.putUtfString("dn","Ben");
		 so_44161_sa_63580_so_44965.putInt("l",0);
		 so_44161_sa_63580_so_44965.putUtfString("g","Baccarat");
		  SFSObject so_44161_sa_63580_so_52636 = new SFSObject();
		so_44161_sa_63580.addSFSObject(so_44161_sa_63580_so_52636);
		 so_44161_sa_63580_so_52636.putUtfString("s","14121200007");
		 so_44161_sa_63580_so_52636.putInt("a",3);
		 so_44161_sa_63580_so_52636.putUtfString("du","/imgs/a0acc49c-5d35-41ad-91d8-d53055f66792.713.jpg");
		 so_44161_sa_63580_so_52636.putUtfString("dn","June");
		 so_44161_sa_63580_so_52636.putInt("l",0);
		 so_44161_sa_63580_so_52636.putUtfString("g","Baccarat");
send("230",so_44161,arg0);
	}
}//end V230EventHandler