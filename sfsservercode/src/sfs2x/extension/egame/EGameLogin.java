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
		addRequestHandler("110",E110EventHandler.class);
		addRequestHandler("103",E103EventHandler.class);
		addRequestHandler("113",E113EventHandler.class);
		addRequestHandler("111",E111EventHandler.class);
		addRequestHandler("114",E114EventHandler.class);
		addRequestHandler("107",E107EventHandler.class);
		addRequestHandler("105",E105EventHandler.class);
		addRequestHandler("106",E106EventHandler.class);
	}
	@Override
	public void destroy()
	{
		removeEventHandler(SFSEventType.USER_LOGIN);
		removeRequestHandler("101");
		removeRequestHandler("108");
		removeRequestHandler("109");
		removeRequestHandler("104");
		removeRequestHandler("110");
		removeRequestHandler("113");
		
		removeRequestHandler("111");
		removeRequestHandler("114");
		removeRequestHandler("107");
		removeRequestHandler("105");
		removeRequestHandler("106");
	    super.destroy();
	}

}
