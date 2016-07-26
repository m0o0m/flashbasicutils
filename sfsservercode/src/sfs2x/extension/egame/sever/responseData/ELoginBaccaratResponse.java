package sfs2x.extension.egame.sever.responseData;

import com.smartfoxserver.v2.entities.data.SFSArray;
import com.smartfoxserver.v2.entities.data.SFSObject;
/**
 * @author Administrator
 * @version 1.0
 * @created 25-七月-2016 14:16:04
 */
public class ELoginBaccaratResponse extends EGameResponse {

	public ELoginBaccaratResponse(){

	}

	/**
	 * 
	 * @exception Throwable
	 */
	public void finalize()
	  throws Throwable{

	}

	/**
	 * @param so    so
	 * 
	 * @param so    so
	 */
	public SFSObject responseData(SFSObject outData){

		
		//outData.putSFSObject("p", so);
		//自定义的信息会自动加入到一个(sfs_object) p:中;
		outData.putInt("maxBet", 10000);
		outData.putInt("type", 0);
		outData.putInt("minBet", 1);
		SFSArray so_sa = new SFSArray();
		outData.putSFSArray("history", so_sa);
		
		
		outData.putUtfString("nickName", "houxl001");
		outData.putDouble("balance", 501.7);
		outData.putUtfString("currency", "RMB");
		//Object obj = {"lastDayData":[{"id":1,"day":2023},{"id":3,"day":2019},{"id":12,"day":2021},{"id":8,"day":2022},{"id":11,"day":2023},{"id":10,"day":2020},{"id":7,"day":2028},{"id":6,"day":2028},{"id":5,"day":2020},{"id":4,"day":2023},{"id":9,"day":2022}],"isPassSendPoker":false,"chips":[],"isMiPoker":true,"customVersion":"07151810"};
		outData.putUtfString("custom", "{\"lastDayData\":[{\"id\":1,\"day\":2023},{\"id\":3,\"day\":2019},{\"id\":12,\"day\":2021},{\"id\":8,\"day\":2022},{\"id\":11,\"day\":2023},{\"id\":10,\"day\":2020},{\"id\":7,\"day\":2028},{\"id\":6,\"day\":2028},{\"id\":5,\"day\":2020},{\"id\":4,\"day\":2023},{\"id\":9,\"day\":2022}],\"isPassSendPoker\":false,\"chips\":[],\"isMiPoker\":true,\"customVersion\":\"07151810\"}");
		
		outData.putUtfString("test", "这里是登录返回...");
		return outData;
	}
}//end ELoginBaccaratResponse