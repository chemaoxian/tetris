package GameScene
{
	import CoreScene.Scene;
	
	import GameBase.GamePannel;
	import GameBase.GameController;
	
	public class GamePlayingScene extends Scene
	{
		private var _gameController:GameController;
		
		public function GamePlayingScene()
		{
			super("gamePlayingScene");
			this._gameController = new GameController(this);
		}
		
		override public function onSceneLoadStart() : void
		{
			this._gameController.startGame();
		}
		
		override public function onSceneLoaded() : void
		{
			
		}
		
		override public function onSceneLoadUnloadStart() : void
		{
			
		}
		
		override public function onSceneUnloaded() : void
		{
			this._gameController.stopGame();
		}
	}
}