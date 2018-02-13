package
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	
	[SWF(backgroundColor=0xffffff,width=1000,height=600)]
	public class Main extends Sprite
	{
		private var grid:Grid;
		private var _timer:TextField;
		public function Main()
		{
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			
			grid = new Grid(20,11);
			grid.y = 30;
			addChild(grid);
			
			creatLable('不可通过',notPass,0,0,this);
			creatLable('可通过',function(e:MouseEvent):void{GameConst.type = 0},60,0,this);
			creatLable('起点',function(e:MouseEvent):void{GameConst.type = 2},120,0,this);
			creatLable('终点',function(e:MouseEvent):void{GameConst.type = 3},180,0,this);
			creatLable('开始寻路',clickSearsh,240,0,this);
			creatLable('重置',clickReset,300,0,this);
			creatLable('随机',clickRandom,360,0,this);
			_timer = creatLable('耗时：',clickRandom,900,0,this);
			_timer.width = 80;
		}
		
		private function clickRandom(e:MouseEvent):void
		{
			grid.random();
		}
		private function clickReset(e:MouseEvent):void
		{
			grid.reset();
		}
		
		private function notPass(e:MouseEvent):void
		{
			GameConst.type = 1;
		}
		
		private function clickSearsh(e:MouseEvent):void
		{
			if(!GameConst.start || !GameConst.end)return;
			GameConst.type = -1;
			var t:uint = getTimer();
			var nodes:Array = AStar.search(grid.nodes,GameConst.start,GameConst.end);
			_timer.text = "耗时："+(getTimer()-t)+"ms";
			for each (var i:Node in nodes) 
			{
				trace(i.x,i.y);
				var cell:Cell = grid.getCell(i);
				cell.color = 0xffff00;
			}
			
		}
		
		private function creatLable(label:String,onClick:Function,xx:Number,yy:Number,container:DisplayObjectContainer):TextField
		{
			var lb:TextField = new TextField;
			lb.width = 60;
			lb.height = 20;
			lb.selectable = false;
			lb.type = TextFieldType.DYNAMIC;
			lb.text = label;
			lb.x = xx;lb.y = yy;
			var tf:TextFormat = new TextFormat;
			container.addChild(lb);
			lb.addEventListener(MouseEvent.CLICK,onClick);
			return lb;
		}
	}
}