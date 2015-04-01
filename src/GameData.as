package
{
	import flash.events.EventDispatcher;
	
	import Const.LevelConst;
	
	import events.GameDataChangeEvent;

	public class GameData extends EventDispatcher
	{
		private var _level : uint = 0;
		private var _score : uint = 0;
		private var _highScore : uint = 0;
		
		public function GameData()
		{
		}
		
		public function clear() : void
		{
			this._score = 0;
			this._level = 0;
		}
		
		public function setLevel(level:uint) : void
		{
			if (this._level != level)
			{
				this._level = level;	
				this.dispatchEvent(new GameDataChangeEvent(GameDataChangeEvent.LEVEL_CHANGE));
			}
		}
		
		public function getLevel() : uint
		{
			return this._level;	
		}
		
		public function getLevelUpScore() : uint
		{
			return Const.LevelConst.LEVEL_UP_SCORE[this._level];
		}
		
		public function getLevelDropTime() : int
		{
			return Const.LevelConst.LEVEL_DROP_SPEED[this._level];
		}
		
		public function setScore(score:uint) : void
		{
			if (score != this._score) 
			{
				this._score = score;
				this.dispatchEvent(new GameDataChangeEvent(GameDataChangeEvent.SCORE_CHANGE));
				
				if (this._score > this._highScore) 
				{
					this._highScore = this._score;
					this.dispatchEvent(new GameDataChangeEvent(GameDataChangeEvent.HIGHT_SCORE_CHANGE));
				}
				
				if (this._score >= this.getLevelUpScore())
					this.setLevel(this.getLevel()+1);
			}
		}
		
		public function getScore() : uint
		{
			return this._score;	
		}
		
		public function addScoreByRemoeRows(rowCnt:int) : void
		{
			var addScore:int = Const.LevelConst.REMOVE_ROW_SCORE[rowCnt];
			this.setScore(this.getScore() + addScore);
		}
	}
}