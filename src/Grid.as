package
{
	import flash.display.Sprite;

	public class Grid extends Sprite
	{
		private var _row:uint;
		private var _col:uint;
		
		public var nodes:Array = [];
		public var cells:Array = [];
		public function Grid(row:uint,col:uint)
		{
			_row = row;
			_col = col;
			for (var i:int = 0; i < row; i++) 
			{
				var temp:Array = [];
				var ce:Array = [];
				for (var j:int = 0; j < col; j++) 
				{
					var cell:Cell = new Cell(i,j);
					cell.x = i*50;
					cell.y = j*50;
					addChild(cell);
					temp.push(cell.node);
					ce.push(cell);
				}
				nodes.push(temp);
				cells.push(ce);
			}
			start = new Sprite;
			start.graphics.beginFill(0x0000ff);
			start.graphics.drawRect(20,20,10,10);
			start.graphics.endFill();
			start.x = cell.x + 50;
			start.y = cell.y;
			this.addChild(start);
			
			end = new Sprite;
			end.graphics.beginFill(0xff0000);
			end.graphics.drawCircle(25,25,10);
			end.graphics.endFill();
			end.x = cell.x + 100;
			end.y = cell.y;
			this.addChild(end);
			
		}
		
		public function getCell(node:Node):Cell
		{
			return cells[node.x][node.y];
		}
		
		public function reset():void
		{
			for (var i:int = 0; i < _row; i++) 
			{
				for (var j:int = 0; j < _col; j++) 
				{
					var cell:Cell = cells[i][j];
					cell.reset();
				}
			}
		}
		public function random():void
		{
			for (var i:int = 0; i < _row; i++) 
			{
				for (var j:int = 0; j < _col; j++) 
				{
					var cell:Cell = cells[i][j];
					cell.random();
				}
			}
			
			while(true)
			{
				var ii:uint = Math.random()*_row;
				var jj:uint = Math.random()*_col;
				var cc:Cell = cells[ii][jj];
				if(cc.node.walkable)
				{
					GameConst.start = cc.node;
					start.x = cc.x;
					start.y = cc.y;
					break;
				}
			}
			while(true)
			{
				ii = Math.random()*_row;
				jj = Math.random()*_col;
				cc = cells[ii][jj];
				if(cc.node.walkable)
				{
					GameConst.end = cc.node;
					end.x = cc.x;
					end.y = cc.y;
					break;
				}
			}
		}
		
		public var start:Sprite;
		public var end:Sprite;
	}
}