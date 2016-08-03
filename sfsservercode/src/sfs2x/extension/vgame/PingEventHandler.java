package sfs2x.extension.vgame;

import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.extensions.BaseClientRequestHandler;


/**
 * 心跳消息,发送内容保持连接
 * @author Administrator
 * @version 1.0
 * @created 02-八月-2016 16:43:49
 */
public class PingEventHandler extends BaseClientRequestHandler {

	public PingEventHandler(){

	}

	public void finalize() throws Throwable {
		super.finalize();
	}
	/**
	 * 
	 * @param user
	 * @param arg1
	 */
	@Override
	public void handleClientRequest(User user, ISFSObject arg1){
		// TODO Auto-generated method stub
					send("101",null,user);
	}
}//end PingEventHandler