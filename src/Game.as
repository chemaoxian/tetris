package 
{
	import CoreScene.SceneMgr;

	public class Game
	{
		static private var _sceneMgr : SceneMgr = null;
		static private var _gameData: GameData = new GameData;
	
		static public function initilize(rootObj) : void
		{
			_sceneMgr = new SceneMgr(rootObj);
		}
		
		static public function uninitlize() : void
		{
			_sceneMgr.clear();
			_sceneMgr = null;
		}
		
		static public function getSceneMgr() : SceneMgr
		{
			return _sceneMgr;	
		}
		
		static public function getGameData() : GameData
		{
			return _gameData;
		}
	}
}