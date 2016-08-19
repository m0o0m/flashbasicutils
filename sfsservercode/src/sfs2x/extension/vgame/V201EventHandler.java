package sfs2x.extension.vgame;

import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.entities.data.SFSObject;
import com.smartfoxserver.v2.extensions.BaseClientRequestHandler;


/**
 * @author Administrator
 * @version 1.0
 * @created 03-八月-2016 16:39:57
 */
public class V201EventHandler extends BaseClientRequestHandler {
	public SFSObject so_41064 = new SFSObject();//Dice 
	 public SFSObject so_65697 = new SFSObject();//bacc
	public V201EventHandler(){
		initData();
	}

	private void initData() {
		// TODO Auto-generated method stub
		
		 SFSObject so_41064_so_34331 = new SFSObject();
		so_41064.putSFSObject("gi",so_41064_so_34331);
		 so_41064_so_34331.putDouble("x5m",0);
		 so_41064_so_34331.putInt("pc",0);
		 so_41064_so_34331.putDouble("pm",0);
		 so_41064_so_34331.putDouble("x4m",0);
		 so_41064_so_34331.putInt("x5c",0);
		 so_41064_so_34331.putDouble("bm",0);
		 so_41064_so_34331.putInt("tc",0);
		 so_41064_so_34331.putInt("x4c",0);
		 so_41064_so_34331.putDouble("tm",0);
		 so_41064_so_34331.putInt("bc",0);
		  so_41064.putUtfString("s","15092300018");
		 so_41064.putDouble("t",820697.0499999999);
		 so_41064.putUtfString("g","Dice");
		 

		 SFSObject so_65697_so_84507 = new SFSObject();
		so_65697.putSFSObject("gi",so_65697_so_84507);
		 so_65697_so_84507.putInt("tc",5);
		 so_65697_so_84507.putDouble("x5m",330);
		 so_65697_so_84507.putInt("x4c",1);
		 so_65697_so_84507.putInt("pc",7);
		 so_65697_so_84507.putInt("x5c",3);
		 so_65697_so_84507.putDouble("tm",590);
		 so_65697_so_84507.putDouble("x4m",60);
		 so_65697_so_84507.putDouble("pm",2100);
		 so_65697_so_84507.putInt("bc",15);
		 so_65697_so_84507.putDouble("bm",4510);
		  so_65697.putUtfString("s","14102800002");
		 so_65697.putDouble("t",244157.65);
		 so_65697.putUtfString("g","Baccarat");
		 
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
		
		 send("201",so_41064,arg0);
	}
}//end V201EventHandler