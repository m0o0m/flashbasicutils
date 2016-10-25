package views
{
	import com.hurlant.crypto.symmetric.AESKey;
	import com.hurlant.crypto.symmetric.CBCMode;
	import com.hurlant.crypto.symmetric.DESKey;
	import com.hurlant.crypto.symmetric.ECBMode;
	import com.hurlant.util.Base64;
	import com.hurlant.util.Hex;
	import com.smartfoxserver.v2.SmartFox;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import mx.core.ByteArrayAsset;
	
	import sfsservertest.Connector;
	
	import views.jiami.JiamiUtil;
	import views.jiami.decodeLoad.Symbol;
	import views.jiami.util.StreamFileLoader;

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
	
	/*
	 * 
	swf加密解密:
	1.Index.swf:处理初始xml,skin.swf(未加密),main.swf(加密)
	2.Symbol_ClsSymbol.swf:当做元数据绑定到Symbol_ClsSymbol.as并发布进Index.swf中,
	3.所有加密的swf通过loadApp()的方式加载
	
	
	*/
	public class JiaMiView extends ViewBase
	{
		private var connector:Connector;
		private var streamLoader:StreamFileLoader;
		
		
		private var symbolData:*;
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
				content.load_btn.addEventListener(MouseEvent.CLICK,loadHandler);
			}
			super.render();
			//一个128位字节长度的key
			var keybyteArr:ByteArray = new ByteArray();
			keybyteArr.length = 128;
			var temp:AESKey = new AESKey(keybyteArr);
			//需要处理的值
			var valuebyteArr:ByteArray = new ByteArray();
			valuebyteArr.length = 1280;
			//从16开始处理,默认一次读写16位字节
			temp.encrypt(valuebyteArr,16);
			//scene = this;
		}
		private function loadHandler(e:MouseEvent):void
		{
			//streamLoader = new StreamFileLoader();
			//streamLoader.loadSWF("assets/jiami/test.swf",loadCompleteHandler,loadprogressHandler);
//			streamLoader.loadSWF("assets/jiami/test-encrypt.swf",loadCompleteHandler,loadprogressHandler);
			userDefindDecode();
		}
		private function loadCompleteHandler(suc:Boolean):void
		{
			trace(suc);
			content.addChild(streamLoader.content);
		}
		private function loadprogressHandler(prog:String):void
		{
			trace(prog);
		}
		//======================
		private function userDefindDecode():void
		{
			initSymbol();
			
		}
		private var _symbol:MovieClip;
		private var _appLoader:StreamFileLoader;
		private var _baseURL:String;
		private var _scene:Sprite;
		private function initSymbol() : void
		{
			var symbolData:* = new Symbol["ClsSymbol"]();
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function (event:Event) : void
			{
				_symbol = (event.currentTarget as LoaderInfo).content as MovieClip;
				event.currentTarget.removeEventListener(event.type, arguments.callee);
				loadApp();
				return;
			}// end function
			);
			loader.loadBytes(symbolData);
			return;
		}// end function
		private function loadApp() : void
		{
			this._appLoader = new StreamFileLoader(this.baseURL+"assets/jiami/");
			this._appLoader.loadFileWithStream("test-encrypt.swf", function (contents:ByteArray) : void
			{
				if (!contents)
				{
					trace("Load Game Failed, please retry again.");
				}
				else
				{
					/*
					 * 
					scene:添加到此舞台
					content:加载进来的已经加密的swf  二进制
					arg[2]:加密方式AESKey,默认值
					arg[3]:
					args[4]:设置是网络上运行还是本地运行
					*/
					addChlid(scene, contents, null,JiaMiView, true);
				}
				return;
			}// end function
			);
			return;
		}// end function
		/**
		 *在Index.swf中,默认创建一个 scene,并添加到Index.swf中
		 * 加载的main.swf,添加到scene中,并在main.as中,通过this.parent.parent 获取到Index.swf的实例
		 * 通过loading['addChlid'](_stage, data, callback, null, isDebug)方式,将加载进来的二进制加密数据添加到指定舞台上
		 * 
		 * 不管是loader 加载还是URLStream (loadBytes()),之后数据存储在content中,可以直接添加到显示列表中
		 * @param args
		 * 
		 */
		public function addChlid(... args) : void
		{
			/*
			override public function addFrameScript(... args) : void
			{
			args = args;
			jump = function(data:ByteArray):void
			{
			if(args.length >= 4)
			{
			args[3][Math.random() * 100000] = data;
			}
			};
			if(!args[4])
			{
			var url:String = args[0].loaderInfo.url;
			if(url.indexOf("http://") != 0 && Boolean(url.indexOf("https://") != 0) && Boolean(url.indexOf("app:/") != 0))
			{
			var lock:Boolean = true;
			while(lock)
			{
			trace("");
			}
			}
			}
			addSWF(args[0],args[1],AESKey,null != args[3]?jump:null,args[2]);
			}
			*/
			this._symbol.addFrameScript(args[0], args[1], args[2], args[3], args[4]);
			return;
		}// end function
		public function get scene() : Sprite
		{
			if (!this._scene)
			{
				this._scene = new Sprite();
				addChild(this._scene);
			}
			return this._scene;
		}// end function
		
		public function set scene(value:Sprite) : void
		{
			this._scene = value;
			return;
		}// end function
		
		public function get baseURL() : String
		{
			var _loc_1:String = null;
			var _loc_2:int = 0;
			if (!this._baseURL)
			{
				_loc_1 = stage.loaderInfo.url;
				_loc_2 = _loc_1.lastIndexOf(".swf");
				if (_loc_2 != -1)
				{
					_loc_1 = _loc_1.slice(0, _loc_2);
				}
				_loc_2 = _loc_1.lastIndexOf("/");
				if (_loc_2 != -1)
				{
					_loc_1 = _loc_1.slice(0, (_loc_2 + 1));
				}
				this._baseURL = _loc_1;
			}
			return this._baseURL;
		}// end function
		//-----------------------------------------
		
		private function jiamiHandler(e:MouseEvent):void{
			content.jiami_ta.text = JiamiUtil.encrypt(content.jiemi_ta.text,content.key_ta.text);
		}
		private function jiemiHandler(e:MouseEvent):void{
			content.jiemi_ta.text = JiamiUtil.decrypt(content.jiami_ta.text,content.key_ta.text);
		}
		
		override public function close():void
		{
			this._scene.removeChildren();
			this._scene = null;
			super.close();
		}
	}
}