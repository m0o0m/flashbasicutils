package sfs2x.extension.egame.sever.responseData;

import com.smartfoxserver.v2.entities.data.SFSArray;
import com.smartfoxserver.v2.entities.data.SFSObject;

import sfs2x.extension.egame.sever.responseData.EGameResponse;

/**
 * @author Administrator
 * @version 1.0
 * @created 25-七月-2016 17:40:14
 */
public class ELoginSicboResponse  extends EGameResponse {

	public ELoginSicboResponse(){

	}

	public void finalize() throws Throwable {
		super.finalize();
	}
	/**
	 * 
	 * @param so    so
	 */
	public SFSObject responseData(SFSObject outData){
		//outData.putShort("pi", (short) 0);//为用户登录信息,sfs自动添加到返回数据中
				//outData.putShort("rs", (short) 0);//为用户登录信息,sfs自动添加到返回数据中
				//outData.putUtfString("un", "houxl001_27168");//为用户登录信息,sfs自动添加到返回数据中
				//outData.putSFSArray("rl", new SFSArray());//为用户登录信息,sfs自动添加到返回数据中
				//outData.putInt("id", 4);//为用户登录信息,sfs自动添加到返回数据中
				//outData.putUtfString("zn", "ShaiZi");//为用户登录信息,sfs自动添加到返回数据中
				SFSObject so = new SFSObject();
				//outData.putSFSObject("p", so);
				//自定义的信息会自动加入到一个(sfs_object) p:中;
				outData.putInt("maxBet", 10000);
				outData.putInt("type", 0);
				outData.putInt("minBet", 1);
				SFSArray so_sa = new SFSArray();
				outData.putSFSArray("history", so_sa);
				SFSObject so_sa_so1;
				so_sa_so1 = new SFSObject();
				so_sa.addSFSObject(so_sa_so1);
				so_sa_so1.putUtfString("b", "5,1,2;8");
				
				so_sa_so1 = new SFSObject();
				so_sa.addSFSObject(so_sa_so1);
				so_sa_so1.putUtfString("b", "2,4,6;12");
				
				so_sa_so1 = new SFSObject();
				so_sa.addSFSObject(so_sa_so1);
				so_sa_so1.putUtfString("b", "5,2,3;10");
				
				outData.putUtfString("nickName", "houxl001");
				outData.putDouble("balance", 501.7);
				outData.putUtfString("currency", "RMB");
				//Object obj = {"lastDayData":[{"id":1,"day":2023},{"id":3,"day":2019},{"id":12,"day":2021},{"id":8,"day":2022},{"id":11,"day":2023},{"id":10,"day":2020},{"id":7,"day":2028},{"id":6,"day":2028},{"id":5,"day":2020},{"id":4,"day":2023},{"id":9,"day":2022}],"isPassSendPoker":false,"chips":[],"isMiPoker":true,"customVersion":"07151810"};
				outData.putUtfString("custom", "{\"lastDayData\":[{\"id\":1,\"day\":2023},{\"id\":3,\"day\":2019},{\"id\":12,\"day\":2021},{\"id\":8,\"day\":2022},{\"id\":11,\"day\":2023},{\"id\":10,\"day\":2020},{\"id\":7,\"day\":2028},{\"id\":6,\"day\":2028},{\"id\":5,\"day\":2020},{\"id\":4,\"day\":2023},{\"id\":9,\"day\":2022}],\"isPassSendPoker\":false,\"chips\":[],\"isMiPoker\":true,\"customVersion\":\"07151810\"}");
				
				outData.putUtfString("test", "这里是登录返回...");
				return outData;
	}
}//end ELoginSicboResponse