package sfs2x.extension.egame;

import com.smartfoxserver.v2.components.login.LoginAssistantComponent;
import com.smartfoxserver.v2.extensions.SFSExtension;

public class LoginEventManager {
	private SFSExtension sfs;
	public LoginEventManager(SFSExtension sfs){
		this.sfs = sfs;
		
	}
	private LoginAssistantComponent lac;
	public LoginAssistantComponent getLac() {
		if(lac==null)
		{
			lac = new LoginAssistantComponent(sfs);
		}
		return lac;
	}
	public void setLac(LoginAssistantComponent lac) {
		this.lac = lac;
	}
	private void setConfigs(){
		
	}
}
