package screens
{
	
	//--------------------------------------------------------------------------
	// Imports
	//---------------------------------------------------------------------------	
	
	import com.greensock.TweenLite;
	import events.NavigationEvent;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	//--------------------------------------------------------------------------
	// Public class
	//------------------------------------------
	
	public class Welcome extends Sprite
	{
		
		/** Objekt som finns i Meny   */
		private var bg:Image;
		private var title:Image;
		private var hero:Image;
		private var playBtn:Button;
		private var aboutBtn:Button;
		
		//----------------------------------------------------------------------
		// Constructor method
		//----------------------------------------------------------------------
		public function Welcome()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		
		/**
		 * Startas när inGame är utlagd på stage
		 * Startar DrawScreen
		 */
		private function onAddedToStage(event:Event):void
		{
			trace("welcome screen initialized");
			
			drawScreen();
		}
		
		/**
		 *  Skapar de element  som finns i menumode
		 */
		private function drawScreen():void
		{
			bg = new Image(Assets.getTexture("BgWelcome"));
			this.addChild(bg);
			
			title = new Image(Assets.getAtlas().getTexture("welcome_title"));
			title.x = 440;
			title.y = 20;
			this.addChild(title);
			
			hero = new Image(Assets.getAtlas().getTexture("welcome_hero"));
			this.addChild(hero);
			hero.x = -hero.width;
			hero.y = 100;
			
			playBtn = new Button(Assets.getAtlas().getTexture("Bozo_GFX"));
			playBtn.x = 500;
			playBtn.y = 260;
			this.addChild(playBtn);
			
			aboutBtn = new Button(Assets.getAtlas().getTexture("welcome_aboutButton"));
			aboutBtn.x = 410;
			aboutBtn.y = 380;
			this.addChild(aboutBtn);
			
			this.addEventListener(Event.TRIGGERED, onMainMenuClick);
		}
		
		
		/**
		 *  Startas när man trycker på startknappen
		 *  Skapar navigationsvent och skickar med ID play
		 */
		private function onMainMenuClick(event:Event):void
		{
			var buttonClicked:Button = event.target as Button;
			if((buttonClicked as Button) == playBtn)
			{
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "play"}, true));
			}
		}
		
		/**
		 *  Gör menyn osynlig
		 */
		public function disposeTemporarily():void
		{
			this.visible = false;
			
			if (this.hasEventListener(Event.ENTER_FRAME)) this.removeEventListener(Event.ENTER_FRAME, heroAnimation);
		}
		
		
		/**
		 *  Initisierar menyn
		 */
		public function initialize():void
		{
			this.visible = true;
			
			hero.x = -hero.width;
			hero.y = 100;
			
			TweenLite.to(hero, 2, {x: 80});
			
			this.addEventListener(Event.ENTER_FRAME, heroAnimation);
		}
		
		
		/**
		 *  Animationen som sker på gubben i startmenyn
		 */
		private function heroAnimation(event:Event):void
		{
			var currentDate:Date = new Date();
			hero.y = 100 + (Math.cos(currentDate.getTime() * 0.002) * 25);
			playBtn.y = 260 + (Math.cos(currentDate.getTime() * 0.002) * 10);
			aboutBtn.y = 380 + (Math.cos(currentDate.getTime() * 0.002) * 10);
		}
	}
}