package sfs2x.extension.test.dblogin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

import com.smartfoxserver.v2.core.ISFSEvent;
import com.smartfoxserver.v2.core.SFSEventParam;
import com.smartfoxserver.v2.db.IDBManager;
import com.smartfoxserver.v2.entities.Room;
import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.variables.SFSUserVariable;
import com.smartfoxserver.v2.entities.variables.UserVariable;
import com.smartfoxserver.v2.exceptions.SFSErrorCode;
import com.smartfoxserver.v2.exceptions.SFSErrorData;
import com.smartfoxserver.v2.exceptions.SFSException;
import com.smartfoxserver.v2.exceptions.SFSLoginException;
import com.smartfoxserver.v2.extensions.BaseServerEventHandler;

public class ZoneJoinEventHandler extends BaseServerEventHandler
{
	@Override
	public void handleServerEvent(ISFSEvent event) throws SFSException
	{
		User theUser = (User) event.getParameter(SFSEventParam.USER);
				
		new DBTest();
		
		
		// dbid is a hidden UserVariable, available only server side
		//uv_dbId 存储登录的用户存储在数据库中的唯一的id;对外界隐藏;
		UserVariable uv_dbId = new SFSUserVariable("dbid", theUser.getSession().getProperty(DBLogin.DATABASE_ID));
		uv_dbId.setHidden(true);
		
		// The avatar UserVariable is a regular UserVariable
		UserVariable uv_avatar = new SFSUserVariable("avatar", "avatar_" + theUser.getName() + ".jpg");
		
		// Set the variables
		List<UserVariable> vars = Arrays.asList(uv_dbId, uv_avatar);
		getApi().setUserVariables(theUser, vars);
		
		// Join the user
		Room lobby = getParentExtension().getParentZone().getRoomByName("The Lobby");
		//lobby.setPassword("123456");
		if (lobby == null)
			throw new SFSException("The Lobby Room was not found! Make sure a Room called 'The Lobby' exists in the Zone to make this example work correctly.");
		
		getApi().joinRoom(theUser, lobby);
	}
}
