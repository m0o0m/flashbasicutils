package sfs2x.extension.test.dblogin;

import java.util.Arrays;
import com.smartfoxserver.v2.components.login.ILoginAssistantPlugin;
import com.smartfoxserver.v2.components.login.LoginData;

import com.smartfoxserver.v2.components.login.LoginAssistantComponent;
import com.smartfoxserver.v2.components.signup.SignUpAssistantComponent;
import com.smartfoxserver.v2.core.SFSEventType;
import com.smartfoxserver.v2.extensions.SFSExtension;
import com.smartfoxserver.v2.security.DefaultPermissionProfile;
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
	private SignUpAssistantComponent suac;
	private LoginAssistantComponent lac; 
	@Override
	public void init()
	{
		trace("Database Login Extension -- started");
		//没有响应...
		//如果需要在这里响应,那么对应zone的customlogin要打开,打开后使用这里做登录验证;
		//如果关闭,则使用server中的登录验证;
		//匿名登录逻辑另写,并且启动privilege manager??
		addEventHandler(SFSEventType.USER_LOGIN, LoginEventHandler.class);
		addEventHandler(SFSEventType.USER_JOIN_ZONE, ZoneJoinEventHandler.class);
		//addEventHandler(SFSEventType.USER_JOIN_ROOM,LoginEventHandler.class);
		addRequestHandler("testobjData",DataRequestHandler.class);
		SignUpRequestManager signupmanager = new SignUpRequestManager();
		signupmanager.zoneName = getParentZone().getName();
		suac = signupmanager.getSuac();
		addRequestHandler(SignUpAssistantComponent.COMMAND_PREFIX,suac );
       // addRequestHandler(SignUpAssistantComponent.COMMAND_PREFIX, new SignUpRequestHandler.class);
		//initLoginAssistant();
		
	}
	//验证用户是否已经激活
	private void initLoginAssistant()
	{
		lac = new LoginAssistantComponent(this);
		
		lac.getConfig().loginTable = "muppets";
		lac.getConfig().nickNameField = "name";
		lac.getConfig().passwordField = "pword";
		lac.getConfig().userNameField = "email";
		suac.getConfig().userIsActiveField = "active";
		lac.getConfig().extraFields = Arrays.asList( "age", "zone");
		lac.getConfig().activationErrorMessage = "Your account has not been activated yet!";
		
		
		lac.getConfig().postProcessPlugin = new ILoginAssistantPlugin()
		{
			@Override
			public void execute(LoginData loginData)
			{
				loginData.session.setProperty("$permission", DefaultPermissionProfile.STANDARD);
			}
		};
	}
	@Override
	public void destroy()
	{
	    super.destroy();
	    lac.destroy();
	    removeEventHandler(SFSEventType.USER_LOGIN);
	    removeEventHandler(SFSEventType.USER_JOIN_ZONE);
	    removeEventHandler(SFSEventType.USER_JOIN_ROOM);
		removeRequestHandler("testobjData");
	    trace("Database Login Extension -- stopped");
	}
	
}
