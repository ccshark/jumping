/**
 * Byter till den skärmen som ska visas
 * startas från screen-klasserna.
 */
package events
{
	//----------------------------------------------------
	// Imports
	//----------------------------------------------------
	import starling.events.Event;
	
	//----------------------------------------------------
	// Class NavigationEvent
	//----------------------------------------------------
	public class NavigationEvent extends Event
	{
		
		//----------------------------------------------------
		// Public constants
		//----------------------------------------------------
		public static const CHANGE_SCREEN:String = "changeScreen";
		
		//----------------------------------------------------
		// Public properties
		//----------------------------------------------------
		public var params:Object;
		
		/**
		 * Byter till den nya skärmen som ska visas.
		 */
		public function NavigationEvent(type:String, _params:Object = null, bubbles:Boolean=false)
		{
			super(type, bubbles);
			this.params = _params;
		}
	}
}