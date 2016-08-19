package sfs2x.extension.vgame;

import sfs2x.extension.vgame.server.GameConfig;

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
					String currentZoneName = GameConfig.SFSExtion.getParentZone().getName();
					
					if(user!=null)
					{
						if(currentZoneName.equals("hall") ||currentZoneName.equals("bacc"))
						{
							V201EventHandler v201 = new V201EventHandler();
							V217EventHandler v217 = new V217EventHandler();
							GameConfig.SFSExtion.send("201", v201.so_65697, user);
							GameConfig.SFSExtion.send("217", v217.so_829, user);
						}
						
						if(currentZoneName.equals("bacc"))
						{
							V212EventHandler v212 = new V212EventHandler();
							GameConfig.SFSExtion.send("212", v212.so_98877, user);
							
							V214EventHandler v214 = new V214EventHandler();
							GameConfig.SFSExtion.send("214", v214.so_7186, user);
						}
						
					}

	}
}//end PingEventHandler