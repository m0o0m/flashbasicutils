package  com.wg.design 
{
	import com.wg.error.Err;
	
	import deng.fzip.FZip;
	import deng.fzip.FZipFile;
	
	import flash.utils.Dictionary;

	public class Design 
	{
		private var _uri:URI;
		
		
		private var _desginZipObject:Object;
		private var _desginZipDic:Dictionary;
		
		
		private var _desginData:Object;
		private var _designClassMetaData:DesignClassMetaData = new DesignClassMetaData;
		
		private var starTime:int;
		public function Design(uri:URI, initParams:Object=null, initZipFile:FZip = null)
		{
			_uri = uri;
			for (var i:String in initParams) {
				this[i] = initParams[i];
			}
			_desginZipObject = {};
			_desginZipDic = new Dictionary;
			
//			var urlLoader:URLLoader = new URLLoader();
//			urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
//			urlLoader.addEventListener(Event.COMPLETE, onCompleteHandler);
//			urlLoader.load(new URLRequest(uri.getConfigPath()));
			
			var fCount:int = initZipFile.getFileCount();
			for(var fIndex:int = 0; fIndex < fCount; fIndex++)
			{
				var fzipFile:FZipFile = initZipFile.getFileAt(fIndex);
				_desginZipObject[fzipFile.filename] = fzipFile.content.toString();
			}
		}
		
		public function load(designClass:Class, key:*=null, occurErrorWhenNull:Boolean=true) : *
		{
			var strClass:* = designClass
			var indexStr:String = String(designClass).replace("[class ","").replace("]","");
			if(_desginZipDic[indexStr] == null){
				var str:String = _desginZipObject[indexStr+".json"]
				_desginZipDic[indexStr] = JSON.parse(str);//com.adobe.serialization.json.JSON.decode(str);
			}
			
			var metaData:Object = _designClassMetaData.getMetaData(designClass);
			var formattedKey:Object = this.formatKey(metaData['pk'], key);	//相当于键值		
			var objects:* = this.loadByFormattedKey(designClass, metaData['name'], metaData['pk'], formattedKey);//根据键值从对象中找数据

			if (objects == null && occurErrorWhenNull) {
				Err.occur(Errno.CLIENT_ERROR, {
					desc: "design class [" + designClass + "] key [" + key + "] not found"
				});
				return null;
			}
			return objects;
		}
		
		private function formatKey(primaryKey:Array, key:*) : Object
		{
			var formattedKey:Object = {};
			if (key === null) {
				key = {};
			}
			
			if (key is int ||
				key is Number ||
				key is String ||
				key is uint
			) {
				formattedKey[primaryKey[0]] = key;
			}
			else if (key is Array) {
				for (var i:uint = 0; i < key.length; ++i) {
					formattedKey[primaryKey[i]] = key[i];
				}
			}
			else {
				formattedKey = key;
			}			
			return formattedKey;
		}
						
		private function loadByFormattedKey(designClass:Class, className:String, primaryKey:Array, formattedKey:Object) : *
		{
//			var objects:* = this._desginData[className];
			
			var strClass:* = designClass
			var indexStr:String = String(designClass).replace("[class ","").replace("]","");
			
			var objects:* = this._desginZipDic[indexStr];
			if (objects == null) {
				return null;
			}
			
			for (var keyIndex:uint = 0; keyIndex < primaryKey.length; ++keyIndex) {
				var key:* = formattedKey[primaryKey[keyIndex]];
				if (key == null) {
					break;
				}				
				objects = objects[key];
				if (objects == null) {
					break;
				}
			}
			
			if (objects == null) {
				return null;
			}
			
			objects = createDesignObjects(designClass, objects, primaryKey.length - keyIndex);
			if (keyIndex == primaryKey.length) {
				return objects[0];
			}
			else {
				return objects;
			}
		}
		
		private function createDesignObjects(designClass:Class, objects:Object, level:uint) : Array
		{
			if (level != 0) {
				var designObjects:Array = [];
				for each (var object:Object in objects) {
					designObjects = designObjects.concat(this.createDesignObjects(designClass, object, level - 1));
				}
				return designObjects;
			}
			else 
			{
//				if(designClass!=TableLang&&designClass!=ClientLang)
					//只解析到第一层次
					for (var i:String in objects)
					{	
						if(objects[i] is Array)
						{
							var temArr:Array = objects[i] as Array;
							var len:int = temArr.length;
							for(var j:int =0;j<len;j++)
							{
									temArr[j] = (temArr[j]);
							}
						}
						else
						{
							objects[i] = objects[i];
						}
					}
				return [new designClass(objects, _uri)];
			}
		}
	}
}