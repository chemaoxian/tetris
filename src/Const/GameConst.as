package Const
{
	import flash.geom.Point;

	public class GameConst
	{
		public static const GAME_WINDOW_WIDTH:uint = 494;
		public static const GAME_WINDOW_HEIGHT:uint = 688;
		public static const GAME_FPS : uint = 30;
		
		public static const BACKGROUND_COLOR:uint = 0x6A7C6A;
		public static const BACKGROUND_CELL_ALPHA:Number = 0.15;
		
		// max row and col
		public static const MAX_ROW : uint = 20;
		public static const MAX_COL : uint = 10;
		
		// cell const
		public static const CELL_WIDTH : uint = 34;
		public static const CELL_HEIGHT : uint = 34;
		public static const CELL_START_POS_X : uint = 6;
		public static const CELL_START_POS_Y : uint = 6;
		public static const NEXT_TILE_POS_X:uint = 352;
		public static const NEXT_TILE_POS_Y:uint = 40;
		
		public static const CELL_ALPHA:Number = 0.6;
		// text pos
		public static const NEXT_TEXT_POS:Point = new Point(354, 20);
		public static const SCORE_TEXT_POS:Point = new Point(354, 190);
		public static const SCORE_VALUE_POS:Point = new Point(360, 210);
		public static const LEVEL_TEXT_POS:Point = new Point(354, 250);
		public static const LEVEL_VALUE_POS:Point = new Point(360, 270);
		
		public function GameConst()
		{
		}
	}
}