package GameBase
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	import Const.GameConst;

	public class Cell extends Bitmap
	{
		private static var _bitmapData :BitmapData = null;
		
		public function Cell(alpha:Number=GameConst.CELL_ALPHA)
		{
			super(getBitmapData());
			
			this.alpha = alpha;
			this.x = x;
			this.y = y;
		}
		
		public static function getBitmapData() : BitmapData
		{
			if (!_bitmapData) {
				_bitmapData = new BitmapData(Const.GameConst.CELL_WIDTH,Const.GameConst.CELL_WIDTH, true, 0x00000000);
				_bitmapData.fillRect(new Rectangle(1,1,32, 32), 0xFF000000);
				_bitmapData.fillRect(new Rectangle(6, 6, 22, 22), 0x000000);
				_bitmapData.fillRect(new Rectangle(10, 10, 14, 14), 0xFF000000);
			}
			
			return _bitmapData;
		}

	}
}