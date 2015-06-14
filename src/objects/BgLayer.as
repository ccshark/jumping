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
		public var image3:Image;

		public var imageArray:Array = [];
		
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
		public var changeAll:Boolean = false;
		public var change2:Boolean = false;
		public var clear:Boolean = false;
		
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
				image3 =  new Image(Assets.getTexture("BgLayer" + _layer));
				
				imageArray.push(image1, image2, image3);;
				
			}
			
			image1.x = 0;
			image1.y = 0;
			
			image2.y = image1.y + image1.height;
			image3.y = image2.y + image1.height;
			
			this.addChild(image1);
			this.addChild(image2);
			this.addChild(image3);
			
			
			
			
			
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
		
		
		/** 
		 *  När spelaren nått en ny level startas denna funktion, tilldelad level i parameter
		 *  Change säger att en ny bakgrund ska laddas.
		 */
		public function changeLevelDesign(level):void{
			
			_level = level;
			change = true;
				
		}
		
		

	
		
		/**
		 *  Funktion som sköter cheken vilken bild som ska ligga var i Arrayen.
		 */
		public function movement():void
		{
			
			
				
				if(imageArray[0].y < -imageArray[0].height){
					
					if(change2 == true) newLevel();
					if(change == true) transformation();
					
					
					imageArray[3] = imageArray[0]
					imageArray[0] = imageArray[1];
					imageArray[1] = imageArray[2];
					imageArray[2] = imageArray[3]; 
					
					imageArray[1].y = imageArray[0].y + imageArray[0].height;
					imageArray[2].y = imageArray[1].y + imageArray[1].height;
				}
				
			
		}

		//----------------------------------------------------
		// Private methods
		//----------------------------------------------------
		
		
		/**
		 *  Byter ut transormationbilden till level bakgrund
		 */
		private function newLevel():void
		{
			this.removeChild(imageArray[0]);
			imageArray[0] = new Image(Assets.getTexture("BgLayer" + _level));
			this.addChild(imageArray[0]);
			
			change2 = false;
		}
		
		/**
		 * Sätter nya transormationbilden samt nya level bakrgunden
		 */
		private function transformation():void
		{
			this.removeChild(imageArray[0]);
			imageArray[0] = new Image(Assets.getTexture("BgLayer" + _level));
			
			this.removeChild(imageArray[2]);
			imageArray[2] = new Image(Assets.getTexture("BgLayer" + _level));
			
			this.addChild(imageArray[0]);
			this.addChild(imageArray[2]);
			change = false;
			change2 = true;
			
		}
	}
}