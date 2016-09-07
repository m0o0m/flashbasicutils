package pg1
{
	public class Class1Child extends Class1
	{
		public function Class1Child()
		{
			//super();
			this.func1();
			this.func2();
			this.func3();
		}
		override public function func1():void
		{}
		override internal function func2():void
		{}
		override protected function func3():void
		{}
		private function func4():void
		{}
	}
}