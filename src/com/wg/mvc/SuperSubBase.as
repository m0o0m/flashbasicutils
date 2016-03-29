package com.wg.mvc 
{
	import flash.utils.getQualifiedClassName;

	public class SuperSubBase extends Object 
	{
		private var _superBase:SuperBase;
		private var _module:String;
		
		public function SuperSubBase()
		{
			return;
		}
		
		/**
		 *返回对象的完全限定类名。 
		 * @return 
		 * 
		 */
		public function get sign() : String
		{
			return getQualifiedClassName(this);
		}

		public function __init(superBase:SuperBase, module:String) : void
		{
			_superBase = superBase;
			_module = module;
		}

		protected function get superBase() : SuperBase
		{
			return _superBase;
		}
		
		protected function get module() : String
		{
			return _module;
		}
				
		protected function throwInheritError() : String
		{
			throw new Error("请检查 " + this.sign + " 是否继承了正确的基类！");
		}
	}
}