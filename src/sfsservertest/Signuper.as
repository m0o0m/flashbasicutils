package sfsservertest
{
	import com.adobe.crypto.MD5;
	import com.hurlant.crypto.Crypto;
	import com.smartfoxserver.v2.SmartFox;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import com.smartfoxserver.v2.requests.ExtensionRequest;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	/**
	 *1.注册用户前,先匿名登录到某一空间再注册账号或是通过其他途径注册;
	 * 2.第一次登录时,应激活验证,如果需要的话;激活验证时需要先登录已经注册的账号; 
	 * @author Administrator
	 * 
	 */	
	public class Signuper extends SFSOperator
	{
		// The SignUp extension command
		private var CMD_SUBMIT:String = "$SignUp.Submit";
		// The SignUp extension command
		private var CMD_ACTIVATE:String = "$SignUp.Activate";
		// The SignUp extension command
		private var CMD_RESEND_EMAIL:String = "$SignUp.ResendEmail";
		// The SignUp Password Recovery command
		private var CMD_RECOVER:String = "$SignUp.Recover";
		private var basiczone:String;


		public function Signuper(_sfs:SmartFox, _content:MovieClip)
		{
			super(_sfs, _content);
			content.signup_btn.addEventListener(MouseEvent.CLICK,signuphandler);
			sfs.addEventListener(SFSEvent.EXTENSION_RESPONSE, onExtensionResponse);
			content.jihuo_btn.addEventListener(MouseEvent.CLICK,jihuohandler);
			content.resendemail_btn.addEventListener(MouseEvent.CLICK,resendhandler);
			content.findpwd_btn.addEventListener(MouseEvent.CLICK,findpwdhandler);
		}
		//将密码发送到邮箱里;
		private function findpwdhandler(e:MouseEvent):void
		{
			var sfso:ISFSObject = new SFSObject();
			sfso.putUtfString("name", content.pwdusername_txt.text);
			
			sfs.send(new ExtensionRequest(CMD_RECOVER, sfso));
			
		}
		private function resendhandler(e:MouseEvent):void
		{
			var params:SFSObject = new SFSObject();
			params.putUtfString("email", content.email_txt.text);
			
			// Request a new email with the activation code
			sfs.send(new ExtensionRequest(CMD_RESEND_EMAIL, params));

			
		}
		private function jihuohandler(e:MouseEvent):void
		{
			var sfso:SFSObject = new SFSObject();
			sfso.putUtfString("act_code", content.tf_activation.text);
			
			sfs.send(new ExtensionRequest(CMD_ACTIVATE, sfso));
			
		}
		private function signuphandler(e:MouseEvent):void
		{
			trace(MD5.hash(content.signuserpwd_txt.text));
			var sfso:SFSObject = new SFSObject();
			sfso.putUtfString("name", content.signusername_txt.text);
			sfso.putUtfString("pword", content.signuserpwd_txt.text);
			sfso.putUtfString("email", content.email_txt.text);
			sfso.putInt("age",int(content.signage_txt.text));
			if(!sfs.config)
			{
				basiczone = "BasicExamples";
			}else
			{
				basiczone = sfs.config.zone;
			}
			sfso.putUtfString("zone",basiczone);
			sfs.send(new ExtensionRequest(CMD_SUBMIT, sfso));
		}
		
		
		/**
		 *待解决问题:服务端内置错误信息无法获取到; 已解决
		 * @param evt
		 * 
		 */
		private function onExtensionResponse(evt:SFSEvent):void
		{
			var cmd:String = evt.params["cmd"];
			var sfso:ISFSObject = evt.params["params"];
			
			if (cmd == CMD_SUBMIT)
			{
				//如果注册成功,则会返回消息,如果服务端报错而没有向客户端抛出错误,那么这里不响应;
				if (sfso.containsKey("errorMessage"))
				{
					dTrace("SignUp Error:" + sfso.getUtfString("errorMessage"));
				}
				else if (sfso.containsKey("success"))
				{
					dTrace("Success, thanks for registering");
				}
			}
			if (cmd == CMD_ACTIVATE)
			{
				if (sfso.getBool("success"))
					dTrace("Thanks, your account has been activated");
				else
					dTrace("Activation Error:" + sfso.getUtfString("errorMessage"));
			}
			
			if (cmd == CMD_RECOVER)
			{
				if (sfso.getBool("success"))
					trace("The password was sent to your email box");
				else
					trace("Password Recovery Error:" + sfso.getUtfString("errorMessage"));
			}


		}
		
		

	}
}