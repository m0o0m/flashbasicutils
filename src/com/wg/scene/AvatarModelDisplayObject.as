package com.wg.scene
{
	import com.ClientConstants;
	import com.seaWarScene.avatars.BoatAvatar;
	import com.seaWarScene.avatars.MonsterAvatar;
	import com.seaWarScene.avatars.RoleAvatarBasic;
	import com.seaWarScene.avatars.RoleAvatarModelVO;
	import com.seaWarScene.basics.BasicAnimatedViewElement;
	
	//just for show
	public class AvatarModelDisplayObject extends BasicAnimatedViewElement
	{
		protected var mRoleAvatarModelVO:RoleAvatarModelVO;
		protected var mRoleAvatar:RoleAvatarBasic;
		
		public function AvatarModelDisplayObject()
		{
			super();
		}
		
		override protected function onInitialize():void
		{
			if(mRoleAvatarModelVO)
			{
				createRoleAvatar();
			}
		}
		
		//useless
		public function loadModelAvatar(url:String):void {};
		public function destory():void 
		{
			mRoleAvatarModelVO = null;
			disposeRoleAvatar();
		}
		
		private function disposeRoleAvatar():void
		{
			if(mRoleAvatar)
			{
				mRoleAvatar.dispose();
				removeChild(mRoleAvatar);	
				mRoleAvatar = null;
			}
		}
		
		private function createRoleAvatar():void
		{
			if(mRoleAvatarModelVO.modelType == ClientConstants.AVATAR_ASSEMBLE)
			{
				mRoleAvatar = new BoatAvatar(mRoleAvatarModelVO);
			}
			else if(mRoleAvatarModelVO.modelType == ClientConstants.AVATAR_SINGLE)
			{
				mRoleAvatar = new MonsterAvatar(mRoleAvatarModelVO);
			}

			mRoleAvatar.initialize();
			addChild(mRoleAvatar);
		}
		
		//new 
		public function setAvatarModelVO(value:RoleAvatarModelVO,angleIndex:int=0):void
		{
			if(!initilized) 
			{
				mRoleAvatarModelVO = value;
				return;
			}
			
			if(mRoleAvatarModelVO != value)
			{
				var modelTypeChanged:Boolean = !value || !mRoleAvatarModelVO || (mRoleAvatarModelVO && mRoleAvatarModelVO.modelType != value.modelType);
				
				if(modelTypeChanged)
				{
					disposeRoleAvatar();
				}
				
				mRoleAvatarModelVO = value;
								
				if(modelTypeChanged)
				{
					createRoleAvatar();
				}
				else
				{
					mRoleAvatar.changeAvatarModelByModeVO(mRoleAvatarModelVO);
				}
				
				mRoleAvatar.angleIndex = angleIndex;
			}
		}
		
		public function setSailPartIdAt(partIndex:int, modeId:int):void
		{
			if(!mRoleAvatarModelVO) return;
			
			BoatAvatar(mRoleAvatar).setSailPartIdAt(partIndex, modeId);
		}
		
		public function setArtilleryPartIdAt(partIndex:int, modeId:int):void
		{
			if(!mRoleAvatarModelVO) return;
			
			BoatAvatar(mRoleAvatar).setArtilleryPartIdAt(partIndex, modeId);
		}
		
		override public function onFrame(deltaTime:Number):void
		{
			super.onFrame(deltaTime);
			
			if(mRoleAvatar) mRoleAvatar.onFrame(deltaTime);
			
		}
	}
}