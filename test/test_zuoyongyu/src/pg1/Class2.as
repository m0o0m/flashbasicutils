package pg1
{
	public class Class2
	{
		public function Class2()
		{
			
			
		}
		public function func1():void
		{}
		internal function func2():void
		{}
		protected function func3():void
		{}
		private function func4():void
		{
			var class1:Class1 = new Class1();
			class1.func1();
			class1.func2();
			var class2:Class1Child = new Class1Child();
			class2.func1();
			class2.func2();
		}
	}
}