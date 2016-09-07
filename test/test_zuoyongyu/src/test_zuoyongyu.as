package
{
	import flash.display.Sprite;
	
	import namespacetest.NClass2;
	
	import pg1.Class1;
	import pg1.Class1Child;
	
	public class test_zuoyongyu extends Sprite
	{
		
		//如果变量没有定义类型,那么编辑工具不会提示可使用代码;
		private var child1:Class1Child = new Class1Child();
		public function test_zuoyongyu()
		{
			var class1:Class1 = new Class1();
			class1.func1();
			
			child1.func1(); 
			var nclass2:NClass2 =  new NClass2();
		} 
	}
}