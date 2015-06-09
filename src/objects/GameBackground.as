package objects
{
	
	//--------------------------------------------------------------------------
	// Imports
	//---------------------------------------------------------------------------	
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	//--------------------------------------------------------------------------
	// Public class
	//------------------------------------------
	
	public class GameBackground extends Sprite
	{
		
		/** Lagrena */
		public var bgLayer1:BgLayer;
		public var bgLayer2:BgLayer;
		private var bgLayer3:BgLayer;
		private var bgLayer4:BgLayer;
		
		private var _speed:Number = 0;
		
		private var levelArray:Array = new Array();
		
		
		
		//----------------------------------------------------------------------
		// Constructor method
		//----------------------------------------------------------------------
		
		
		public function GameBackground()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		
		
		/**
		 * Startas när gameBackground  är utlagd på stage
		 * Startar en Enter_frame
		 */
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			bgLayer1 = new BgLayer(1);
			bgLayer1.parallax = 0.8;
			this.addChild(bgLayer1);
			
			/*bgLayer2 = new BgLayer(2);
			bgLayer2.parallax = 0.2;
			this.addChild(bgLayer2); */
			
			/*bgLayer3 = new BgLayer(3);
			bgLayer3.parallax = 0.5;
			this.addChild(bgLayer3);
			
			bgLayer4 = new BgLayer(4);
			bgLayer4.parallax = 1;
			this.addChild(bgLayer4); */
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		
		/**
		 *  Rendering av banan
		 */
		private function onEnterFrame(event:Event):void
		{
			bgLayer1.y -= Math.ceil(_speed * bgLayer1.parallax);
			if (bgLayer1.y < -stage.stageHeight *2) {
				bgLayer1.y = 0;
				if(bgLayer1.change == true){
					bgLayer1.change = false;
					bgLayer1.makeChanges();
				}
			}
			
			/* bgLayer2.y -= Math.ceil(_speed * bgLayer2.parallax);
			if (bgLayer2.y < -stage.stageHeight) bgLayer2.y = 0; */
			

			/* bgLayer3.y -= Math.ceil(_speed * bgLayer3.parallax);
			if (bgLayer3.y < -stage.stageHeight) bgLayer3.y = 0;
			
			bgLayer4.y -= Math.ceil(_speed * bgLayer4.parallax);
			if (bgLayer4.y < -stage.stageHeight) bgLayer4.y = 0; */
		}
		
		
		
		
		
		/**
		 * Hämtas ifrån inGame klassen
		 */
		public function get speed():Number
		{
			return _speed;
		}

		/**
		 * Förändras ifrån inGame klassen.
		 */
		public function set speed(value:Number):void
		{
			_speed = value;
		}
		
		/**
		 *  Startar metoderna i lagrena som ska ändra leveldesigen, skickar med levelnummer
		 */
		public function  level(value:int):void{
	
			bgLayer1.changeLevelDesign(value);
			//bgLayer2.changeLevelDesign(value);
		 
		}

	}
}