package
{
	import flash.geom.Point;

	public class AStar
	{
		private static const _straightCost:Number = 1;
		private static const _diagCost:Number = 1.4;
		private static var POINTS:Array = [new Point(-1,-1),new Point(-1,0),new Point(-1,1),
			new Point(0,-1),new Point(0,1),
		new Point(1,-1),new Point(1,0),new Point(1,1)];
		public function AStar()
		{
		}
		//曼哈顿估价法
		public static function manhattan(node:Node,_endNode:Node):Number
		{
			return Math.abs(node.x - _endNode.x) * _straightCost + Math.abs(node.y - _endNode.y) * _straightCost;
		}
		
		//几何估价法
		public static function euclidian(node:Node,_endNode:Node):Number
		{
			var dx:Number=node.x - _endNode.x;
			var dy:Number=node.y - _endNode.y;
			return Math.sqrt(dx * dx + dy * dy) * _straightCost;
		}
		
		//对角线估价法
		public static function diagonal(node:Node,_endNode:Node):Number
		{
			var dx:Number=Math.abs(node.x - _endNode.x);
			var dy:Number=Math.abs(node.y - _endNode.y);
			var diag:Number=Math.min(dx, dy);
			var straight:Number=dx + dy;
			return _diagCost * diag + _straightCost * (straight - 2 * diag);
		}
		
		public static function search(nodes:Array,startNode:Node,endNode:Node):Array
		{
			var pathArray:Array=[];
			_openList = [];
			_closeList = [startNode];
			_row = nodes.length;
			_col = (nodes[0] as Array).length;
			while(true)
			{
				pathArray.push(startNode);
				if(startNode.x == endNode.x && startNode.y == endNode.y)break;
				var arround:Array = getAround(nodes,startNode);
				print(arround,"around:");
				_openList = _openList.concat(arround);
				if(_openList.length == 0)
				{
					trace("无路可走");
					break;
				}
				_openList = calcF(_openList);
				_openList.sortOn("f",Array.NUMERIC);
				print(_openList,"open:");
				var node:Node = _openList.shift();
				node.parent = startNode;
				_closeList.push(node);
				print(_closeList,"_closeList:");
				startNode = node;
			}
			var lastNode:Node = pathArray[pathArray.length-1];
			var path:Array = [];
			if(lastNode == GameConst.end)
			{
				while(lastNode != GameConst.start)
				{
					path.push(lastNode);
					lastNode = lastNode.parent;
				}
			}
			
			return path;
		}
		
		private static var _col:uint;
		private static var _row:uint;
		private static var _openList:Array;
		private static var _closeList:Array;
		private static function getAround(nodes:Array,startNode:Node):Array
		{
			var temp:Array = [];
			for each (var pt:Point in POINTS) 
			{
				var xx:int = startNode.x+pt.x;
				var yy:int = startNode.y+pt.y;
				if(xx<0 || xx>=_row || yy<0 || yy>=_col)continue;
				var node:Node = nodes[xx][yy];
				if(node.walkable == false)continue;
				if((nodes[node.x][startNode.y] as Node).walkable==false && (nodes[startNode.x][node.y] as Node).walkable==false)
				{
					continue;
				}
				if(checkInList(node))continue;
				temp.push(node);
			}
			return temp;
		}
		
		private static function checkInList(node:Node):Boolean
		{
			for (var i:int = 0; i < _openList.length; i++) 
			{
				var temp:Node = _openList[i];
				if(temp.x == node.x && temp.y == node.y)return true
			}
			for (i = 0; i < _closeList.length; i++) 
			{
				temp = _closeList[i];
				if(temp.x == node.x && temp.y == node.y)return true
			}
			return false;
		}
		private static function calcF(nodes:Array):Array
		{
			for (var i:int = 0; i < nodes.length; i++) 
			{
				var temp:Node = nodes[i];
				temp.f = euclidian(temp,GameConst.end);
			}
			return nodes;
		}
		
		private static function print(nodes:Array,str:String=""):void
		{
			for (var i:int = 0; i < nodes.length; i++) 
			{
				var temp:Node = nodes[i];
				str += temp.x+","+temp.y+";";
			}
			trace(str);
		}
	}
}