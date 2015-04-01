package
{
	import flash.display.Sprite;
	
	import CoreScene.Scene;
	import GameScene.GameStartScene;
	
	[SWF(width=494,height=688,backgroundColor="#00",frameRate=30)]
	public class Tetris extends Sprite
	{	
		
		public function Tetris()
		{
			Game.initilize(this);
			
			var gamePlayingScene:Scene = new GameStartScene();
			Game.getSceneMgr().pushScene(gamePlayingScene);
		}
	}
}