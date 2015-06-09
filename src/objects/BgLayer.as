/**
 * Hanterar alla objekt som hör till bakgrunden.
 * Väggar, objekt.
 */
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
		// Public properties
		//----------------------------------------------------
		public var image1:Image;
		public var image2:Image;

		
		//----------------------------------------------------
		// Private properties
		//----------------------------------------------------
		private var _layer:int;
		private var _parallax:Number;
		
		//----------------------------------------------------
		// Constructor
		//----------------------------------------------------
		private var previousImage:Image;
		private var _level:int = 1;
		public var change:Boolean = false;
		
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
		
		//----------------------------------------------------
		// Private methods
		//----------------------------------------------------
		
		/**
		 * placerar ut objekten som ska finnas på scenen.
		 */
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			
			if (_layer == 1)
			{
				image1 = new Image(Assets.getTexture("BgLayer" + _layer));
				image2 =  new Image(Assets.getTexture("BgLayer" + _layer));
				
			}
			else
			{
				
			}
			
			image1.x = 0;
			image1.y = 0;
			
			image2.y = image1.y + image1.height - 20;
			
			
			this.addChild(image2);
			this.addChild(image1);
			
			
			
			
			
		}
		
		//----------------------------------------------------
		// Public methods
		//----------------------------------------------------
		/**
		 * Returnerar parallax
		 */
		public function get parallax():Number
		{
			return _parallax;
		}
	
		/**
		 * Sätter parallax
		 */
		public function set parallax(value:Number):void
		{
			_parallax = value;
		}
		
		public function changeLevelDesign(level):void{
			
			_level = level;
			change = true;
			
			image2 =  new Image(Assets.getTexture("BgLayer" + _level));
			image2.y = image1.y + image1.height;
			this.addChild(image2);
			
			
			
		}
		
		public function makeChanges():void{
		
			if(_level == 2){
				
				this.removeChild(image1);
				image1 = null
				
				image1 =  new Image(Assets.getTexture("BgLayer" + _level));
				image1.y = 0
				this.addChild(image1);
			}
		}
		
		//----------------------------------------------------
		// Private methods
		//----------------------------------------------------
		
	
		
		
	}
}