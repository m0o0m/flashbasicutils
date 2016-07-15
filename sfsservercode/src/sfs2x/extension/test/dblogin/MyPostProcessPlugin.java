package sfs2x.extension.test.dblogin;

import java.util.HashMap;
import java.util.Map;

import com.smartfoxserver.v2.components.signup.SignUpConfiguration;
import com.smartfoxserver.v2.components.signup.SignUpValidationException;
import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;

import com.smartfoxserver.v2.components.signup.ISignUpAssistantPlugin;

public class MyPostProcessPlugin implements ISignUpAssistantPlugin {
	private final String zoneName;
	private int age;
    
    public MyPostProcessPlugin(String zoneName)
    {
        this.zoneName = zoneName;
    }
     
    @Override
    public void execute(User user, ISFSObject params, SignUpConfiguration config) throws SignUpValidationException
    {
        // By default we just insert a line break
        String message = "<br />";
         
        // If age below 18 we show a message 
       // if (params.getInt("age") < 18) 
        if(true)
            message = "<p>Since your age is below 18, in-game purchases will not be available</p>";
                     
        Map<String, String> customMailFields = new HashMap<String, String>();
        customMailFields.put("${ageComment}", message);
        customMailFields.put("${gameWelcome}", "Welcome to the " + zoneName + " game.");
         
        // Pass the new fields to the Component's configuration
        config.emailResponse.customEmailFields = customMailFields;  
    }

}
