package objects
{
	
	//--------------------------------------------------------------------------
	// Imports
	//---------------------------------------------------------------------------	
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import flash.geom.Point;
	
	
	//--------------------------------------------------------------------------
	// Public class
	//------------------------------------------
	
	public class Hero extends Sprite
	{
		private var heroArt:MovieClip;
		
		public var hitPointAxe:Point = new Point(0,0);
		
		//----------------------------------------------------------------------
		// Constructor method
		//----------------------------------------------------------------------
		
		public function Hero()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		
		/**
		 * Startas när hero är utlagd på stage
		 */
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			createHeroArt();
			createHeroHitPoints();
		}
		
		
		/**
		 *  Skapar hitPoints för objektet
		 */
		private function createHeroHitPoints():void
		{
			
		
		}
		
		
		
		/**
		 *  Lägger dit heroSkin
		 */
		private function createHeroArt():void
		{
			heroArt = new MovieClip(Assets.getAtlas().getTextures("Bozo_GFX instance 10000"), 1);
			heroArt.x = Math.ceil(-heroArt.width/2);
			heroArt.y = Math.ceil(-heroArt.height/2);
			starling.core.Starling.juggler.add(heroArt);
			this.addChild(heroArt);
		}
	}
}