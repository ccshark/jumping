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
		public var block:Image;
		
		public var iceblocks:Vector.<Image> = new Vector.<Image>;
		
		//----------------------------------------------------
		// Private properties
		//----------------------------------------------------
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
				image2 = new Image(Assets.getTexture("BgLayer" + _layer));
			}
			else
			{
				image1 = new Image(Assets.getAtlas().getTexture("icewall"));
				image2 = new Image(Assets.getAtlas().getTexture("icewall"));
				block = new Image(Assets.getAtlas().getTexture("iceblock"));
				
				block.x = 400;
				block.y = 500;
				block.scaleY = 1; //temp
				
				this.addChild(block);
				
				iceblocks.push(block);
				
				
			}
			
			image1.x = -20;
			image1.y = stage.stageHeight - image1.height - 300;
			image1.scaleY = 4; //temp
			
			image2.x = stage.stageWidth - image2.width + 30;
			image2.y = image1.y;
			image2.scaleY = 4; //temp

			
			this.addChild(image1);
			this.addChild(image2);
			
			iceblocks.push(image1);
			iceblocks.push(image2);
			
			
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
		
		//----------------------------------------------------
		// Private methods
		//----------------------------------------------------
		
		private function setIceblock():void {
			block = new Image(Assets.getTexture("BgLayer" + _layer));
		}
		
		private function createIceblocks():void {
			
			block.scaleX = 1;
			block.scaleY = 2;
			
			block.x = 500;
			block.y = stage.stageHeight;
			
			this.addChild(block);
			
			iceblocks.push(block);
			
		}
	}
}