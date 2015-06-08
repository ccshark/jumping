package screens
{
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	
	import objects.GameBackground;
	import objects.Hero;
	import objects.Item;
	import objects.Obstacle;
	
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
	
	public class InGame extends Sprite
	{
		private var startButton:Button;
		private var bg:GameBackground;
		private var hero:Hero;
		
		private var timePrevious:Number;
		private var timeCurrent:Number;
		private var elapsed:Number;
		
		private var gameState:String;
		private var playerSpeed:Number;
		private var hitObstacle:Number = 0;
		private const MIN_SPEED:Number = 650;
		
		private var scoreDistance:int;
		private var obstacleGapCount:int;
		
		private var gameArea:Rectangle;
		
		private var touch:Touch;
		private var touchX:Number = 300; // X positionen
		private var touchY:Number = 300; // Y positionen
		
		private var obstaclesToAnimate:Vector.<Obstacle>;
		private var itemsToAnimate:Vector.<Item>;
		
		private var scoreText:TextField;
		private var inAir:Boolean = false; // om spelaren är i luften, används för att spelaren inte ska kunna hoppa ändra riktning när den är i luften.
		private var jump:Boolean = false // spelaren ska hoppa
		private var jumpDirection:Boolean; // åt vilket håll spelaren ska röra sig, false = höger, true = vänster
		
		public function InGame()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
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
		
		public function disposeTemporarily():void
		{
			this.visible = false;
		}
		
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
			obstacleGapCount = 0;
			
			obstaclesToAnimate = new Vector.<Obstacle>();
			itemsToAnimate = new Vector.<Item>();
			
			startButton.addEventListener(Event.TRIGGERED, onStartButtonClick);
		}
		
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
				//touchX = touch.globalX;
				jump = true;
			}		
		}
		
		/**
		 * Game loop som hanterar de olika lägena för spelaren.
		 */
		private function onGameTick(event:Event):void
		{
			switch(gameState)
			{
				case "idle":
					// Take off'
					
					if (hero.x < stage.stageWidth * 0.5 * 0.5)
					{
						hero.x += ((stage.stageWidth * 0.5 * 0.5 + 10) - hero.x) * 0.05;
						hero.y = stage.stageHeight * 0.5;
						
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
						
						hero.x -= (hero.x - touchX) * 0.1;
						
						// Om jump är sant ska spelaren röra sig
						if(jump == true){
							if(jumpDirection == false) touchX += 10;
							else touchX -= 10;
							
						}
						
						
						// Rotation på spelaren när man hoppar
						if (-(hero.x - touchX) < 100 && -(hero.x - touchX) > -150)
						{
							hero.rotation = deg2rad(-(hero.x - touchX) * 0.2);
							
							//Roterar spelaren mitt i hoppet.
							if(hero.x < 500) {
								hero.scaleX = -1;
							}
							if(hero.x > 400) {
								hero.scaleX = 1;
							}
						}
						
						// om man träffar högra väggen
						if (hero.x > (gameArea.right - hero.width * 0.5) && jumpDirection == false)
						{
							//hero.x = gameArea.right - hero.width * 0.5;
							//hero.rotation = deg2rad(0);
							jump = false;
							jumpDirection = true;
							//hero.scaleX = 1;
						} 

						
						//Om man träffar vänstra väggen
						if (hero.x < (gameArea.left + hero.width * 0.5) && jumpDirection == true)
						{
							//hero.x = gameArea.left + hero.width * 0.5;
							//hero.rotation = deg2rad(0);
							jump = false;
							jumpDirection = false;
							
							//hero.scaleX = -1;
						} 
					}
					else
					{
						hitObstacle--;
						cameraShake();
					}
					
					//Ändrar spelarens riktning efter hoppet.
					/*if(jumpDirection && jumping) {
						hero.scaleX = 1;
					}
					if(!jumpDirection && jumping) {
						hero.scaleX = -1;
					} */
					
					
					playerSpeed -= (playerSpeed - MIN_SPEED) * 0.1; // 
					bg.speed = playerSpeed * elapsed; // snabbheten på banrenderingen
					//hero.y --; // spelaren rör sig sakta uppåt
					
					scoreDistance += (playerSpeed * elapsed) * 0.1;
					
					scoreText.text = "Score: " + scoreDistance; //  Poängen
					
					//initObstacle();
					//animateObstacles();
					
					//createFoodItems();
					//animateItems();
					
					break;
				case "over":
					break;
			}
		}
		
		/*
		private function animateItems():void
		{
			var itemToTrack:Item;
			
			for(var i:uint = 0; i < itemsToAnimate.length; i++)
			{
				itemToTrack = itemsToAnimate[i];
				
				itemToTrack.x -= playerSpeed * elapsed;
				
				if (itemToTrack.bounds.intersects(hero.bounds))
				{
					itemsToAnimate.splice(i, 1);
					this.removeChild(itemToTrack);	
				}
				
				if (itemToTrack.x < -50)
				{
					itemsToAnimate.splice(i, 1);
					this.removeChild(itemToTrack);	
				}
			}
		}
		
		private function createFoodItems():void
		{
			if (Math.random() > 0.95)
			{
				var itemToTrack:Item = new Item(Math.ceil(Math.random() * 5));
				itemToTrack.x = stage.stageWidth + 50;
				itemToTrack.y = int(Math.random() * (gameArea.bottom - gameArea.top)) + gameArea.top;
				this.addChild(itemToTrack);
				
				itemsToAnimate.push(itemToTrack);
			}
		}
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
		/*
		private function animateObstacles():void
		{
			var obstacleToTrack:Obstacle;
			
			for (var i:uint = 0;i<obstaclesToAnimate.length;i++)
			{
				obstacleToTrack = obstaclesToAnimate[i];
				
				if (obstacleToTrack.alreadyHit == false && obstacleToTrack.bounds.intersects(hero.bounds))
				{
					obstacleToTrack.alreadyHit = true;
					obstacleToTrack.rotation = deg2rad(70);
					hitObstacle = 30;
					playerSpeed *= 0.5;
				}
				
				if (obstacleToTrack.distance > 0)
				{
					obstacleToTrack.distance -= playerSpeed * elapsed;
				}
				else
				{
					if (obstacleToTrack.watchOut)
					{
						obstacleToTrack.watchOut = false;
					}
					obstacleToTrack.x -= (playerSpeed + obstacleToTrack.speed) * elapsed;
				}
				
				if (obstacleToTrack.x < -obstacleToTrack.width || gameState == "over")
				{
					obstaclesToAnimate.splice(i, 1);
					this.removeChild(obstacleToTrack);
				}
			}
		}
		
		private function initObstacle():void
		{
			if (obstacleGapCount < 1200)
			{
				obstacleGapCount += playerSpeed * elapsed;
			}
			else if (obstacleGapCount != 0)
			{
				obstacleGapCount = 0;
				createObstacle(Math.ceil(Math.random() * 4), Math.random() * 1000 + 1000);
				
			}
		}
		
		private function createObstacle(type:Number, distance:Number):void
		{
			var obstacle:Obstacle = new Obstacle(type, distance, true, 300);
			obstacle.x = stage.stageWidth;
			this.addChild(obstacle);
			
			if (type <= 3)
			{
				if (Math.random() > 0.5)
				{
					obstacle.y = gameArea.top;
					obstacle.position = "top";
				}
				else
				{
					obstacle.y = gameArea.bottom - obstacle.height;
					obstacle.position = "bottom";
				}
			}
			else
			{
				obstacle.y = int(Math.random() * (gameArea.bottom - obstacle.height - gameArea.top)) + gameArea.top;
				obstacle.position = "middle";
			}
			obstaclesToAnimate.push(obstacle);
		}
		*/
		private function checkElapsed(event:Event):void
		{
			timePrevious = timeCurrent;
			timeCurrent = getTimer();
			elapsed = (timeCurrent - timePrevious) * 0.001;
		}
	}
}