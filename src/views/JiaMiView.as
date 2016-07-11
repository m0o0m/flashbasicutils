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
			content.jiami_ta.text = encrypt(content.jiemi_ta.text,content.key_ta.text);
		}
		private function jiemiHandler(e:MouseEvent):void{
			content.jiemi_ta.text = decrypt(content.jiami_ta.text,content.key_ta.text);
		}
		/**
		 *解密函数 
		 * @param data
		 * @param key
		 * @return 
		 * 
		 */
		public  function decrypt(data:String, key:String):String {
			
			/*
			var keyBytes:ByteArray = new ByteArray();
			keyBytes.writeUTFBytes(key);
			var pt:ByteArray = Hex.toArray(data);
			var des:DESKey = new DESKey(keyBytes);
			var cbc:CBCMode = new CBCMode(des);
			cbc.IV = keyBytes;
			cbc.decrypt(pt);
			*/
			trace("\n执行解密方法，key:",key,"，需要解密的字符串：",data);
			
			//实验化key的Bytearray对象，给DESKey使用
			var b_keyByteArray:ByteArray=new ByteArray(); 
			b_keyByteArray.writeUTFBytes(key);
			
			//实例化DESKey
			var b_desKey:DESKey=new DESKey(b_keyByteArray);
			
			//
			var b_ecb:ECBMode=new ECBMode(b_desKey);
			
			//把需要加密字符串转换为ByteArray
			var b_byteArray:ByteArray=Base64.decodeToByteArray(data);
			
			//执行解密
			b_ecb.decrypt(b_byteArray);
			return Hex.toString(Hex.fromArray(b_byteArray));
		}
		/**
		 * 加密
		 * @param key 加解密用的key
		 * @param data 被加密的字符串
		 * @return 加密后生成ByteArray数据
		 */		
		private function encrypt(data:String,key:String):String{
			trace("执行加密方法，key:",key,"，被加密的字符串：",data);
			
			//实验化key的Bytearray对象，给DESKey使用
			var b_keyByteArray:ByteArray=new ByteArray(); 
			b_keyByteArray.writeUTFBytes(key);
			
			//实例化DESKey
			var b_desKey:DESKey=new DESKey(b_keyByteArray);
			
			//不只是有ecb还有cbc,cfb等，有兴趣可以自己尝试
			var b_ecb:ECBMode=new ECBMode(b_desKey);
			var bytes:ByteArray; 
			if (data) 
			{ 
				bytes=new ByteArray(); 
				bytes.writeUTFBytes(data); 
			} 
			//把需要加密字符串转换为ByteArray
			var b_byteArray:ByteArray=bytes;
			
			//执行加密
			b_ecb.encrypt(b_byteArray);
			
			//字符串形式的密文
			var b_ciphertext:String=Base64.encodeByteArray(b_byteArray);
			//trace("密文:",b_ciphertext);
			//trace("十六进制形式密文:",byteArrayTo16(b_byteArray));
			
			return b_ciphertext;
		}
		/**
		 * 把ByteArray转换为16进制的形式的字符串
		 * @param ba
		 * @param name
		 * @return 
		 */		
		private function byteArrayTo16(ba:ByteArray):String{
			ba.position=0;
			var b_str:String="";
			while (ba.bytesAvailable > 0) {
				b_str+=ba.readUnsignedByte().toString(16);
			}
			return b_str;
		}
		
	}
}