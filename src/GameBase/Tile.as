package GameBase
{
	import flash.display.Sprite;
	
	import Const.GameConst;
	import Const.TileConst;
	
	public class Tile extends Sprite
	{
		private var _tiles:Array = new Array;
		
		public function Tile(tileType:uint, isShowBackground:Boolean=false)
		{
			super();
			
			if (isShowBackground) 
			{
				_initBackground();
			}
			
			this._initTileCells(tileType);
		}
		
		private function _initBackground() : void
		{
			for (var i:int=0; i<4; i++) 
			{
				for (var j:int=0; j<4; j++)
				{
					var cell:Cell = new Cell(GameConst.BACKGROUND_CELL_ALPHA);
					cell.x = i*Const.GameConst.CELL_WIDTH;
					cell.y = j*Const.GameConst.CELL_HEIGHT;
					this.addChild(cell);	
				}
			}
		}
		
		private function _initTileCells(tileType:uint) : void
		{
			var tileData : Array = Const.TileConst.TILES[tileType];
			
			for (var i:int=0; i<4; i++) 
			{
				this._tiles.push([]);
				for (var j:int=0; j<4; j++)
				{
					var cell:Cell = null;
					if (tileData[i][j])
					{
						cell = new Cell(GameConst.CELL_ALPHA);
						cell.x = j*Const.GameConst.CELL_WIDTH;
						cell.y = (4 - i - 1)*Const.GameConst.CELL_HEIGHT;
						this.addChild(cell);	
					}
					
					this._tiles[i].push(cell);
				}
			}
		}
		
		public function getTileCells() : Array
		{
			return this._tiles;
		}
		
		static public function randomGenTile() : Tile
		{
			var len:int = TileConst.TILES.length;
			
			var type:int = int(Math.random() * len);
			
			return new Tile(type, true);
		}
	}
}