package namespacetest
{
	//use namespace version1;//编译器不可使用 
	public class NClass1
	{
		//public namespace version1 = "hello world";
		public function NClass1()
		{
			
		}
		public function func1():void
		{}
		internal function func2():void
		{}
		protected function func3():void
		{}
		private function func4():void
		{}
		//编译器不可使用
		/*version1 function func5():void
		{
			trace("version1 function func5()");
		}*/
	}
}