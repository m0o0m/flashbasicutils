package sfsservertest
{
	import com.smartfoxserver.v2.SmartFox;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.User;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import com.smartfoxserver.v2.entities.variables.RoomVariable;
	import com.smartfoxserver.v2.entities.variables.SFSRoomVariable;
	import com.smartfoxserver.v2.entities.variables.SFSUserVariable;
	import com.smartfoxserver.v2.entities.variables.UserVariable;
	import com.smartfoxserver.v2.requests.ExtensionRequest;
	import com.smartfoxserver.v2.requests.SetRoomVariablesRequest;
	import com.smartfoxserver.v2.requests.SetUserVariablesRequest;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	

	public class VariablesTest extends SFSOperator
	{
		public function VariablesTest(_sfs:SmartFox,_content:MovieClip)
		{
			super(_sfs,_content);
			_content.variabletest_btn.addEventListener(MouseEvent.CLICK,function(e:Event):void{
				userVariableSend();
			});
			_content.roomvariabletest_btn.addEventListener(MouseEvent.CLICK,function(e:Event):void{
				roomVariableSend();
			});
			_content.myvariabletest_btn.addEventListener(MouseEvent.CLICK,function(e:Event):void{
				sendSomeData();
			});
			
			userVariableHandler();
			roomVariableHandler();
			zdyVariableHandler();
		}
		
		private function userVariableSend():void
		{
			var avatarPic:UserVariable = new SFSUserVariable("avt", "MissPiggy.png");
			var occupation:UserVariable = new SFSUserVariable("occ", "Acting and singing");
			var location:UserVariable = new SFSUserVariable("loc", "Muppet's Show");
			
			sfs.send( new SetUserVariablesRequest( [avatarPic, occupation, location] ));
		}
		private function roomVariableSend():void
		{
			var chatRoomTopic:RoomVariable = new SFSRoomVariable("topic", "Multiplayer Game Development");
			chatRoomTopic.isPrivate = true;
			
			sfs.send( new SetRoomVariablesRequest( [chatRoomTopic] ));

		}
		
		
		
		private function userVariableHandler():void
		{
			sfs.addEventListener(SFSEvent.USER_VARIABLES_UPDATE, onUserVarsUpdate);
		}
		
		
		/**
		 * 响应SFSEvent.USER_VARIABLES_UPDATE事件
		 * @param evt
		 * 
		 */
		private function onUserVarsUpdate(evt:SFSEvent):void
		{      
			// The User that changed his variables
			var user:User = evt.params.user as User;
			
			// Do something with these values...
			if(user.getVariable("loc")){
				dTrace("Location: " + user.getVariable("loc").getValue());
			}
			if(user.getVariable("loc")){
				dTrace("Occupation: " + user.getVariable("occ").getValue());
			}
			
			if(user.getVariable("avatar")){
				dTrace("ZoneJionEvent: " + user.getVariable("avatar").getValue());
			}
			// etc...
		}
		//=============================
		private function roomVariableHandler():void
		{
			sfs.addEventListener(SFSEvent.ROOM_VARIABLES_UPDATE, onRoomVarsUpdate);
			
			
		}
		private function zdyVariableHandler():void
		{
			sfs.addEventListener(SFSEvent.EXTENSION_RESPONSE, onExtensionResponse);
			
			
		}
		

		/**
		 *响应SFSEvent.ROOM_VARIABLES_UPDATE事件; 
		 * @param evt
		 * 
		 */
		private function onRoomVarsUpdate(evt:SFSEvent):void
		{
			// An array of variable names that were updated for the Room
			var changedVars:Array = evt.params.changedVars as Array;
			
			// Obtain the variable and show the new value
			var topicRV:RoomVariable = sfs.lastJoinedRoom.getVariable("topic");
			if(topicRV){
				dTrace("The Room topic is now set to: " + topicRV.getValue());
			}
		}

		/**
		 * 
		 * 测试sfsobject类型;
		 */
		public function sendSomeData():void
		{
			var sfso:SFSObject = new SFSObject();
			sfso.putByte("id", 10);
			sfso.putShort("health", 5000);
			sfso.putIntArray("pos", [120,150]);
			sfso.putUtfString("name", "Hurricane"); 
			
			// Send request to Zone level extension on server side
			sfs.send( new ExtensionRequest("testobjData", sfso) );
		}
		/**
		 *响应扩展的消息 
		 * @param evt
		 * 
		 */
		private function onExtensionResponse(evt:SFSEvent):void
		{
			if (evt.params.cmd == "testobjData")
			{
				var responseParams:ISFSObject = evt.params.params as SFSObject;
				dTrace(responseParams.getDump());
				dTrace(responseParams.getHexDump());
				// We expect an int parameter called "sum"
				dTrace("The sum is: " + responseParams.getInt("sum"));
			}
		}

	}
}