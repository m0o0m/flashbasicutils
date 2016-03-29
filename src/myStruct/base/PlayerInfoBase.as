package myStruct.base
{
	import com.wg.serialization.IInputStream;
	import com.wg.serialization.IOutputStream;
	import com.wg.serialization.ISerializable;
	
	import myStruct.logic.CharacterInfo;

	public class PlayerInfoBase  implements ISerializable
	{	
		private var _charInfo:CharacterInfo = null;	
		private var _boatId:uint = 0;	

		public function PlayerInfoBase(initParams:*=null)
		{	

			if (initParams == null) {
				return;
			}

			if (initParams.charInfo !== undefined) this.charInfo = initParams.charInfo;
			if (initParams.boatId !== undefined) this.boatId = initParams.boatId;
		}
		
		public function get charInfo() : CharacterInfo	
		{
			return _charInfo;
		}

		public function set charInfo(charInfo:CharacterInfo) : void
		{
			_charInfo = charInfo;
		}

		public function get boatId() : uint	
		{
			return _boatId;
		}

		public function set boatId(boatId:uint) : void
		{
			_boatId = boatId;
		}

		final public function serialize(outputStream:IOutputStream) : void
		{
				
			outputStream.writeObject(this._charInfo);	
			outputStream.writeUnsignedInt(this._boatId);	
		}

		final public function unserialize(inputStream:IInputStream) : void
		{
				
			this._charInfo = inputStream.readObject(CharacterInfo) as CharacterInfo;	
			this._boatId = inputStream.readUnsignedInt();	
		}
		
		public function toString() : String
		{
			var elems:Array = [];
			elems.push("charInfo" + ":" + this._charInfo);
			elems.push("boatId" + ":" + this._boatId);
			return "PlayerInfoBase{" + elems.join(",") + "}";
		}
	}
}
