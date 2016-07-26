package sfs2x.extension.egame;

import sfs2x.extension.egame.sever.GameConfig;

import com.smartfoxserver.v2.core.SFSEventType;
import com.smartfoxserver.v2.extensions.SFSExtension;
public class EGameLogin extends SFSExtension {

	@Override
	public void init() {
		// TODO Auto-generated method stub
		GameConfig.hm.put(GameConfig.BACCARAT_ZONE, "Baccarat");
		GameConfig.hm.put(GameConfig.BLACKJACK_ZONE,"BlackJack");
		GameConfig.hm.put(GameConfig.CARIBBEAN_ZONE, "Caribbean");
		GameConfig.hm.put(GameConfig.FREEBACCARAT_ZONE, "FreeBaccarat");
		GameConfig.hm.put(GameConfig.LONGHU_ZONE, "Longhu");
		GameConfig.hm.put(GameConfig.NIU_ZONE, "Niu");
		GameConfig.hm.put(GameConfig.ROULETTE_ZONE, "Roulette");
		GameConfig.hm.put(GameConfig.SAFEBLACKJACK_ZONE, "SafeBlackJack");
		GameConfig.hm.put(GameConfig.SANGONG_ZONE, "Sangong");
		GameConfig.hm.put(GameConfig.SICBO_ZONE, "Sicbo");
		GameConfig.hm.put(GameConfig.YU_ZONE, "Yu");
		GameConfig.hm.put(GameConfig.TEXAS_ZONE, "Texas");
		
		
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
