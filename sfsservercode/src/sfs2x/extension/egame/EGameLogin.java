package sfs2x.extension.egame;

import com.smartfoxserver.v2.core.SFSEventType;
import com.smartfoxserver.v2.extensions.SFSExtension;
public class EGameLogin extends SFSExtension {

	@Override
	public void init() {
		// TODO Auto-generated method stub
		addEventHandler(SFSEventType.USER_LOGIN, ELoginEventHandler.class);
		addRequestHandler("101",PingEventHandler.class);
		addRequestHandler("108",E108EventHandler.class);
		addRequestHandler("109",E109EventHandler.class);
		addRequestHandler("104",E104EventHandler.class);
	}
	@Override
	public void destroy()
	{
	    super.destroy();
	}

}
