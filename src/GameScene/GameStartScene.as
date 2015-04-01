package GameScene
{
	import flash.events.Event;
	import gs.*;
	import gs.plugins.*;
	import CoreScene.Scene;
	
	import UI.Button;

	public class GameStartScene extends Scene
	{
		private var _startButton:Button = null;
		
		public function GameStartScene()
		{
			super("startScene");
			
			var startScene:StartGameScene = new StartGameScene;
			this.addChild(startScene);
			this._startButton = new Button(startScene._startButton);
			this.addChild(_startButton);
			
			this._startButton.addEventListener(Button.BUTTON_CLICK_EVENT, _onStartClick);
		}
		
		private function _onStartClick(e:Event) : void 
		{
			Game.getSceneMgr().pushScene(new GamePlayingScene);
		}
	}
}