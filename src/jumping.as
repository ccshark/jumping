/**
 * Startar spelet och aktiverar starling ramverket.
 */
package
{
	
	//----------------------------------------------------
	// Imports
	//----------------------------------------------------
	import flash.display.Sprite;
	import screens.InGame;
	import starling.core.Starling;
	
	[SWF(frameRate="60", width="800", height="600", backgroundColor="0x333333")]
	
	//----------------------------------------------------
	// Class Jumping
	//----------------------------------------------------
	public class jumping extends Sprite
	{
		
		//----------------------------------------------------
		// Private properties
		//----------------------------------------------------
		
		/* Parameter för starling klassen. */
		private var myStarling:Starling;
		
		//----------------------------------------------------
		// Constructor
		//----------------------------------------------------
		
		/**
		 * Startar en ny instans av starling och startar
		 * spelet.
		 */
		public function jumping()
		{
			myStarling = new Starling(Game, stage);
			myStarling.antiAliasing = 1;
			myStarling.start();
		}
	}
}