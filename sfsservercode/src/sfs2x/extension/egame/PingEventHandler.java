package sfs2x.extension.egame;

import com.smartfoxserver.v2.api.CreateRoomSettings;
import com.smartfoxserver.v2.api.CreateRoomSettings.RoomExtensionSettings;
import com.smartfoxserver.v2.entities.Room;
import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.exceptions.SFSCreateRoomException;
import com.smartfoxserver.v2.exceptions.SFSJoinRoomException;
import com.smartfoxserver.v2.extensions.BaseClientRequestHandler;
//心跳消息,发送内容保持连接
public class PingEventHandler extends BaseClientRequestHandler{

	@Override
	public void handleClientRequest(User user, ISFSObject arg1) {
		// TODO Auto-generated method stub
		if(user.getJoinedRooms().size()!=0){
			
			send("101",null,user);
			return;
		}
			
		CreateRoomSettings crs = new CreateRoomSettings();
		
		//new ExtensionRequest(message, params,room),客户端指定extension 为room级别时;
		String className = "sfs2x.extension.egame.EGameLogin";
		RoomExtensionSettings extension = new RoomExtensionSettings("javaLogintest", className );
		crs.setExtension(extension );
		
		crs.setName("G7M1104511");
		try {
			getApi().createRoom(user.getZone(), crs ,user);
			
		} catch (SFSCreateRoomException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Room lobby = getParentExtension().getParentZone().getRoomByName("G7M1104511");
		try {
			getApi().joinRoom(user,lobby);
		} catch (SFSJoinRoomException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
