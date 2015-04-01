package GameBase
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	
	import events.GameInputEvent;

	public class GameInput extends EventDispatcher
	{
		private var _stage:Stage = null;
		private var _keysState:Vector.<Boolean> = new Vector.<Boolean>;
		
		public function GameInput()
		{
			for (var i:int=0; i<256; i++)
			{
				this._keysState.push(false);
			}
		}
		
		private function _clearKeys() : void
		{
			for (var i:int=0; i<256; i++)
			{
				this._keysState[i] = false;
			}
		}
	
		
		public function listenInput(stage:Stage) : void
		{
			this._stage = stage;
			
			this._stage.addEventListener(KeyboardEvent.KEY_DOWN, this._onKeyDown);
			this._stage.addEventListener(KeyboardEvent.KEY_UP, this._onKeyUp);

			this._clearKeys();
		}
	
		public function unlistenIput() : void
		{
			if (this._stage)
			{
				this._stage.removeEventListener(KeyboardEvent.KEY_DOWN, this._onKeyDown);
				this._stage.removeEventListener(KeyboardEvent.KEY_UP, this._onKeyUp);	
			}
			this._clearKeys();
		}
		
		private function _onKeyDown(e:KeyboardEvent) : void
		{
			this._keysState[e.keyCode] = true;
			this.dispatchEvent(new GameInputEvent(GameInputEvent.KEY_UP, e.keyCode));
		}
		
		private function _onKeyUp(e:KeyboardEvent) : void
		{
			this._keysState[e.keyCode] = false;
			this.dispatchEvent(new GameInputEvent(GameInputEvent.KEY_UP, e.keyCode));
		}
		
		public function isKeyPressed(keyCode:uint) : Boolean
		{
			return this._keysState[keyCode];
		}
	}
}