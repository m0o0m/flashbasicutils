package sfs2x.extension.vgame;

import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.entities.data.SFSArray;
import com.smartfoxserver.v2.entities.data.SFSObject;
import com.smartfoxserver.v2.extensions.BaseClientRequestHandler;


/**
 * @author Administrator
 * @version 1.0
 * @created 03-八月-2016 16:36:50
 */
public class V212EventHandler extends BaseClientRequestHandler {
	public SFSObject so_98877 = new SFSObject();
	public V212EventHandler(){
		initData();
	}

	public void finalize() throws Throwable {
		super.finalize();
	}
	public void initData(){
		
		 SFSObject so_98877_so_12125 = new SFSObject();
		so_98877.putSFSObject("c",so_98877_so_12125);
		 so_98877_so_12125.putDouble("bpm",0);
		 so_98877_so_12125.putDouble("pm",0);
		 so_98877_so_12125.putInt("tc",0);
		 so_98877_so_12125.putInt("bigc",0);
		 so_98877_so_12125.putInt("sc",0);
		 so_98877_so_12125.putInt("l",0);
		 so_98877_so_12125.putDouble("ppm",0);
		 so_98877_so_12125.putInt("pc",0);
		 so_98877_so_12125.putDouble("sm",0);
		 so_98877_so_12125.putInt("w",0);
		 so_98877_so_12125.putDouble("bm",0);
		 so_98877_so_12125.putUtfString("r","G8D123241B0253");
		 so_98877_so_12125.putInt("bpc",0);
		 so_98877_so_12125.putUtfString("poker","33,39,25,3A,-1,-1");
		 so_98877_so_12125.putUtfString("s","14102800002");
		 so_98877_so_12125.putInt("bc",0);
		 so_98877_so_12125.putUtfString("sn","S02");
		 so_98877_so_12125.putInt("pp",8);
		 so_98877_so_12125.putUtfString("d","657/Christopher");
		 so_98877_so_12125.putInt("ga",3);
		 so_98877_so_12125.putDouble("tm",0);
		 so_98877_so_12125.putInt("bp",9);
		 so_98877_so_12125.putUtfString("maxTipsUserName","maxTipsUserName: ");
		 so_98877_so_12125.putInt("ppc",0);
		 so_98877_so_12125.putDouble("maxTipsMoney",0);
		 so_98877_so_12125.putDouble("bigm",0);
		  SFSArray so_98877_sa_1528 = new SFSArray();
		so_98877.putSFSArray("s",so_98877_sa_1528);
		 SFSObject so_98877_sa_1528_so_63584 = new SFSObject();
		so_98877_sa_1528.addSFSObject(so_98877_sa_1528_so_63584);
		 so_98877_sa_1528_so_63584.putUtfString("o","12.0");
		 so_98877_sa_1528_so_63584.putUtfString("m","XDD");
		 so_98877_sa_1528_so_63584.putUtfString("si","1410280000200005");
		  SFSObject so_98877_sa_1528_so_66293 = new SFSObject();
		so_98877_sa_1528.addSFSObject(so_98877_sa_1528_so_66293);
		 so_98877_sa_1528_so_66293.putUtfString("o","2.0");
		 so_98877_sa_1528_so_66293.putUtfString("m","Xian");
		 so_98877_sa_1528_so_66293.putUtfString("si","1410280000200002");
		  SFSObject so_98877_sa_1528_so_48020 = new SFSObject();
		so_98877_sa_1528.addSFSObject(so_98877_sa_1528_so_48020);
		 so_98877_sa_1528_so_48020.putUtfString("o","1.5");
		 so_98877_sa_1528_so_48020.putUtfString("m","Da");
		 so_98877_sa_1528_so_48020.putUtfString("si","1410280000200006");
		  SFSObject so_98877_sa_1528_so_4922 = new SFSObject();
		so_98877_sa_1528.addSFSObject(so_98877_sa_1528_so_4922);
		 so_98877_sa_1528_so_4922.putUtfString("o","9.0");
		 so_98877_sa_1528_so_4922.putUtfString("m","He");
		 so_98877_sa_1528_so_4922.putUtfString("si","1410280000200003");
		  SFSObject so_98877_sa_1528_so_74965 = new SFSObject();
		so_98877_sa_1528.addSFSObject(so_98877_sa_1528_so_74965);
		 so_98877_sa_1528_so_74965.putUtfString("o","1.95");
		 so_98877_sa_1528_so_74965.putUtfString("m","Zhuang");
		 so_98877_sa_1528_so_74965.putUtfString("si","1410280000200001");
		  SFSObject so_98877_sa_1528_so_2571 = new SFSObject();
		so_98877_sa_1528.addSFSObject(so_98877_sa_1528_so_2571);
		 so_98877_sa_1528_so_2571.putUtfString("o","2.5");
		 so_98877_sa_1528_so_2571.putUtfString("m","Xiao");
		 so_98877_sa_1528_so_2571.putUtfString("si","1410280000200007");
		  SFSObject so_98877_sa_1528_so_47830 = new SFSObject();
		so_98877_sa_1528.addSFSObject(so_98877_sa_1528_so_47830);
		 so_98877_sa_1528_so_47830.putUtfString("o","12.0");
		 so_98877_sa_1528_so_47830.putUtfString("m","ZDD");
		 so_98877_sa_1528_so_47830.putUtfString("si","1410280000200004");
		   SFSObject so_98877_so_59309 = new SFSObject();
		so_98877.putSFSObject("ui",so_98877_so_59309);
		 so_98877_so_59309.putInt("TestState",1);
		 SFSArray so_98877_so_59309_sa_81704 = new SFSArray();
		so_98877_so_59309.putSFSArray("StakeAll",so_98877_so_59309_sa_81704);
		   so_98877_so_59309.putDouble("tt",0);
		 so_98877_so_59309.putUtfString("ul","rtmp://line1.maya-lines.com/qj2/1-1|rtmp://line2.maya-lines.com/qj2/1-1|rtmp://line3.video.zt008.com/qj2/1-1|rtmp://line4.video.zt008.com/qj2/1-1");
		 so_98877_so_59309.putDouble("b",2768.4);
		 so_98877_so_59309.putUtfString("huilvType","RMB");
		 so_98877_so_59309.putUtfString("cf","cf: ");
		   so_98877_so_59309.putUtfString("li","1-1000");
		 so_98877_so_59309.putUtfString("un","***st6");
		 SFSArray so_98877_so_59309_sa_96624 = new SFSArray();
		so_98877_so_59309.putSFSArray("allLimit",so_98877_so_59309_sa_96624);
		 so_98877_so_59309_sa_96624.addInt(1000);
		 so_98877_so_59309_sa_96624.addInt(1000);
		 so_98877_so_59309_sa_96624.addInt(125);
		 so_98877_so_59309_sa_96624.addInt(90);
		 so_98877_so_59309_sa_96624.addInt(90);
		 so_98877_so_59309_sa_96624.addInt(1000);
		 so_98877_so_59309_sa_96624.addInt(600);
		  so_98877_so_59309.putUtfString("nickName","***st6");
		 so_98877_so_59309.putInt("gameType",0);
		 so_98877_so_59309.putInt("ti",20);
		 so_98877_so_59309.putInt("lt",2);
		  SFSArray so_98877_sa_11403 = new SFSArray();
		so_98877.putSFSArray("ul",so_98877_sa_11403);
		 SFSObject so_98877_sa_11403_so_34913 = new SFSObject();
		so_98877_sa_11403.addSFSObject(so_98877_sa_11403_so_34913);
		 so_98877_sa_11403_so_34913.putInt("location",3);
		 so_98877_sa_11403_so_34913.putInt("userId",24518);
		 so_98877_sa_11403_so_34913.putDouble("balance",279.4);
		 so_98877_sa_11403_so_34913.putUtfString("userName","liangzhede110");
		 SFSObject so_98877_sa_11403_so_34913_so_66908 = new SFSObject();
		so_98877_sa_11403_so_34913.putSFSObject("gameBet",so_98877_sa_11403_so_34913_so_66908);
		 so_98877_sa_11403_so_34913_so_66908.putDouble("Xian",0);
		 so_98877_sa_11403_so_34913_so_66908.putDouble("ZDD",0);
		 so_98877_sa_11403_so_34913_so_66908.putDouble("Zhuang",0);
		 so_98877_sa_11403_so_34913_so_66908.putDouble("XDD",0);
		 so_98877_sa_11403_so_34913_so_66908.putDouble("Da",0);
		 so_98877_sa_11403_so_34913_so_66908.putDouble("He",0);
		 so_98877_sa_11403_so_34913_so_66908.putDouble("Xiao",0);
		   SFSObject so_98877_sa_11403_so_49219 = new SFSObject();
		so_98877_sa_11403.addSFSObject(so_98877_sa_11403_so_49219);
		 so_98877_sa_11403_so_49219.putInt("location",8);
		 so_98877_sa_11403_so_49219.putInt("userId",-287);
		 so_98877_sa_11403_so_49219.putDouble("balance",3347);
		 so_98877_sa_11403_so_49219.putUtfString("userName","***vom");
		 SFSObject so_98877_sa_11403_so_49219_so_58997 = new SFSObject();
		so_98877_sa_11403_so_49219.putSFSObject("gameBet",so_98877_sa_11403_so_49219_so_58997);
		 so_98877_sa_11403_so_49219_so_58997.putDouble("Xian",0);
		 so_98877_sa_11403_so_49219_so_58997.putDouble("ZDD",0);
		 so_98877_sa_11403_so_49219_so_58997.putDouble("Zhuang",0);
		 so_98877_sa_11403_so_49219_so_58997.putDouble("XDD",0);
		 so_98877_sa_11403_so_49219_so_58997.putDouble("Da",0);
		 so_98877_sa_11403_so_49219_so_58997.putDouble("He",0);
		 so_98877_sa_11403_so_49219_so_58997.putDouble("Xiao",0);
		   SFSObject so_98877_sa_11403_so_83924 = new SFSObject();
		so_98877_sa_11403.addSFSObject(so_98877_sa_11403_so_83924);
		 so_98877_sa_11403_so_83924.putInt("location",7);
		 so_98877_sa_11403_so_83924.putInt("userId",-299);
		 so_98877_sa_11403_so_83924.putDouble("balance",9468.5);
		 so_98877_sa_11403_so_83924.putUtfString("userName","***3e8");
		 SFSObject so_98877_sa_11403_so_83924_so_34250 = new SFSObject();
		so_98877_sa_11403_so_83924.putSFSObject("gameBet",so_98877_sa_11403_so_83924_so_34250);
		 so_98877_sa_11403_so_83924_so_34250.putDouble("Xian",0);
		 so_98877_sa_11403_so_83924_so_34250.putDouble("ZDD",0);
		 so_98877_sa_11403_so_83924_so_34250.putDouble("Zhuang",0);
		 so_98877_sa_11403_so_83924_so_34250.putDouble("XDD",0);
		 so_98877_sa_11403_so_83924_so_34250.putDouble("Da",0);
		 so_98877_sa_11403_so_83924_so_34250.putDouble("He",0);
		 so_98877_sa_11403_so_83924_so_34250.putDouble("Xiao",0);
		   SFSObject so_98877_sa_11403_so_11331 = new SFSObject();
		so_98877_sa_11403.addSFSObject(so_98877_sa_11403_so_11331);
		 so_98877_sa_11403_so_11331.putInt("location",1);
		 so_98877_sa_11403_so_11331.putInt("userId",-43);
		 so_98877_sa_11403_so_11331.putDouble("balance",7013);
		 so_98877_sa_11403_so_11331.putUtfString("userName","***865");
		 SFSObject so_98877_sa_11403_so_11331_so_34450 = new SFSObject();
		so_98877_sa_11403_so_11331.putSFSObject("gameBet",so_98877_sa_11403_so_11331_so_34450);
		 so_98877_sa_11403_so_11331_so_34450.putDouble("Xian",0);
		 so_98877_sa_11403_so_11331_so_34450.putDouble("ZDD",0);
		 so_98877_sa_11403_so_11331_so_34450.putDouble("Zhuang",0);
		 so_98877_sa_11403_so_11331_so_34450.putDouble("XDD",0);
		 so_98877_sa_11403_so_11331_so_34450.putDouble("Da",0);
		 so_98877_sa_11403_so_11331_so_34450.putDouble("He",0);
		 so_98877_sa_11403_so_11331_so_34450.putDouble("Xiao",0);
		 
	}
	/**
	 * 
	 * @param arg0
	 * @param arg1
	 */
	@Override
	public void handleClientRequest(User arg0, ISFSObject arg1){
		 
		 
		 send("227",so_98877,arg0);
		
	}
}//end V227EventHandler