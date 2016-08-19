package views.utiltest
{
	import com.wg.utils.mathUtils.MathUtil;
	
	public class CodeElement{
		private var _name:String = "";
		private  var _code:String = "";
		private var _level:int = 0;
		private var _codetype:String = "";
		/**
		 *记录是不是父节点; 
		 */	
		private var _isParent:Boolean = false;
		//parent 外部指定;
		/**
		 *父节点首先在外部指定的是按照文本顺序的上一个节点,使得节点链可追溯;
		 * 然后在此类内部,根据level匹配,赋值成正确的 parent; 
		 */
		private var _parent:CodeElement ;
		private var _key:String;
		private var _value:String = "";
		public function CodeElement(){
			
		}
		
		public function get value():String
		{
			return _value;
		}
		
		public function set value(value:String):void
		{
			_value = value;
		}
		
		public function get key():String
		{
			return _key;
		}
		
		public function set key(value:String):void
		{
			_key = value;
		}
		
		public function get parent():CodeElement
		{
			return _parent;
		}
		
		public function set parent(value:CodeElement):void
		{
			_parent = value;
		}
		
		public function get code():String
		{
			return _code;
		}
		
		public function set code(value:String):void
		{
			_code = value;
		}
		
		public function get level():int
		{
			return _level;
		}
		
		public function set level(value:int):void
		{
			_level = value;
		}
		
		public function get isParent():Boolean
		{
			return _isParent;
		}
		
		
		public function get name():String
		{
			return _name;
		}
		
		public function set name(value:String):void
		{
			_name = value;
		}
		
		public function get codetype():String
		{
			return _codetype;
		}
		
		/**
		 * type做驱动,
		 * @param value
		 * 
		 */
		public function set codetype(value:String):void
		{
			_codetype = value;
			changeParentByLevel();
			switch(_codetype)
			{
				case "sfs_object":
					_isParent = true;
					
					if(_parent){
						_name = _parent.name+"_"+"so_"+MathUtil.getRandomNum(100,100000);
					}else
					{
						_name = "so_"+MathUtil.getRandomNum(100,100000);
					}
					_code = "SFSObject "+_name+" = new SFSObject();"+"\r";
					if(!this._key)this._key = _name;
					this._value = _name;
					//addToparent();
					if(_parent) addChildNode("SFSObject");
					break;
				case "sfs_array":
					_isParent = true;
					if(_parent){
						_name = _parent.name+"_"+"sa_"+MathUtil.getRandomNum(100,100000);
					}else
					{
						_name = "sa_"+MathUtil.getRandomNum(100,100000);
					}
					_code = "SFSArray "+_name+" = new SFSArray();"+"\r";
					if(!this._key)this._key = _name;
					this._value = _name;
					if(_parent) addChildNode("SFSArray");
					break;
				
				//子元素的添加
				case "int":
					addChildNode("Int");
					break;
				case "utf_string":
					addChildNode("UtfString",false);
					break;
				case "double":
					addChildNode("Double");
					break;
				case "bool":
					addChildNode("Bool");
					break;
				case "short":
					addChildNode("Short");
					break;
			}
		}
		private function changeParentByLevel():void
		{
			if(_parent)
			{
				//if(_isParent){
				if(_level<_parent.level)
				{
					_parent = _parent.parent;
					changeParentByLevel();
				}else if(_level==_parent.level)
				{
					_parent = _parent.parent;
				}
				//}
			}
		}
		private function addChildNode(funcName:String,isNumber:Boolean = true):void
		{
			var otherCode:String = "";
			if(funcName=="Short")
			{
				otherCode = "(short)";
			}
			_value = otherCode+_value;
			
			if(isNumber){
				if(_parent.codetype=="sfs_object"){
					_code += _parent.name +".put"+funcName+"(\""+_key+"\","+_value+");"+"\r";
				}else if(_parent.codetype=="sfs_array"){
					_code += _parent.name +".add"+funcName+"("+_value+");"+"\r";
				}
			}else
			{
				if(_parent.codetype=="sfs_object"){
					_code += _parent.name +".put"+funcName+"(\""+_key+"\",\""+_value+"\");"+"\r";
				}else if(_parent.codetype=="sfs_array"){
					_code += _parent.name +".add"+funcName+"(\""+_value+"\");"+"\r";
				}
			}
		}
		
		public function toString():String
		{
			return _code;
		}
	}
}