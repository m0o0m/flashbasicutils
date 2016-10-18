package views.chat
{
	
	import flash.display.SimpleButton;
	import flash.display.Sprite;

    public interface IBoxUI extends IContent
    {

        public function IBoxUI();
		
		function get button():SimpleButton;

        function set id(param1:int) : void;

        function get icon() : Sprite;

        function set lock(param1:Boolean) : void;

        function set num(param1:String) : void;

        function set itemName(param1:String) : void;

        function set itemPrice(param1:String) : void;

        function set lockLight(param1:Boolean) : void;

        function set light(param1:Boolean) : void;
		
        function set itemQuality(param1:int) : void;
		function set mergeShow(p_boo:Boolean):void;
		function set showMergeComp(p_fun:Function):void;
		
    }
}
