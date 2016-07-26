package sfs2x.extension.egame.sever.game;


/**
 * @author Administrator
 * @version 1.0
 * @created 25-七月-2016 16:55:54
 */
public class SafeBlackJackGame extends EGame {

	public SafeBlackJackGame(){

	}

	public void finalize() throws Throwable {
		super.finalize();
	}
}//end SafeBlackJackGame