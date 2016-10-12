package pg1
{
	import pg2.Class1Child3;
	
	public class Class1
	{
		public function Class1()
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
		
		
		private  var class2:Class2 = new Class2();
		private var class3:Class3 = new Class3();
		private function childTest():void{
			//类是独立的,不管是继承还是实现了什么,只要是在作用域范围内,都可以被使用;
			//不可在class1 外部实例化,因为class1此时还没有编译完成,不能被引用;
			 var child1:Class1Child = new Class1Child();
			 var child2:Class1Child2 = new Class1Child2();
			 var child3:Class1Child3 = new Class1Child3();
			
			//同包子类
			child1.func1();//public 可以读取	c
			child1.func2();//internal 可以读取	c
			child1.func3();//protected 可以读取 (在父类中读取子类实例) p
			//child1.func4();//private 无法读取
			(child1 as Class1).func4();//当被当做父类型时,在父类内部可调用父类
			//顶层包
			child2.func1();//c 当父类方法可以被重写时,子类重写后,外部根据包情况选择读取子类或父类的可以用的方法;
			child2.func2();//p 当无法读取子类的方法的时候,读取父类可用的
			child2.func3();//p 
			(child2 as Class1).func4();
			
			//不同包子类
			child3.func1();//c
			child3.func2();//p
			child3.func3();//p
			(child3 as Class1).func4();
			
			class2.func1();
			class2.func2();
			
			class3.func1();
			class3.func2();
			
		}
	}

}
//对本文件内可见,其他任何地方不可见;
var  pg1_var:String = "";
class Class3{
	public function func1():void
	{}
	internal function func2():void
	{}
	protected function func3():void
	{}
	private function func4():void
	{}
};