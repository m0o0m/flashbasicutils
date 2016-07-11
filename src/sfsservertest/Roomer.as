package sfsservertest
{
	import com.smartfoxserver.v2.SmartFox;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.requests.CreateRoomRequest;
	import com.smartfoxserver.v2.requests.JoinRoomRequest;
	import com.smartfoxserver.v2.requests.LoginRequest;
	import com.smartfoxserver.v2.requests.RoomSettings;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import fl.controls.Button;

	public class Roomer extends SFSOperator
	{
		
		private var room_btn:Button;
		
		public function Roomer(_sfs:SmartFox,_content:MovieClip)
		{
			super(_sfs,_content);
			sfs.addEventListener(SFSEvent.ROOM_JOIN, onJoin);
			sfs.addEventListener(SFSEvent.ROOM_JOIN_ERROR, onJoinError);
			
			sfs.addEventListener(SFSEvent.ROOM_ADD, onRoomAdded)
			sfs.addEventListener(SFSEvent.ROOM_CREATION_ERROR, onRoomCreationError)
				
			content.loginroom_btn.addEventListener(MouseEvent.CLICK,onloginHandler);
			
			content.createroom_btn.addEventListener(MouseEvent.CLICK,onCreateroomHandler);
			
		}
		
		private function onCreateroomHandler(e:MouseEvent):void
		{
			// Create a new Chat Room
			var settings:RoomSettings = new RoomSettings("Piggy's Chat Room")
			settings.maxUsers = 40
			settings.groupId = "ChatGroup"
			
			sfs.send(new CreateRoomRequest(settings));
		}
		protected function onloginHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			sfs.send( new JoinRoomRequest(content.roomname_txt.text,content.roompwd_txt.text) );
			
			//rooms指定,default 默认分发;
		}
		
		public function onJoin(evt:SFSEvent):void
		{
			dTrace("Joined Room: " + evt.params.room.name);
		}
		
		public function onJoinError(evt:SFSEvent):void
		{
			dTrace("Join failed: " + evt.params.errorMessage);
		}
		 
		
		
		private function onRoomAdded(evt:SFSEvent):void
		{
			    dTrace("A new Room was added: " + evt.params.room )
		}
		 
		private function onRoomCreationError(evt:SFSEvent):void
		{
			    dTrace("An error occurred while attempting to create the Room: " + evt.params.errorMessage)
		}
	}
}