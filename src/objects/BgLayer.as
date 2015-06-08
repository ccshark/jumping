package objects
{
	//----------------------------------------------------
	// Imports
	//----------------------------------------------------
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	//----------------------------------------------------
	// Class BgLayer
	//----------------------------------------------------
	public class BgLayer extends Sprite
	{
		
		//----------------------------------------------------
		// Private properties
		//----------------------------------------------------
		private var image1:Image;
		private var image2:Image;
		
		private var _layer:int;
		private var _parallax:Number;
		
		//----------------------------------------------------
		// Constructor
		//----------------------------------------------------
		
		/**
		 * Initierar klassen och tar emot vilket lager som ska placeras.
		 * ger klassen tillgång till stagen.
		 */
		public function BgLayer(layer:int)
		{
			super();
			this._layer = layer;
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
<<<<<<< HEAD
		//----------------------------------------------------
		// Private methods
		//----------------------------------------------------
=======
		
		
		
>>>>>>> origin/master
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			
			if (_layer == 1)
			{
				image1 = new Image(Assets.getTexture("BgLayer" + _layer));
				image2 = new Image(Assets.getTexture("BgLayer" + _layer));
			}
			else
			{
				image1 = new Image(Assets.getAtlas().getTexture("Symbol 1 instance 10000"));
				image2 = new Image(Assets.getAtlas().getTexture("Symbol 1 instance 10000"));
			}
			
			image1.x = 0;
			image1.y = stage.stageHeight - image1.height;
			image1.scaleY = 2; //temp
			
			image2.x = stage.stageWidth - image2.width;
			image2.y = image1.y;
			image2.scaleY = 2; //temp
			
			this.addChild(image1);
			this.addChild(image2);
		}
		
		//----------------------------------------------------
		// Public methods
		//----------------------------------------------------
		public function get parallax():Number
		{
			return _parallax;
		}

		public function set parallax(value:Number):void
		{
			_parallax = value;
		}
	}
}