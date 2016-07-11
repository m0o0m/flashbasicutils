package sfs2x.extension.test.dblogin;

import com.smartfoxserver.v2.core.SFSEventType;
import com.smartfoxserver.v2.extensions.SFSExtension;
/**
 * @author Administrator
 *api的使用
 *1.getapi()方法:返回sfsapi实例,sfs服务器的总管理者
 *2.The SmartFoxServer class,比如
 *ISFSGameApi gameApi = SmartFoxServer.getInstance().getAPIManager().getGameApi();返回gameapi 管理game块
    ISFSBuddyApi buddyApi = SmartFoxServer.getInstance().getAPIManager().getBuddyApi();
3.Data classes  各种实体的类  比如 room user sfsroomevent 等;

 */
public class DBLogin extends SFSExtension
{
	public static final String DATABASE_ID = "dbid";
	
	@Override
	public void init()
	{
		trace("Database Login Extension -- started");
		//没有响应...
		//如果需要在这里响应,那么对应zone的customlogin要打开,打开后使用这里做登录验证
		addEventHandler(SFSEventType.USER_LOGIN, LoginEventHandler.class);
		addEventHandler(SFSEventType.USER_JOIN_ZONE, ZoneJoinEventHandler.class);
		//addEventHandler(SFSEventType.USER_JOIN_ROOM,LoginEventHandler.class);
		addRequestHandler("testobjData",DataRequestHandler.class);
	}
	
	@Override
	public void destroy()
	{
	    super.destroy();
	    removeEventHandler(SFSEventType.USER_LOGIN);//没有响应...
	    removeEventHandler(SFSEventType.USER_JOIN_ZONE);
	    removeEventHandler(SFSEventType.USER_JOIN_ROOM);
		removeRequestHandler("testobjData");
	    trace("Database Login Extension -- stopped");
	}
	
}
