package sfs2x.extension.vgame;

import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.entities.data.SFSArray;
import com.smartfoxserver.v2.entities.data.SFSObject;
import com.smartfoxserver.v2.extensions.BaseClientRequestHandler;


/**
 * @author Administrator
 * @version 1.0
 * @created 02-八月-2016 16:58:57
 */
public class V104EventHandler extends BaseClientRequestHandler {

	public V104EventHandler(){

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
	public void handleClientRequest(User user, ISFSObject arg1){
		
		
//		CreateRoomSettings crs = new CreateRoomSettings();
//		
//		//new ExtensionRequest(message, params,room),客户端指定extension 为room级别时;
//		String className = "sfs2x.extension.egame.VGameLogin";
//		RoomExtensionSettings extension = new RoomExtensionSettings("javaLogintest", className );
//		crs.setExtension(extension );
//		
//		crs.setName("G7M1104511");
//		try {
//			getApi().createRoom(user.getZone(), crs ,user);
//			
//		} catch (SFSCreateRoomException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		Room lobby = getParentExtension().getParentZone().getRoomByName("G7M1104511");
//		try {
//			getApi().joinRoom(user,lobby);
//		} catch (SFSJoinRoomException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		SFSObject so = new SFSObject();
send("104",so,user);
	}
}//end V104EventHandler