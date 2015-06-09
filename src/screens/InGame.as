/**
 *  En Klass som används som en session för när man startat spelet
 *  
 */

package screens
{
	//--------------------------------------------------------------------------
	// Imports
	//--------------------------------------------------------------------------
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	
	import objects.GameBackground;
	import objects.Hero;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	import starling.utils.deg2rad;
	
	//--------------------------------------------------------------------------
	// Public class
	//------------------------------------------
	
	public class InGame extends Sprite
	{
		
		
		/**  Objekt i gamemode */ 
		private var startButton:Button;
		private var bg:GameBackground;
		private var hero:Hero;
		private var scoreText:TextField;
		
		/** Tid egenskaper */
		private var timePrevious:Number; 
		private var timeCurrent:Number;
		private var elapsed:Number;
		
		/** I vilket läge hero:en befinner sig , idle eller flying.*/
		private var gameState:String; 
		
		/** spelarens hastighet */
		private var playerSpeed:Number; 
		private const MIN_SPEED:Number = 650;
		
		/** Snabbhet i X-led vid hopp */
		private var speedX:int = 13;
		private var speedY:int = 2;
		
		/** Distansen */
		private var scoreDistance:int;
		
		/** Om spelaren träffar något hinder */
		private var hitObstacle:int;
	
		/** Arean för spelet */
		private var gameArea:Rectangle;
		
		/** För att känna av touch */
		private var touch:Touch;
		
		/** Spelarens Y och X  position */
		private var touchX:Number = 300; 
		private var touchY:Number = 300; 
		
		
		/** om spelaren är i luften, används för att spelaren inte ska kunna hoppa, ändra riktning när den är i luften. */
		private var inAir:Boolean = false; 
		
		/** Boolean om spelaren ska hoppa*/
		private var jump:Boolean = true; 
			
		/** åt vilket håll spelaren ska röra sig, false = höger, true = vänster */
		private var jumpDirection:Boolean; 
		
		/** Jump motion */
		private var jumpStart:Number = 1; // hur mycket _jumpProgress är som orginalvalue, WV = 1
		private var fallingSpeed:Number = 1.048; // WV = 1.035, högre värde , längre drop
		private var _jumpProgress:Number = jumpStart; // // Hur mycket spelaren faller varje frame
		private var jumpPush:int = 0; // Värde som bestämmer hur länge pushen från väggen ska gälla
		
		
		//----------------------------------------------------------------------
		// Constructor method
		//----------------------------------------------------------------------
		
		
		public function InGame()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		/**
		 * Startas när inGame är utlagd på stage
		 * startar DrawGame
		 * Skapar scoreField
		 */
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			drawGame();
			
			scoreText = new TextField(300, 100, "Score: 0", Assets.getFont().name, 24, 0xffffff);
			scoreText.hAlign = HAlign.LEFT;
			scoreText.vAlign = VAlign.TOP;
			scoreText.x = 20;
			scoreText.y = 20;
			scoreText.border = true;
			scoreText.height = scoreText.textBounds.height + 10;
			this.addChild(scoreText);
		}
		
		
		/**
		 *  Skapar de element  som finns i gamemode, knapp, hero och bakgrund
		 */
		private function drawGame():void
		{
			bg = new GameBackground();
			this.addChild(bg);
			
			hero = new Hero();
			hero.x = stage.stageWidth/2;
			hero.y = stage.stageHeight/2;
			this.addChild(hero);
			
			startButton = new Button(Assets.getAtlas().getTexture("startButton"));
			startButton.x = stage.stageWidth * 0.5 - startButton.width * 0.5;
			startButton.y = stage.stageHeight * 0.5 - startButton.height * 0.5;
			this.addChild(startButton);
			
			gameArea = new Rectangle(0, 100, stage.stageWidth, stage.stageHeight);
		}
		
		
		/**
		 *  Dispose funktion, 
		 *  gömmer game  när man går ut i menyn
		 */
		public function disposeTemporarily():void
		{
			this.visible = false;
		}
		
		/**
		 * Initisierar game, gör objektet synligt
		 * Egenskaper återställs samt skapas.
		 */
		public function initialize():void
		{
			this.visible = true;
			this.addEventListener(Event.ENTER_FRAME, checkElapsed);
			
			hero.x = -stage.stageWidth;
			hero.y = stage.stageHeight * 0.5;
			
			gameState = "idle";
			
			playerSpeed = 0;
			hitObstacle = 0;
			
			bg.speed = 0;
			scoreDistance = 0;
	
			
			startButton.addEventListener(Event.TRIGGERED, onStartButtonClick);
		}
		
		
		/**
		 *  Funktion som startas när man trycker på startknappen i börhan av varje omgång.
		 */
		private function onStartButtonClick(event:Event):void
		{
			startButton.visible = false;
			startButton.removeEventListener(Event.TRIGGERED, onStartButtonClick);
			
			launchHero();
		}
		
		
		/**
		 *  Startar enter frame och touch hanterare
		 */
		private function launchHero():void
		{
			this.addEventListener(TouchEvent.TOUCH, onTouch);
			this.addEventListener(Event.ENTER_FRAME, onGameTick);
		}
		
		
		/**
		 *  Event hanterare för om man trycker på skärmen
		 */
		private function onTouch(event:TouchEvent):void
		{
			touch = event.getTouch(stage, TouchPhase.BEGAN);
			
			if(touch){
				jump = true;
			}		
		}
		
		/**
		 * Funktion som hanterar de olika lägena för Hero.
		 * 
		 */
		private function onGameTick(event:Event):void
		{
			switch(gameState)
			{
				case "idle":
					// Take off' används i början  av spelet.
					
					if (hero.x < stage.stageWidth * 0.4 * 0.4)
					{
						hero.x += ((stage.stageWidth * 0.5 * 0.5 + 10) - hero.x) * 0.05;
						hero.y = stage.stageHeight * 0.4;
						
						playerSpeed += (MIN_SPEED - playerSpeed) * 0.05;
						bg.speed = playerSpeed * elapsed;
					}
					else
					{
						gameState = "flying";
					}
					break;
				case "flying":
					
					
					if (hitObstacle <= 0) // om man inte träffar ett hinder
					{
						flyingMode();	
						
					}
					else
					{
						cameraShake();
					}
				
					
					//playerSpeed -= (playerSpeed - MIN_SPEED) * 0.1; // 
					//bg.speed = playerSpeed * elapsed; // snabbheten på banrenderingen
					
					scoreDistance += (playerSpeed * elapsed) * 0.1;
					scoreText.text = "Score: " + scoreDistance; //  Poängen
					
					break;
				case "over":
					break;
			}
		}
		
		/** 
		 * Gäller om spelares gamestate är flying
		 */
		private function flyingMode():void
		{
			
			HeroMovement();
			jumpCheck();
			
			
			// Rotation på spelaren när man hoppar
			if (-(hero.x - touchX) < 100 && -(hero.x - touchX) > -150)
			{
				hero.rotation = deg2rad(-(hero.x - touchX) * 0.2);
				
				//Roterar spelaren mitt i hoppet.
				if(hero.x < 500) {
					hero.scaleX = -hero.sizeY;
				}
				if(hero.x > 500) {
					hero.scaleX = hero.sizeX;
				}
			}
			
			//Gör så att spelaren stannar vid isväggarna
			if(jumpDirection) {
				hero.hitPointAxe.x = hero.x - 110;
			}
			else if(!jumpDirection) {
				hero.hitPointAxe.x = hero.x + 110;
			}

			// om man träffar högra väggen
			if (bg.bgLayer2.image2.bounds.contains(hero.hitPointAxe.x, hero.hitPointAxe.y) && jumpDirection == false)
			{	
				jump = false;
				jumpDirection = true;
				trace(hero.hitPointAxe.x);
			} 
			
			
			//Om man träffar vänstra väggen
			if (bg.bgLayer2.image1.bounds.contains(hero.hitPointAxe.x, hero.hitPointAxe.y)  && jumpDirection == true)
			{
				
				trace(hero.hitPointAxe.x);
				jump = false;
				jumpDirection = false;
				
				
			} 
			
		}		
		
		/**
		 *  OM spelaren hoppar
		 */
		private function jumpCheck():void
		{
			
			
			if(jump == true){
				if(jumpDirection == false) touchX += speedX;
				else touchX -= speedX;
				
				jumpPush++; 
				if(jumpPush > 10) { // hur länge hoppet ska vara uppåt
					
					_jumpProgress *= fallingSpeed;
					hero.y += _jumpProgress;
				} else hero.y -= 3; // liten rörelse uppåt innan spelaren faller
				
				
				
				
				
			}else{
				_jumpProgress = jumpStart; // Reset när spelaren avslutat hoppet
				jumpPush = 0;
			}
			
		}
		
		/**
		 *  Hjältens rörelse i X och Y led
		 */
		private function HeroMovement():void
		{
			hero.x -= (hero.x - touchX) * 0.15; // spelarens Rörelse i X-led
			if(jump == false) hero.y -= speedY; // om spelaren inte hoppar ska den glida längs väggen uppåt
			
		}		
		
		/**
		 *  Skapar kamerarörelse, startas endast när spelaren träffar ett hinder
		 * 
		 * TODO: Beroende på hur spelaren ska reagera vid träff, kan metoden tas bort.
		 */
		private function cameraShake():void
		{
			if (hitObstacle > 0)
			{
				this.x = int(Math.random() * hitObstacle);
				this.y = int(Math.random() * hitObstacle);
			}
			else if (x != 0)
			{
				this.x = 0;
				this.y = 0;
			}
		}
	
		
		/**
		 * Hur långt i spelet spelaren har kommit
		 */
		private function checkElapsed(event:Event):void
		{
			timePrevious = timeCurrent;
			timeCurrent = getTimer();
			elapsed = (timeCurrent - timePrevious) * 0.001;
		}
	}
}