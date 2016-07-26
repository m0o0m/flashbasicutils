package sfs2x.extension.egame;

import sfs2x.extension.egame.sever.EgameFactory;
import sfs2x.extension.egame.sever.GameConfig;
import sfs2x.extension.egame.sever.game.EGame;
import sfs2x.extension.egame.sever.request.E108Request;

import com.smartfoxserver.v2.core.ISFSEvent;
import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.entities.data.SFSObject;
import com.smartfoxserver.v2.exceptions.SFSException;
import com.smartfoxserver.v2.extensions.BaseClientRequestHandler;
import com.smartfoxserver.v2.extensions.BaseServerEventHandler;

public class E108EventHandler extends BaseClientRequestHandler {


	@Override
	public void handleClientRequest(User arg0, ISFSObject arg1) {
		// TODO Auto-generated method stub
		SFSObject so = new SFSObject();
		EGame game = EgameFactory.getGame();
		if(game == null){
			GameConfig.gameType = arg0.getZone().getName();
			game = EgameFactory.createEgame(GameConfig.gameType);
		}
		game.setRequest(new E108Request("108"));
		game.sendData(so);
		send("108",so,arg0);
	}

}
