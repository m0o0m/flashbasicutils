package
{
	import flash.display.Sprite;
	
	import namespacetest.NClass2;
	
	import pg1.Class1;
	import pg1.Class1Child;
	
	public class test_zuoyongyu extends Sprite
	{
		
		//如果变量没有定义类型,那么编辑工具不会提示可使用代码;
		//类是独立的,不管是继承还是实现,只要是在作用域范围内,都可以被使用;
		
		//在继承时,如果子类的继承的方法在作用域外使用,那么不会被允许,
		//但是会在父类中继续寻找,如果在父类中是可匹配的作用域,那么会调用父类中的方法
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