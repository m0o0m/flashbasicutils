package sfs2x.extension.test.dblogin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.smartfoxserver.bitswarm.sessions.ISession;
import com.smartfoxserver.v2.core.ISFSEvent;
import com.smartfoxserver.v2.core.SFSEventParam;
import com.smartfoxserver.v2.db.IDBManager;
import com.smartfoxserver.v2.exceptions.SFSErrorCode;
import com.smartfoxserver.v2.exceptions.SFSErrorData;
import com.smartfoxserver.v2.exceptions.SFSException;
import com.smartfoxserver.v2.exceptions.SFSLoginException;
import com.smartfoxserver.v2.extensions.BaseServerEventHandler;

/*
 * 使用sfs配置访问数据库
 * 注意数据库驱动的存放位置 extension/__lib__
 * 
 * */
public class LoginEventHandler extends BaseServerEventHandler
{

	@Override
	public void handleServerEvent(ISFSEvent event) throws SFSException
	{
		// Grab parameters from client request
		trace("====handleServerEvent start====");
		String userName = (String) event.getParameter(SFSEventParam.LOGIN_NAME);
		String cryptedPass = (String) event.getParameter(SFSEventParam.LOGIN_PASSWORD);
		ISession session = (ISession) event.getParameter(SFSEventParam.SESSION);
		
		// Get password from DB
		IDBManager dbManager = getParentExtension().getParentZone().getDBManager();
		Connection connection = null;
		//这里做各种验证,如果验证不正确,则需要抛出异常给客户端,以便终止登录流程;
		if( userName.length() <= 0&&cryptedPass.length() <= 0)
    	{
			/*if (IsLogin)
			{
				try
				{
					// 登录成功
					loginUser = helper.canLogin(nick, ClientPassword, chan, this.currentZone.getName());
					response.put("_cmd", "loginOK");
					response.put("id", String.valueOf(loginUser.getUserId()));
					response.put("name", loginUser.getName());
				}
				catch (LoginException e)
				{
					// 登录失败
					response.put("_cmd", "loginKO");
					response.put("err", e.getMessage());
				}
			}
			else
			{
				response.put("_cmd", "loginKO");
				response.put("err", "认证失败.");
			}*/
    	}else{//数据库验证
    		try
            {
            	
            		// Grab a connection from the DBManager connection pool
        	        connection = dbManager.getConnection();
        	        
        	        // Build a prepared statement
        	        PreparedStatement stmt = connection.prepareStatement("SELECT pword,id FROM muppets WHERE name=?");
        	        stmt.setString(1, userName);
        	        
        	        // Execute query
        			ResultSet res = stmt.executeQuery();
        			
        			// Verify that one record was found
        			//如果登录名在数据库中被找到
        			if (!res.first())
        			{
        				// This is the part that goes to the client
        				SFSErrorData errData = new SFSErrorData(SFSErrorCode.LOGIN_BAD_USERNAME);
        				errData.addParameter(userName);
        				// This is logged on the server side
        				//这里 的错误是抛给服务端的,服务端再触发登录失败的消息发送给客户端;
        				throw new SFSLoginException("Bad user name: " + userName, errData);
        			}
        			
        			String dbPword = res.getString("pword");
        			int dbId = res.getInt("id");
        			
        			// Verify the secure password
        			//验证安全的密码
        			if (!getApi().checkSecurePassword(session, dbPword, cryptedPass))
        			{
        				SFSErrorData data = new SFSErrorData(SFSErrorCode.LOGIN_BAD_PASSWORD);
        				data.addParameter(userName);
        				
        				throw new SFSLoginException("Login failed for user: "  + userName, data);
        			}
        			// Store the client dbId in the session
        			//如果验证通过,那么存储数据,并发送用户登录空间请求,登录到指定的空间中;
        			session.setProperty(DBLogin.DATABASE_ID, dbId);
            	}
            	
    			
    			
            
            // User name was not found
            catch (SQLException e)
            {
            	SFSErrorData errData = new SFSErrorData(SFSErrorCode.GENERIC_ERROR);
            	errData.addParameter("SQL Error: " + e.getMessage());
            	
            	throw new SFSLoginException("A SQL Error occurred: " + e.getMessage(), errData);
            }

    		finally
    		{
    			// Return connection to the DBManager connection pool
    			try {
    				connection.close();
    			} catch (SQLException e) {
    				// TODO Auto-generated catch block
    				e.printStackTrace();
    			}
    		}
    		
    	}
		
	

        
	}
}
