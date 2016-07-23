package sfs2x.extension.test.dblogin;

import java.util.Arrays;

import com.smartfoxserver.v2.components.signup.ISignUpAssistantPlugin;
import com.smartfoxserver.v2.components.signup.PasswordMode;
import com.smartfoxserver.v2.components.signup.RecoveryMode;
import com.smartfoxserver.v2.components.signup.SignUpAssistantComponent;
import com.smartfoxserver.v2.components.signup.SignUpErrorCodes;
import com.smartfoxserver.v2.components.signup.SignUpValidationException;
import com.smartfoxserver.v2.components.signup.SignUpConfiguration;
import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.extensions.BaseClientRequestHandler;

public class SignUpEventManager {

	private SignUpAssistantComponent suac;
	public String zoneName = "";
	public SignUpEventManager(){
		init();
	}
	public void init()
    {
		// TODO Auto-generated method stub
		setSuac(new SignUpAssistantComponent());
		//重写errormessage抛出的消息内容;
		suac.getConfig().errorMessages.put(SignUpErrorCodes.INVALID_EMAIL, "%s doesn't look like a valid email address. Please provide one.");
		suac.getConfig().errorMessages.put(SignUpErrorCodes.USERNAME_ALREADY_IN_USE,"%s 用户名已经被使用");
		
		//指定自定义的数据表已经字段,如果没有指定,默认为table:users (id,username,password,email)
				//详见官方文档http://docs2x.smartfoxserver.com/DevelopmentBasics/signup-assistant-basics
				//
				getSuac().getConfig().signUpTable = "muppets";
				getSuac().getConfig().usernameField = "name";
				getSuac().getConfig().passwordField = "pword";
				getSuac().getConfig().emailField = "email";
			    getSuac().getConfig().extraFields = Arrays.asList( "age", "zone");

				// Set limits for min/max name and password length
			    suac.getConfig().minUserNameLength = 4;
			    suac.getConfig().maxUserNameLength = 30;
			    suac.getConfig().minPasswordLength = 8;
			    suac.getConfig().maxPasswordLength = 30;
			 // Add a pre-process plugin for custom validation
			    //对年龄的验证
			    suac.getConfig().preProcessPlugin = new ISignUpAssistantPlugin()
			    {
			        @Override
			        public void execute(User user, ISFSObject params, SignUpConfiguration config) throws SignUpValidationException
			        {
			            Integer age = params.getInt("age");
			            String country = params.getUtfString("country");
			 
			            if (age == null)
			                throw new SignUpValidationException(SignUpErrorCodes.CUSTOM_ERROR, "The age is missing");
			         
			            if (age < 14)
			                throw new SignUpValidationException(SignUpErrorCodes.CUSTOM_ERROR, "You must be at least 14 years old to access this game");
			             
			 
			           // if (country == null || country.length() < 2)
			           //    throw new SignUpValidationException(SignUpErrorCodes.CUSTOM_ERROR, "Pleas specify your country");
			        }
			        
			        
			    };
			    //设置后发送过来的密码自动加密;然后保存到数据库中;
			    //suac.getConfig().passwordMode = PasswordMode.MD5;
				//打开后如果有同样的邮箱已经被使用,则不能再使用这个邮箱注册账号
				getSuac().getConfig().checkForDuplicateEmails = false;
			    //要首先有个用户登录成功,然后再注册,就显示注册成功;
			    //可以是个guest用户;
				
				//验证邮箱,功能暂时不可用,发送不出去
				suac.getConfig().emailResponse.isActive = true;
				//
				suac.getConfig().emailResponse.fromAddress = "1119209174@qq.com";
				suac.getConfig().emailResponse.subject = "Thanks for signing up!";
				suac.getConfig().emailResponse.template = "SignUpEmailTemplates/SignUpConfirmation.html";
				suac.getConfig().postProcessPlugin = new MyPostProcessPlugin(zoneName);
				//增加激活的功能,当指定了这个字段后,sfs会自动生成验证字符串保存到以下指定的字段中;
				suac.getConfig().activationCodeField = "act_code";
				//当客户端将上面生成的验证码发送到服务端后,下面的表字段填入"Y";
				suac.getConfig().userIsActiveField = "active";

				//密码恢复操作
				suac.getConfig().passwordRecovery.isActive = true;
				suac.getConfig().passwordRecovery.mode = RecoveryMode.SEND_OLD;
				suac.getConfig().passwordRecovery.email.fromAddress = "1119209174@qq.com";
				suac.getConfig().passwordRecovery.email.subject = "Password recovery service";
				suac.getConfig().passwordRecovery.email.template = "SignUpEmailTemplates/PasswordRecovery.html";
				
	}



	public SignUpAssistantComponent getSuac() {
		return suac;
	}


	private void setSuac(SignUpAssistantComponent suac) {
		this.suac = suac;
	}

}
