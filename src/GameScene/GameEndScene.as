package GameScene
{
	import CoreScene.Scene;
	
	import UI.Button;
	
	import gs.plugins.DropShadowFilterPlugin;
	import gs.plugins.TweenPlugin;
	import flash.events.Event;
	
	public class GameEndScene extends Scene
	{
		private var _retryButton:Button = null;
		
		public function GameEndScene()
		{
			super("gameEndScene");
			
			var startScene:StartGameScene = new StartGameScene;
			this.addChild(startScene);
			this._retryButton = new Button(startScene._startButton);
			this.addChild(_retryButton);
			
			this._retryButton.addEventListener(Button.BUTTON_CLICK_EVENT, _onRetry);
		}
		
		private function _onRetry(e:Event) : void 
		{
			Game.getSceneMgr().popScene();
		}
	}
}