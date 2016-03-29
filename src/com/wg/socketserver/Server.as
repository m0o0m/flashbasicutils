package com.wg.socketserver 
{
	
	import com.wg.error.Err;
	import com.wg.logging.Log;
	import com.wg.mvc.DataBase;
	import com.wg.mvc.MVCConstant;
	import com.wg.mvc.MVCManager;
	import com.wg.mvc.interfaces.event.IServerNotifier;
	import com.wg.socketserver.messages.MessageClassCmd;
	import com.wg.socketserver.messages.interfaces.IMessage;
	import com.wg.serialization.CppStream;
	import com.wg.utils.arrayUtils.ArrayUtil;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import flash.utils.getTimer;
	
	import mymvc.constant.ConstantCls;
	
	public class Server implements IServerNotifier
	{
		
		private var _host:String;
		private var _port:uint;
		private var _proxyPort:uint;
		private var _endian:String = Endian.BIG_ENDIAN;
		private var _compress:Boolean = false;
		private var _defaultMessageDenyMillisecond:uint = 100;
		private var _onConnect:Function;
		private var _onClose:Function;
		private var _onMessageHandled:Function;
		
		public var _socket:Socket;// = new Socket;
		private var _useProxy:Boolean = false;		
		private var _connectSucceed:Boolean = false;
		private var _packLen:int = -1;
		private var _deniedMessages:Array = [];
		private var _messageHandlers:Array = [];
		private var _messageClassCmd:MessageClassCmd = new MessageClassCmd;
		
		public function Server( initParams:*=null)
		{
			if (initParams != null) {
				for (var i:String in initParams) {
					this[i] = initParams[i];
				}
			}
		}
		
		/**
		 * use the heartBeat CMD　to sync server time.
		 * Alex 2013.05.16 
		 */		
		private var _lastSyncSeverTimestamp:Number = 0;
		private var _lastSycServerTimeZoneOffset:int = 0;
		private var _lastSyncSeverTimestampRunTime:int = 0;
		
		public function updateServerTimestamp(timestamp:Number, timeZoneOffset:int):void
		{
			_lastSyncSeverTimestamp = timestamp;
			_lastSyncSeverTimestampRunTime = getTimer();
			_lastSycServerTimeZoneOffset = timeZoneOffset;
		}
		
		public function getServerTimestamp():Number
		{
			return _lastSyncSeverTimestamp + getTimer() - _lastSyncSeverTimestampRunTime;
		}
		
		public function getServerToClientLocalTime():Number//ms
		{
			return getServerTimestamp() - _lastSycServerTimeZoneOffset * 1000;
		}
		
		public function set onConnect(onConnect:Function) : void
		{
			_onConnect = onConnect;
		}
		
		public function set onClose(onClose:Function) : void
		{
			_onClose = onClose;
		}
		
		public function set onMessageHandled(onMessageHandled:Function) : void
		{
			_onMessageHandled = onMessageHandled;
		}
		
		public function get defaultMessageDenyMillisecond():uint
		{
			return _defaultMessageDenyMillisecond;
		}
		public function set defaultMessageDenyMillisecond(messageDenyMillisecond:uint) : void
		{
			_defaultMessageDenyMillisecond = messageDenyMillisecond;
		}
		
		public function connect() : void
		{
			if (!_host || !_port) {
				Err.occur(Errno.CLIENT_ERROR, { 
					desc: "host [" + this._host + "] or port [" + this._port + "] not set"
				});
				return;
			}
			if(!_socket)
			{
				_socket = new Socket();
			}
			addListener();
//			if (_socket.connected){
//				_socket.close();
//			}
			
			Log.debug("connect server " + this._host + ":" + this._port);
			if(_socket.connected )
			{
				onConnectHandler(null);
			}else
			{
			_socket.connect(_host, _port);
			}
		}
		
		public function close() : void
		{
			if (_socket && _socket.connected) {
				_socket.close();
			}
		}
		
		public function send(message:*, denyMillisecond:int=-1) : void
		{
			message as IMessage;
			Log.debug("send message [" + message.getName() + "]");
			trace("send message [" + message.getName() + "]");
			if (denyMillisecond < 0) {
				denyMillisecond = this._defaultMessageDenyMillisecond;
			}
			if (_socket.connected == false) {
				Err.occur(Errno.SERVER_CONNECTION_CLOSED);
				return;
			}		
			if (isMessageDenied(message.getCmd())) {
				Log.warn("message [" + message.getCmd() + "] is denied");
				return;
			}
			
			sendMessage(message);
			denyMessage(message.getCmd(), denyMillisecond);
		}
		
		public function isMessageDenied(message:*) : Boolean
		{
			var messageCmd:uint;
			if (message is Class) {
				messageCmd = _messageClassCmd.getCmd(message);
			}
			else {
				messageCmd = message as uint;
			}
			
			var denyTime:* = _deniedMessages[messageCmd];
			if (denyTime && denyTime >= new Date().getTime()) {
				return true;
			}
			else {
				return false;
			}
		}
		
		public function denyMessage(message:*, denyMillisecond:uint) : void
		{
			var messageCmd:uint;
			if (message is Class) {
				messageCmd = _messageClassCmd.getCmd(message);
			}
			else {
				messageCmd = message as uint;
			}
			
			_deniedMessages[messageCmd] = new Date().getTime() + denyMillisecond;
		}
		
		public function registerMessageHandler(type:String, handler:Function = null) : void
		{
//			var messageCmd:uint = _messageClassCmd.getCmd(messageClass);
			if (_messageHandlers[type]) {
				var found:Boolean = false;
				for (var i:uint = 0; i < _messageHandlers[type].length; ++i) {
					if (_messageHandlers[type][i] == handler) {
						found = true;
						Log.warn("message[" + type + "] handler[" + handler + "] already registered");
						break;
					}
				}
				if (!found) {
					_messageHandlers[type].push(handler);
				}
			}
			else {
				_messageHandlers[type] = [handler];
			}
		}
		
		public function cancelMessageHandler(type:String, handler:Function) : void
		{
//			var messageCmd:uint = _messageClassCmd.getCmd(messageClass);
			if (_messageHandlers[type]) {
				var found:Boolean = false;
				for (var i:uint = 0; i < _messageHandlers[type].length; ++i) {
					if (_messageHandlers[type][i] == handler) {
						found = true;
						_messageHandlers[type].splice(i, 1);
						break;
					}
				}
				if (!found) {
					Log.warn("message[" + type + "] handler[" + handler + "] not found");
				}
			}
			else {
				Log.warn("message[" + type + "] handler[" + handler + "] not found");
			}
		}
		
		private function set host(host:String) : void
		{
			this._host = host;
		}
		
		private function set port(port:uint) : void
		{
			this._port = port;
		}
		
		private function set proxyPort(port:uint) : void
		{
			this._proxyPort = port;
		}		
		
		private function set endian(endian:String) : void
		{
			this._endian = endian;
		}
		
		private function set compress(compress:Boolean) : void
		{
			this._compress = compress;
		}
		
		private function addListener() : void
		{
			_socket.addEventListener(Event.CONNECT, onConnectHandler);
			_socket.addEventListener(IOErrorEvent.IO_ERROR, onIoErrorHandler);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorHandler);
			_socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketDataHandler);
			_socket.addEventListener(Event.CLOSE, onCloseHandler);
		}
		
		private function removeListener() : void
		{
			_socket.removeEventListener(Event.CONNECT, onConnectHandler);
			_socket.removeEventListener(IOErrorEvent.IO_ERROR, onIoErrorHandler);
			_socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorHandler);
			_socket.removeEventListener(ProgressEvent.SOCKET_DATA, onSocketDataHandler);
			_socket.removeEventListener(Event.CLOSE, onCloseHandler);
		}
		
		private function onConnectHandler(event:Event = null) : void
		{
			_socket.endian = _endian;			
			_packLen = -1;

			if (_useProxy) {
				onConnectProxyHandler();
			}
			else {
				onConnectServerHandler();
			}
		}
		
		private function onCloseHandler(event:Event) : void
		{
			Log.trace("与服务器连接关闭");
			
			_connectSucceed = false;
			if (_onClose is Function) {
				_onClose();
			}
		}		
		
		private function onConnectProxyHandler() : void
		{
			this._socket.endian = Endian.BIG_ENDIAN;			
			
			this._socket.writeByte(127);
			this._socket.writeByte(0);
			this._socket.writeByte(0);
			this._socket.writeByte(1);
			this._socket.writeShort(this._port);
			
			this._socket.endian = this._endian;
			this.onConnectServerHandler();
		}
		
		private function onConnectServerHandler() : void
		{
			_connectSucceed = true;
			if (_onConnect is Function) {
				_onConnect();
			}
		}
		
		private function onIoErrorHandler(event:IOErrorEvent) : void
		{
			if (_useProxy == false){
				connectProxy();
			}
			else {
				Err.occur(Errno.SERVER_CANNOT_CONNECT, {
					desc:"cannot cannot game server "+_host+":"+_port
				});
			}
		}
		
		private function onSecurityErrorHandler(event:SecurityErrorEvent) : void
		{
			if (_useProxy == false) {
				connectProxy();
			}
			else {
				Err.occur(Errno.CLIENT_ERROR, {
					desc:"sandbox security error"
				});
			}
		}
		
		private function onSocketDataHandler(event:ProgressEvent) : void
		{
			/*测试用*/
			var msg:String = "";
				if(_socket.bytesAvailable)
				{
					var templenbuffer:ByteArray = new ByteArray();
					templenbuffer.endian = this._endian;

					msg = _socket.readUTFBytes(_socket.bytesAvailable);
					
//					msg = _socket.readByte()+"\n";
					_onMessageHandled(msg+"\n");
					
					var strarr:Array = msg.split(",");
					
					//模拟数据   1,2,asfdfsdf   asfdfsdfw为testmessagereponse 的 type字段(按顺序读取)
					var tempbuffer:ByteArray = new ByteArray();
					tempbuffer.endian = this._endian;
					tempbuffer.writeByte(int(strarr[0]));
					tempbuffer.writeByte(int(strarr[1]));
					
					var bytes:ByteArray = new ByteArray;
					bytes.writeUTFBytes(strarr[2]);
					tempbuffer.writeUnsignedInt(bytes.length);
					tempbuffer.writeBytes(bytes);
					
					tempbuffer.position = 0;
					var message:* = parseMessage(tempbuffer);
					
					tempbuffer.clear();
					_packLen = -1;
					
					handleMessage(message);
					message = null;
					return;
				}
				
			while (_socket.bytesAvailable >= _packLen) {
				//读取存储flags+cmd-length+cmd 的长度的字节;
				if (_packLen == -1 && _socket.bytesAvailable >= 4) {
					var lenBuffer:ByteArray = new ByteArray;
					lenBuffer.endian = this._endian;
					_socket.readBytes(lenBuffer, 0, 4);
					_packLen = lenBuffer.readUnsignedInt();
				}
				
				//还没有完全接收到所有的包;
				if (_packLen == -1 || _socket.bytesAvailable < _packLen) {
					break;
				}
				//读取cmd 的内容;flags+cmd-length的内容在这里读取取出;
				var buffer:ByteArray = recvMessageBuffer(_packLen);
				//根据主命令编码和子命令编码创建消息对象;
				var message:* = parseMessage(buffer);
				
				buffer.clear();
				_packLen = -1;
				
				handleMessage(message);
				message = null;
			}
		}
		
		private function connectProxy() : void
		{
			if (_connectSucceed == true) {
				Log.warn("game server already connected");
				return;
			}
			
			_socket.close();
			removeListener();
			
			_useProxy = true;
			_socket = new Socket();
			addListener();
			
			Log.debug("connect proxy " + this._host + ":" + this._proxyPort);
			
			_socket.connect(_host, _proxyPort);
		}
		
		private function sendMessageBuffer(msgBuffer:ByteArray) : void
		{
			var controlByte:int = 0;
			if (_compress) {
				// zlib 压缩的数据格式
				msgBuffer.compress();
				controlByte = 1;
			}
			//调整指针位置;
			msgBuffer.position = 0;			
			
			var sendBuffer:ByteArray = new ByteArray;
			sendBuffer.endian = this._endian;
			
			sendBuffer.writeByte(controlByte);//一个字节,低八位;
			sendBuffer.writeUnsignedInt(msgBuffer.length);//消息长度;无符号整数32位;
			sendBuffer.writeBytes(msgBuffer);//将字节数组写入字节流中;
			
			var lenBuffer:ByteArray = new ByteArray;
			lenBuffer.endian = this._endian;
			lenBuffer.writeUnsignedInt(sendBuffer.length);
			
			_socket.writeBytes(lenBuffer);
			_socket.writeBytes(sendBuffer);
			_socket.flush();//发送数据;
		}
		
		private function recvMessageBuffer(len:uint) : ByteArray
		{
			var buffer:ByteArray = new ByteArray;
			buffer.endian = this._endian;			
			_socket.readBytes(buffer, 0, len);
			
			var controlByte:uint = buffer.readUnsignedByte();
			var msgBufferLen:uint = buffer.readUnsignedInt();
			
			var messageBuffer:ByteArray = new ByteArray;
			messageBuffer.endian = _endian;
			buffer.readBytes(messageBuffer);
			
			if (controlByte) {
				
				Log.warn("server data is compressed, controlByte=[" + controlByte + "]");
// now disable process compressed data				
//				messageBuffer.uncompress();
//				messageBuffer.position = 0;
			}
			
			return messageBuffer;
		}
		
		private function sendMessage(message:IMessage) : void
		{
			var buffer:ByteArray = new ByteArray;
			buffer.endian = _endian;
			message.serialize(new CppStream(buffer));//将消息的编码和内容转换为字节写入字节数组中
			sendMessageBuffer(buffer);
		}		
		
		private function parseMessage(buffer:ByteArray) : *
		{
			var majorCmd:uint = buffer.readUnsignedByte();
			var minorCmd:uint = buffer.readUnsignedByte();
			
			//cmd 为消息类的唯一标识符,通过主命令编码*2的8次方+子命令编码得到;
			//类绑定在messageclasscmd 中完成;通过配置文档自动生成;
			//一般发送消息和接收消息类的子命令编码相差一;
			var cmd:uint = (majorCmd << 8) + minorCmd;		
			var message:* = createMessageByCmd(cmd);		
			buffer.position = 0;
			message.unserialize(new CppStream(buffer));
			return message;
		}
		
		/**
		 * 
		 * @param message 没有指定类型,这里可以创建任何server与后台通讯的类型;
		 * 
		 */
		private function handleMessage(message:*) : void
		{
			Log.debug("handle message [" + message.getName() +" "+message.getCmd()+ "]");
			var servercommadName:String = ConstantCls.instance.getCommandNameByClass(_messageClassCmd.getClass(message.getCmd()));
			var handlers:Array = _messageHandlers[servercommadName];
			if (handlers) {
				var loopHandlers:Array = ArrayUtil.cloneArray(handlers);				

//				var profilerTag:String = "Handle Message " + message.getName();
//				Profiler.enter(profilerTag);

				(loopHandlers as Array).forEach(function(handler:Function, index:int, array:Array) : void {
					handler(message);
				});

//				Profiler.exit(profilerTag);
			}

//			_dataBase.notifyEvent(_messageClassCmd.getClass(message.getCmd()), message);
			
			//将消息传送到mvc中;
//			MVCManager.data.notifyEvent(servercommadName,message);
		}

		private function createMessageByCmd(cmd:uint) : *
		{
			var messageClass:Class = _messageClassCmd.getClass(cmd);
			return new messageClass;
		}
	}
}