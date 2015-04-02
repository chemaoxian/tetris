package GameBase
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import Const.GameConst;
	
	import events.GameDataChangeEvent;
	
	public class GamePannel extends Sprite
	{
		private var _nextTF:TextField = null;
		private var _levelTF:TextField = null;
		private var _scoreTF:TextField = null;
		private var _scoreValueTF:TextField = null;
		private var _levelValueTF:TextField = null;
		private var _nextTile:Tile = null;
		
		public function GamePannel()
		{
			super();
			
			this._initBackground();
			this._initTexts();
			
			
			this.addEventListener(Event.REMOVED_FROM_STAGE, function(e:Event):void{
				Game.getGameData().removeEventListener(GameDataChangeEvent.SCORE_CHANGE, _onGameScoreChange);
				Game.getGameData().removeEventListener(GameDataChangeEvent.LEVEL_CHANGE, _onGameLevelChange);
				Game.getGameData().removeEventListener(GameDataChangeEvent.HIGHT_SCORE_CHANGE, _onGameHightScoreChange);
			});
		} 
		
		public function linstenGameData() : void
		{
			Game.getGameData().addEventListener(GameDataChangeEvent.SCORE_CHANGE, _onGameScoreChange);
			Game.getGameData().addEventListener(GameDataChangeEvent.LEVEL_CHANGE, _onGameLevelChange);
			Game.getGameData().addEventListener(GameDataChangeEvent.HIGHT_SCORE_CHANGE, _onGameHightScoreChange);
		}
		
		public function clear() : void
		{
			this._scoreValueTF.text = "0";
			this._levelValueTF.text = "0";
		}
		
		private function _initBackground() : void
		{
			
			//background and border
			this.graphics.beginFill(Const.GameConst.BACKGROUND_COLOR, 1.0);
			this.graphics.lineStyle(4);
			this.graphics.drawRect(2, 2, GameConst.GAME_WINDOW_WIDTH-4, GameConst.GAME_WINDOW_HEIGHT-4);
			this.graphics.moveTo(349,2);
			this.graphics.lineTo(349,GameConst.GAME_WINDOW_HEIGHT-2);
			this.graphics.endFill();
			
			// cell back ground
			for (var row:int=0; row<Const.GameConst.MAX_ROW; row++) {
				var cellVec:Vector.<Cell> = new Vector.<Cell>();
				for (var col:int=0; col<Const.GameConst.MAX_COL; col++) {
					var cell:Cell = new Cell(Const.GameConst.BACKGROUND_CELL_ALPHA);
					cell.x = col * Const.GameConst.CELL_WIDTH + Const.GameConst.CELL_START_POS_X;
					cell.y = (Const.GameConst.MAX_ROW - row - 1) * Const.GameConst.CELL_WIDTH + Const.GameConst.CELL_START_POS_X;
					this.addChild(cell);
				}
			}
		}
		
		private function _onGameScoreChange(e:GameDataChangeEvent) : void
		{
			if (this._scoreValueTF)
			{
				this._scoreValueTF.text = String(Game.getGameData().getScore());
			}
		}
		
		private function _onGameLevelChange(e:GameDataChangeEvent) : void
		{
			if (this._levelValueTF)
			{
				this._levelValueTF.text = String(Game.getGameData().getLevel());
			}
		}
		
		private function _onGameHightScoreChange(e:GameDataChangeEvent) : void
		{
			
		}
		
		private function _initTexts() : void
		{
			this._nextTF = this._createTextField(GameConst.NEXT_TEXT_POS.x, GameConst.NEXT_TEXT_POS.y);
			this._nextTF.text = "next";
			this.addChild(this._nextTF);
			
			this._scoreTF = this._createTextField(GameConst.SCORE_TEXT_POS.x, GameConst.SCORE_TEXT_POS.y);
			this._scoreTF.text = "score";
			this.addChild(this._scoreTF);
			
			this._scoreValueTF = this._createTextField(GameConst.SCORE_VALUE_POS.x, GameConst.SCORE_VALUE_POS.y);
			this._scoreValueTF.text = String(Game.getGameData().getScore());
			this.addChild(this._scoreValueTF);
			
			this._levelTF = this._createTextField(GameConst.LEVEL_TEXT_POS.x, GameConst.LEVEL_TEXT_POS.y);
			this._levelTF.text = "level";
			this.addChild(this._levelTF);
			
			this._levelValueTF = this._createTextField(GameConst.LEVEL_VALUE_POS.x, GameConst.LEVEL_VALUE_POS.y);
			this._levelValueTF.text = String(Game.getGameData().getLevel());
			this.addChild(this._levelValueTF);
		}
		
		private function _createTextField(x:uint, y:uint) : TextField
		{
			var format:TextFormat = new TextFormat();
			format.font = "Verdana";
			format.size = 12;
			format.bold = true;
			
			var textField:TextField = new TextField;
			textField.x = x;
			textField.y = y;
			textField.type = TextFieldType.DYNAMIC;
			textField.selectable = false;
			textField.defaultTextFormat = format;
			
			return textField;
		}
		
		public function genNextTile() : void
		{
			if (this._nextTile)
				this.removeChild(this._nextTile);
			
			this._nextTile = Tile.randomGenTile();
			this._nextTile.x = GameConst.NEXT_TILE_POS_X;
			this._nextTile.y = GameConst.NEXT_TILE_POS_Y;
			
			this.addChild(this._nextTile);
		}
		
		public function getNextTile() : Tile
		{
			return this._nextTile;	
		}
		
		public function getTileCells() : Array
		{
			return this._nextTile.getTileCells();
		}
	}
}