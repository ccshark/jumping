package
{
	//----------------------------------------------------
	// Imports
	//----------------------------------------------------
	import events.NavigationEvent;
	import screens.InGame;
	import screens.Welcome;
	import starling.display.Sprite;
	import starling.events.Event;
	
	//----------------------------------------------------
	// Class Game
	//----------------------------------------------------
	public class Game extends Sprite
	{
		//----------------------------------------------------
		// Private methods
		//----------------------------------------------------
		
		/* Parameter för Welcome klassen. */
		private var screenWelcome:Welcome;
		
		/* Parameter för InGame klassen. */
		private var screenInGame:InGame;
		
		//----------------------------------------------------
		// Constructor
		//----------------------------------------------------
		public function Game()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		//----------------------------------------------------
		// Private methods
		//----------------------------------------------------
		
		/**
		 * 
		 */
		
		/**
		* Lägger ut welcome och InGame objekten på scenen.
		* Laddar både screen för att spela samt meny. 
		* Liknande Sessions i Stick OS.
		*/
		private function onAddedToStage(event:Event):void
		{
			trace("starling framework initialized!");
			
			this.addEventListener(events.NavigationEvent.CHANGE_SCREEN, onChangeScreen);
			
			screenInGame = new InGame();
			screenInGame.disposeTemporarily();
			this.addChild(screenInGame);
			
			
			
			screenWelcome = new Welcome();
			this.addChild(screenWelcome);
			screenWelcome.initialize();
		}
		
		/**
		 * Tar bort welcome objektet om navigations eventet 
		 * är play.
		 */
		private function onChangeScreen(event:NavigationEvent):void
		{
			switch (event.params.id)
			{
				case "play":
					screenWelcome.disposeTemporarily();
					screenInGame.initialize();
					break;
			}
		}
	}
}