package GameBase
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import Const.GameConst;

	public class GameBoard extends Sprite
	{
		private var _gameboard:Array = new Array
		private var _curTile:Array = null;
		private var _curTileColIndex:int = 0;
		private var _curTileRowIndex:int = 0;
		private var _nextTile:Array = null;
		
		public function GameBoard()
		{
			this._initBoard();
		}
		
		private function _initBoard() : void
		{
			for (var row:int=0; row<Const.GameConst.MAX_ROW; row++)
			{
				_gameboard.push(new Array);
				for (var col:int=0; col<Const.GameConst.MAX_COL; col++);
				{
					_gameboard[row].push(null);
				}
			}
		}
		
		public function clear() : void
		{
			for (var row:int=0; row<Const.GameConst.MAX_ROW; row++)
			{
				for (var col:int=0; col<Const.GameConst.MAX_COL; col++)
				{
					var cell:Cell = this._gameboard[row][col];
					if (cell)
					{
						this.removeChild(cell);
					}
					this._gameboard[row][col] = null;
				}
			}
		}
		
		private function _isCellInBoard(curCellRow:int, curCellCol:int) : Boolean
		{
			if (curCellRow < 0 ||
				curCellCol < 0 || curCellCol >= GameConst.MAX_COL) 
			{
				return false;
			}
			
			return true;	
		}
		
		private function _overlayCheck(offsetRow:int, offsetCol:int) : Boolean
		{
			for (var tileRow:int=3; tileRow>=0; tileRow--)
			{
				for (var tileCol:int=0; tileCol<4; tileCol++)
				{
					var nextCellRow:int = tileRow + this._curTileRowIndex + offsetRow;
					var nextCellCol:int = tileCol + this._curTileColIndex + offsetCol;
					
					var curCell:Cell = this._curTile[tileRow][tileCol];
					if (!curCell)
						continue;
					
					if (!this._isCellInBoard(nextCellRow, nextCellCol)) 
						return true;
					
					if (nextCellRow >= GameConst.MAX_ROW)
						continue;
					
					if (curCell && this._gameboard[nextCellRow][nextCellCol])
						return true;
				}
			}
			
			return false;
		}
		
		public function canGoLeft() : Boolean
		{			
			return !this._overlayCheck(0, -1);
		}
		
		public function canGoRight() : Boolean
		{
			return !this._overlayCheck(0, 1);
		}

		public function canGoDown() : Boolean
		{
			return !this._overlayCheck(-1, 0);
		}
		
		public function goLeft() : void
		{
			this._curTileColIndex -= 1;
			this._reLayoutCell();
		}
		
		public function goRight() : void
		{
			this._curTileColIndex += 1;
			this._reLayoutCell();
		}
		
		public function goDown() : void
		{
			this._curTileRowIndex -= 1;
			this._reLayoutCell();
		}
		
		public function getBoard() : Array
		{
			return this._gameboard;	
		}
		
		public function getCurrentTile() : Array
		{
			return this._curTile;	
		}
		
		public function getCurrentTilePos() : Point
		{
			return new Point(this._curTileRowIndex, this._curTileColIndex);
		}
		
		public function canRote() : Boolean
		{
			this.rote(false);
			var overlayed:Boolean = this._overlayCheck(0, 0);
			this.rote(true);
			
			return !overlayed;	
		}
		
		public function tryRote() : Boolean
		{
			this.rote(false);
			var overlayed:Boolean = this._overlayCheck(0, 0);
			if (overlayed) 
			{
				this.rote(true);
			}
			else 
			{
				this._reLayoutCell();
			}
			
			return !overlayed;
		}
		
		public function rote(roteBack:Boolean) : void 
		{	
			if (!roteBack)
			{
				var newCurrentTile:Array = new Array;
				for (var row:int=0; row<4; row++)
				{
					newCurrentTile.push(new Array);
					for (var col:int=0; col<4; col++)
					{
						newCurrentTile[row].push(this._curTile[4-1-col][row]);
					}
				}
				
				this._curTile = newCurrentTile;
				this._reLayoutCell();
			}
			else
			{
				this.rote(false);
				this.rote(false);
				this.rote(false);
			}
		}
		
		public function _reLayoutCell() : void
		{
			for (var tileRow:int=0; tileRow<4; tileRow++)
			{
				for (var tileCol:int=0; tileCol<4; tileCol++)
				{
					var curCellRow:int = tileRow + this._curTileRowIndex;
					var curCellCol:int = tileCol + this._curTileColIndex;
					
					var curCell:Cell = this._curTile[tileRow][tileCol];
					if (!curCell)
						continue;
					
					curCell.x = curCellCol * Const.GameConst.CELL_WIDTH + Const.GameConst.CELL_START_POS_X;
					curCell.y = (Const.GameConst.MAX_ROW - curCellRow - 1) * Const.GameConst.CELL_HEIGHT + Const.GameConst.CELL_START_POS_Y;
				}
			}
		}
		
		public function makeCurrentTileToBoard() : void
		{
			for (var tileRow:int=0; tileRow<4; tileRow++)
			{
				for (var tileCol:int=0; tileCol<4; tileCol++)
				{
					var curCellRow:int = tileRow + this._curTileRowIndex;
					var curCellCol:int = tileCol + this._curTileColIndex;
					
					if (curCellRow >= Const.GameConst.MAX_ROW)
						continue;
					
					var curCell:Cell = this._curTile[tileRow][tileCol];
					if (!curCell)
						continue;
					
					this._gameboard[curCellRow][curCellCol] = curCell;
				}
			}
		}
		
		public function setCurrentTile(curTiles:Array, row:int, col:int) : void
		{
			this._curTile = curTiles;
			this._curTileColIndex = col;
			this._curTileRowIndex = row;
			for (var tileRow:int=0; tileRow<4; tileRow++)
			{
				for (var tileCol:int=0; tileCol<4; tileCol++)
				{
					var curCell:Cell = this._curTile[tileRow][tileCol];
					if (curCell)
					{
						this.addChild(curCell);
					}
				}
			}
			
			this._reLayoutCell();
		}
		
		private function _isFullRow(row:int) : Boolean
		{
			for (var i:int=0; i<Const.GameConst.MAX_COL; i++)
			{
				if (!this._gameboard[row][i])	
					return false;
			}
			
			return true;
		}
		
		private function _relayoutBoard() : void
		{
			for (var row:int=0; row<GameConst.MAX_ROW; row++)
			{
				for (var col:int=0; col<GameConst.MAX_COL; col++)
				{
					var curCell:Cell = this._gameboard[row][col];
					if (!curCell)
						continue;
					
					curCell.x = col * Const.GameConst.CELL_WIDTH + Const.GameConst.CELL_START_POS_X;
					curCell.y = (Const.GameConst.MAX_ROW - row - 1) * Const.GameConst.CELL_HEIGHT + Const.GameConst.CELL_START_POS_Y;
				}
			}
		}
		
		private function removeRow(removeRow:int) : void
		{
			for (var col:int=0; col<GameConst.MAX_COL; col++)
			{
				var cell:Cell = this._gameboard[removeRow][col];
				if (cell)
					this.removeChild(cell);
				this._gameboard[removeRow][col] = null;
			}
			
			for (var row:int=removeRow+1; row<GameConst.MAX_ROW; row++) 
			{
				for (var col1:int=0; col1<GameConst.MAX_COL; col1++)
				{
					this._gameboard[row-1][col1] = this._gameboard[row][col1]; 
				}
			}
			
			this._relayoutBoard();
		}
		
		public function checkAndRemoveRows() : int
		{
			var rowCount:int = 0;
			for (var i:int=0; i<Const.GameConst.MAX_ROW; i++)
			{
				if (this._isFullRow(i)) 
				{
					this.removeRow(i);
					rowCount += 1;
					i -= 1;
				}
					
			}
			
			return rowCount;
		}
		
		public function isGameOver() : Boolean
		{
			for (var i:int=0; i<Const.GameConst.MAX_COL; i++)
			{
				if (this._gameboard[GameConst.MAX_ROW - 1][i])	
					return true;
			}
			
			return false;
		}
	}
}