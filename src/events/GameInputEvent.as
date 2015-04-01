package events
{
	import flash.events.Event;

	public class GameInputEvent extends Event
	{	
		public static const KEY_DOWN:String = "GameInput_KeyDown";
		public static const KEY_UP:String = "GameInput_KeyUp";
		
		private var _keyCode:uint = 0;

		public function GameInputEvent(type:String, keyCode:uint)
		{
			super(type);
			
			this._keyCode = keyCode;
		}
		
		public function keyCode() : uint
		{
			return this._keyCode;
		}
	}
}