package
{
	import flash.display.Sprite;
	
	import screens.InGame;
	
	import starling.core.Starling;
	
	[SWF(frameRate="60", width="800", height="600", backgroundColor="0x333333")]
	public class jumping extends Sprite
	{
		
		private var myStarling:Starling;
		
		public function jumping()
		{

			
			myStarling = new Starling(Game, stage);
			myStarling.antiAliasing = 1;
			myStarling.start();
		}
	}
}