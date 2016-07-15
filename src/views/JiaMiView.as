package views
{
	import com.hurlant.crypto.symmetric.CBCMode;
	import com.hurlant.crypto.symmetric.DESKey;
	import com.hurlant.crypto.symmetric.ECBMode;
	import com.hurlant.util.Base64;
	import com.hurlant.util.Hex;
	import com.smartfoxserver.v2.SmartFox;
	
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import sfsservertest.Connector;
	
	import views.jiami.JiamiUtil;

	/**
	 * http://crypto.hurlant.com/demo/srcview/
	 * @author Administrator
	 * 
 As3 Crypto 是一个 ActionScript 编写的加密库，提供多种常用的加密解密算法支持，同时包含一个 TLS 引擎：

Protocols: TLS 1.0 support (partial)
Certificates: X.509 Certificate parsing and validation, built-in Root CAs.
Public Key Encryption: RSA (encrypt/decrypt, sign/verify)
Secret Key Encryption: AES, DES, 3DES, BlowFish, XTEA, RC4
Confidentiality Modes: ECB, CBC, CFB, CFB8, OFB, CTR
Hashing Algorithms: MD2, MD5, SHA-1, SHA-224, SHA-256
Paddings available: PKCS#5, PKCS#1 type 1 and 2
Other Useful Stuff: HMAC, Random, TLS-PRF, some ASN-1/DER parsing
	 */
	public class JiaMiView extends ViewBase
	{
		private var connector:Connector;
		public function JiaMiView()
		{
			panelName = "jiami";
			super();
		}

		override protected function render():void
		{
			if(!content)
			{
				var maincls:Class = Config.resourceLoader.getClass(panelName);
				content = new maincls();
				this.addChild(content);
				content.jiami_btn.addEventListener(MouseEvent.CLICK,jiamiHandler);
				content.jiemi_btn.addEventListener(MouseEvent.CLICK,jiemiHandler);
			}
			super.render();
			
			
		}
		private function jiamiHandler(e:MouseEvent):void{
			content.jiami_ta.text = JiamiUtil.encrypt(content.jiemi_ta.text,content.key_ta.text);
		}
		private function jiemiHandler(e:MouseEvent):void{
			content.jiemi_ta.text = JiamiUtil.decrypt(content.jiami_ta.text,content.key_ta.text);
		}
		
		
	}
}