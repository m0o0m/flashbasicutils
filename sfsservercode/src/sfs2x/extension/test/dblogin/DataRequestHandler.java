package sfs2x.extension.test.dblogin;

import java.util.Collection;

import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.entities.data.SFSObject;
import com.smartfoxserver.v2.extensions.BaseClientRequestHandler;;

public class DataRequestHandler extends BaseClientRequestHandler {
	@Override
    public void handleClientRequest(User sender, ISFSObject params)
    {
        // Get the client parameters
        byte id = params.getByte("id");
        short health = params.getShort("health");
        Collection<Integer> pos = params.getIntArray("pos");
        String name = params.getUtfString("name");
          
        ISFSObject sfso = new SFSObject();
        
        sfso.putByte("id", id);
        sfso.putShort("health", health);
        sfso.putIntArray("pos", pos);
        sfso.putUtfString("name", name);
        sfso.putInt("sum", 123456);
        // Do something cool with the data...
        trace(id,health,pos,name);
        send("testobjData", sfso, sender);
    }

}
