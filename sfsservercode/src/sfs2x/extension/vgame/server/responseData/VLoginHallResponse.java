package sfs2x.extension.vgame.server.responseData;
import com.smartfoxserver.v2.entities.data.SFSArray;
import com.smartfoxserver.v2.entities.data.SFSObject;

/**
 * @author Administrator
 * @version 1.0
 * @created 02-八月-2016 18:03:20
 */
public class VLoginHallResponse extends VGameResponse {

	public VLoginHallResponse(){
		
	}

	/**
	 * 
	 * @exception Throwable Throwable
	 */
	public void finalize()
	  throws Throwable{

	}

	/**
	 * @param so    so
	 * 
	 * @param outData    so
	 */
	public SFSObject responseData(SFSObject so_28689){
		//SFSObject so = new SFSObject();
		
		 so_28689.putInt("hp",1891);
		 so_28689.putBool("isOpenOfflineBet",true);
		 so_28689.putUtfString("userName","test6");
		 so_28689.putInt("TestState",1);
		 so_28689.putDouble("b",2768.4);
		 so_28689.putUtfString("u","test6");
		 so_28689.putUtfString("cf", "\"vipIsCheckPokerV\":true,\"selectedChips\":100,\"14121600013\":true,\"videoLine\":3,\"isMusicOn\":false,\"14121200008\":true,\"isSoundOn\":false,\"14102800002\":true,\"chips\":[1,5,10,50,100],\"14121200007\":true,\"vipIsCheckPoker\":true,\"selectedLimit\":\"10 - 20000\",\"vipIsAutoFlipFirstPoker\":false,\"multipleChips\":50,\"firstLoginBacc\":false,\"vipIsAutoOpenOtherPoker\":true,\"14102800003\":true,\"14121200009\":true,\"multipleGameServerIDs\":\"15092300018,15092300021,14102800003,14102800001\",\"14121600011\":true,\"14102800001\":true");
		   so_28689.putUtfString("siteNo","");
		 so_28689.putUtfString("huilvType","RMB");
		 so_28689.putInt("TipsIsOFF",0);
		 SFSArray so_28689_sa_40340 = new SFSArray();
		so_28689.putSFSArray("h",so_28689_sa_40340);
		 SFSObject so_28689_sa_40340_so_37247 = new SFSObject();
		so_28689_sa_40340.addSFSObject(so_28689_sa_40340_so_37247);
		 so_28689_sa_40340_so_37247.putUtfString("containGames","Baccarat,Dice");
		 so_28689_sa_40340_so_37247.putInt("hi",2);
		 so_28689_sa_40340_so_37247.putUtfString("hn","Flagship");
		  SFSObject so_28689_sa_40340_so_80670 = new SFSObject();
		so_28689_sa_40340.addSFSObject(so_28689_sa_40340_so_80670);
		 so_28689_sa_40340_so_80670.putUtfString("containGames","LongHu,FastBaccarat,Roulette");
		 so_28689_sa_40340_so_80670.putInt("hi",1);
		 so_28689_sa_40340_so_80670.putUtfString("hn","International");
		  SFSObject so_28689_sa_40340_so_3721 = new SFSObject();
		so_28689_sa_40340.addSFSObject(so_28689_sa_40340_so_3721);
		 so_28689_sa_40340_so_3721.putUtfString("containGames","VipBaccarat");
		 so_28689_sa_40340_so_3721.putInt("hi",3);
		 so_28689_sa_40340_so_3721.putUtfString("hn","VipBaccarat");
		  SFSObject so_28689_sa_40340_so_39611 = new SFSObject();
		so_28689_sa_40340.addSFSObject(so_28689_sa_40340_so_39611);
		 so_28689_sa_40340_so_39611.putUtfString("containGames","BIDBaccarat");
		 so_28689_sa_40340_so_39611.putInt("hi",4);
		 so_28689_sa_40340_so_39611.putUtfString("hn","BIDBaccarat");
		  SFSObject so_28689_sa_40340_so_44809 = new SFSObject();
		so_28689_sa_40340.addSFSObject(so_28689_sa_40340_so_44809);
		 so_28689_sa_40340_so_44809.putUtfString("containGames","Baccarat,LongHu,FastBaccarat,Roulette,Dice");
		 so_28689_sa_40340_so_44809.putInt("hi",0);
		 so_28689_sa_40340_so_44809.putUtfString("hn","MultHall");
		   so_28689.putUtfString("phoneName","");
		 so_28689.putUtfString("StakeServerIds","");
		 so_28689.putUtfString("p","F17A5800-FBA5-41B9-B96A-427A4F66B6FB");
		 
	 

		return so_28689;
	}
}//end VLoginHallResponse