package GameScene
{
	import flash.events.Event;
	
	import CoreScene.Scene;
	
	import UI.Button;
	
	public class GameEndScene extends Scene
	{
		private var _retryButton:Button = null;
		
		public function GameEndScene()
		{
			super("gameEndScene");
			
			var endGameScene:EndGameScene = new EndGameScene;
			this.addChild(endGameScene);
			this._retryButton = new Button(endGameScene._tryTryButton);
			this.addChild(_retryButton);
		
			endGameScene._gameScore.text = String(Game.getGameData().getScore());
			endGameScene._hightScore.text = String(Game.getGameData().getHighScore());
			this._retryButton.addEventListener(Button.BUTTON_CLICK_EVENT, _onRetry);
		}
		
		private function _onRetry(e:Event) : void 
		{
			Game.getSceneMgr().popScene();
			this._retryButton.removeEventListener(Button.BUTTON_CLICK_EVENT, _onRetry);
		}
	}
}