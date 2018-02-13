package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Cell extends Sprite
	{
		public var node:Node;
		
		private var _color:uint;
		private var _type:uint;
		public function Cell(i:int,j:int)
		{
			super();
			node = new Node(i,j);
			
			this.addEventListener(MouseEvent.CLICK,onClick);
			onClick(null);
		}
		
		public function reset():void
		{
			this.color = 0x00ff00;
			this.node.walkable = true;
		}
		public function random():void
		{
			if(Math.random()<0.8)
			{
				reset();
			}else
			{
				this.color = 0;
				this.node.walkable = false;
			}
		}
		
		protected function onClick(event:MouseEvent):void
		{
			if(GameConst.type<0)return;
			_type = GameConst.type;
			switch(GameConst.type)
			{
				case 0:
				{
					reset();
					break;
				}
				case 1:
				{
					this.color = 0;
					this.node.walkable = false;
					break;
				}
				case 2:
				{
					GameConst.start = this.node;
					this.parent["start"].x = this.x;
					this.parent["start"].y = this.y;
					break;
				}
				case 3:
				{
					GameConst.end = this.node;
					this.parent["end"].x = this.x;
					this.parent["end"].y = this.y;
					break;
				}
					
				default:
				{
					break;
				}
			}
		}		
		
		public function get color():uint
		{
			return _color;
		}

		public function set color(value:uint):void
		{
			_color = value;
			graphics.clear();
			graphics.beginFill(value);
			graphics.lineStyle(2,0x666666);
			graphics.drawRect(0,0,50,50);
			graphics.endFill();
		}

	}
}