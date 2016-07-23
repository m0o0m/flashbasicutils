package sfs2x.extension.egame;

import com.smartfoxserver.bitswarm.sessions.ISession;
import com.smartfoxserver.v2.core.ISFSEvent;
import com.smartfoxserver.v2.core.SFSEventParam;
import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.entities.data.SFSArray;
import com.smartfoxserver.v2.entities.data.SFSObject;
import com.smartfoxserver.v2.exceptions.SFSException;
import com.smartfoxserver.v2.extensions.BaseServerEventHandler;

public class ELoginEventHandler extends BaseServerEventHandler {

	@Override
	public void handleServerEvent(ISFSEvent event) throws SFSException {
		// TODO Auto-generated method stub
		String userName = (String) event.getParameter(SFSEventParam.LOGIN_NAME);
		User user =(User) event.getParameter(SFSEventParam.USER);
		ISFSObject sfso = new SFSObject();
		//The custom data to return to the user after a successful login 
		//用户还没有登录到系统中,所以没有user
		//send("login",sfso,user);
		ISFSObject outData = (ISFSObject) event.getParameter(SFSEventParam.LOGIN_OUT_DATA);
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
		so_sa_so1.putUtfString("b", "5,2,3,10");
		
		outData.putUtfString("nickName", "houxl001");
		outData.putDouble("balance", 501.7);
		outData.putUtfString("currency", "RMB");
		//Object obj = {"lastDayData":[{"id":1,"day":2023},{"id":3,"day":2019},{"id":12,"day":2021},{"id":8,"day":2022},{"id":11,"day":2023},{"id":10,"day":2020},{"id":7,"day":2028},{"id":6,"day":2028},{"id":5,"day":2020},{"id":4,"day":2023},{"id":9,"day":2022}],"isPassSendPoker":false,"chips":[],"isMiPoker":true,"customVersion":"07151810"};
		outData.putUtfString("custom", "{\"lastDayData\":[{\"id\":1,\"day\":2023},{\"id\":3,\"day\":2019},{\"id\":12,\"day\":2021},{\"id\":8,\"day\":2022},{\"id\":11,\"day\":2023},{\"id\":10,\"day\":2020},{\"id\":7,\"day\":2028},{\"id\":6,\"day\":2028},{\"id\":5,\"day\":2020},{\"id\":4,\"day\":2023},{\"id\":9,\"day\":2022}],\"isPassSendPoker\":false,\"chips\":[],\"isMiPoker\":true,\"customVersion\":\"07151810\"}");
		
		
		
		outData.putUtfString("test", "这里是登录返回...");
		
	}

}
