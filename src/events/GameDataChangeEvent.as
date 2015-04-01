package events
{
	import flash.events.Event;
	
	public class GameDataChangeEvent extends Event
	{
		public static const SCORE_CHANGE : String = "GameScoreChangeEvent";
		public static const LEVEL_CHANGE : String = "GameLevelChangeEvent";
		public static const HIGHT_SCORE_CHANGE : String = "GameHightScoreChangeEvent";
		public function GameDataChangeEvent(type:String)
		{
			super(type, bubbles, cancelable);
		}
	}
}