package GameBase
{
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	
	import CoreScene.Scene;
	
	import GameScene.GameEndScene;
	
	import events.GameInputEvent;

	public class GameController
	{
		private var _gamePannel:GamePannel = null;
		private var _gameBoard:GameBoard = null;
		private var _gameInput:GameInput = null;
		private var _preTime:int = 0;
		private var _nextTile:Tile = null;
		private var _scene:Scene = null;

		public function GameController(scene:Scene)
		{
			this._gameBoard = new GameBoard();
			this._gameInput = new GameInput();
			this._gamePannel = new GamePannel();
			this._scene = scene;
			
			this._scene.addChild(this._gamePannel);
			this._scene.addChild(this._gameBoard);
		}
		
		public function getGameboard() : GameBoard
		{
			return this._gameBoard;
		}
		
		public function startGame() : void
		{
			stopGame();
			
			this._gameInput.listenInput(this._scene.stage);
			this._gamePannel.linstenGameData();
			
			this._gameInput.addEventListener(GameInputEvent.KEY_UP, _onKeyUp);
			this._scene.addEventListener(Event.ENTER_FRAME, this._onEnterFrame);
			
			this._preTime = flash.utils.getTimer();
			
			Game.getGameData().clear();
			this._gameBoard.clear();
			this._gamePannel.clear();
			this._gamePannel.genNextTile();
			this._gameBoard.setCurrentTile(this._gamePannel.getTileCells(), 20, 5);
			this._gamePannel.genNextTile();
		}
		
		public function stopGame() : void
		{
			this._gameInput.unlistenIput();
			
			this._scene.removeEventListener(Event.ENTER_FRAME, this._onEnterFrame);
			this._gameInput.removeEventListener(GameInputEvent.KEY_UP, _onKeyUp);
		}
		

		private function _onKeyUp(e:GameInputEvent) : void
		{
			this._handleKeyboardTimeUp();
		}
		
		private function _handleKeyboardTimeUp() : void
		{
			if (this._gameInput.isKeyPressed(Keyboard.UP))
			{
				if (this._gameBoard.canRote())
					this._gameBoard.rote(false);
			}
			else if (this._gameInput.isKeyPressed(Keyboard.DOWN))
			{
				if (this._gameBoard.canGoDown())
					this._gameBoard.goDown();
			} 
			else if (this._gameInput.isKeyPressed(Keyboard.LEFT))
			{
				if (this._gameBoard.canGoLeft())
					this._gameBoard.goLeft();
			}
			else if (this._gameInput.isKeyPressed(Keyboard.RIGHT))
			{
				if (this._gameBoard.canGoRight())
					this._gameBoard.goRight();
			}
		}
		
		private function _checkWinAndGenNextTile() : void
		{
			this._gameBoard.makeCurrentTileToBoard();
			var removeRows:int = this._gameBoard.checkAndRemoveRows();
			Game.getGameData().addScoreByRemoeRows(removeRows);
			
			if (!this._gameBoard.isGameOver()) 
			{
				this._gameBoard.setCurrentTile(this._gamePannel.getTileCells(), 20, 5);
				this._gamePannel.genNextTile();
			} 
			else
			{
				Game.getSceneMgr().pushScene(new GameEndScene);	
			}
		}
		
		private function _handleDrapTimeUp() : void
		{
			if (this._gameBoard.canGoDown())
			{
				this._gameBoard.goDown();
			} 
			else
			{
				this._checkWinAndGenNextTile();
			}
		}
		
		private function _onEnterFrame(e:Event) : void
		{
			var currentTime:int = flash.utils.getTimer();
			
			var detaTime:int = currentTime - this._preTime;
			var currentSpeedTime:int = Game.getGameData().getLevelDropTime();
			if ( detaTime >= currentSpeedTime)
			{
				this._handleDrapTimeUp();
				this._preTime = currentTime;
			}
		}
	}
}