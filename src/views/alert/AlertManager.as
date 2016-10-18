package views.alert
{
	import flash.display.MovieClip;
	import flash.display.Sprite;

	/**
	 *弹出指定的弹出框,如果没有设定弹出框,那么指定默认的; 
	 * @author Administrator
	 * 组件特征:
	 * 1.只有提示内容
	 * 2.拥有确定和取消按钮
	 * 3.关闭按钮
	 */
	public class AlertManager
	{
		private var _alert:IAlert;
		public static var STAGE_NORMAL_WIDTH:int = 1000;
		public static var STAGE_NORMAL_HEIGHT:int = 560;
		public static var ALERT_BUTTON_YES:uint = 1;
		public static var ALERT_BUTTON_NO:uint = 2;
		public static var STAGE_MAX_WIDTH:int = 1250;
		public static var STAGE_MAX_HEIGHT:int = 650;
		private static var _instance:AlertManager;
		public function AlertManager()
		{
			if(_instance)
			{
				throw new Error("单例");
			}
			return;
		}
		
		public static function get instance():AlertManager
		{
			if(!_instance) _instance = new AlertManager();
			return _instance;
		}

		 public function clear() : void
		{
			 close();
			 _alert = null;
			return;
		}
		
		 public function close() : void
		{
			if (_alert)
			{
				_alert.hide();
			}
		}
		
		public function hide() : void
		{
			if (_alert)
			{
				_alert.hide();
			}
		}
		
		public function reposition() : void
		{
			if (_alert)
			{
				_alert.reposition(AlertManager.STAGE_NORMAL_WIDTH, AlertManager.STAGE_NORMAL_HEIGHT, AlertManager.STAGE_MAX_WIDTH, AlertManager.STAGE_MAX_HEIGHT);
			}
		}
		
		public function confirm(alertInfoTxt:String, closeFunc:Function = null) : void
		{
			_alert.yesLabel = ("确定");
			_alert.show(alertInfoTxt, AlertManager.ALERT_BUTTON_YES, closeFunc);
		}
		
		public function showYesNoMsg(alertInfoTxt:String, yesBtnTxt:String = "确定", noBtnTxt:String = "取消", closeFunc:Function = null,showCheckBox:Boolean = false) : void
		{
			if(!_alert)
			{
				setAlert();
			}
			if(this.inStage) return;
			
			if(yesBtnTxt == "确定")
			{
				yesBtnTxt = ("确定");
			}
			if(noBtnTxt == "取消")
			{
				noBtnTxt = ("取消");
			}
			_alert.hasCheckbox = showCheckBox;
			_alert.yesLabel = yesBtnTxt;
			_alert.noLabel = noBtnTxt;
			_alert.show(alertInfoTxt, AlertManager.ALERT_BUTTON_YES | AlertManager.ALERT_BUTTON_NO, closeFunc);
		}
		
		public function showYes(alertInfoTxt:String, yesBtnTxt:String = "确定",  closeFunc:Function = null,showCheckBox:Boolean = false) : void
		{
			if(!_alert)
			{
				setAlert();
			}
			if(this.inStage) return;
			
			if(yesBtnTxt == "确定")
			{
				yesBtnTxt = ("确定");
			}
			_alert.hasCheckbox = showCheckBox;
			this._alert.yesLabel = yesBtnTxt;
			this._alert.show(alertInfoTxt, AlertManager.ALERT_BUTTON_YES , closeFunc);
		}
		
		public function socketClosed(reasonTxt:String = "") : void
		{
			var reason:String = reasonTxt;
			try
			{
				_alert.yesLabel = "确定";
				_alert.show(reason || "服务器的连接已断开！",AlertManager.ALERT_BUTTON_YES);
			}
			catch (e:int)
			{
			}
		}
		
		public function setAlert(mc:MovieClip = null,layer:Sprite = null) : void
		{
			if(!mc){
				//var cls:Class= view.resourceLoader.getClass("Alert");
//				mc = new cls();
			}
			if(!layer)
			{
//				layer = alertlayer;
			}
			if (!_alert)
			{

				_alert =(new AlertComp(mc)) as IAlert;
				//_alert.onLoadLang = onLoadLang;
				_alert.oParent = layer;
//				_alert.tip = view.tip.iTip;
				//reposition();
			}
		}
		
		private function onLoadLang(key:String):String
		{
			return (key);
		}
		
		public function get inStage() : Boolean
		{
			return _alert && _alert.content.parent;
		}
	}
}