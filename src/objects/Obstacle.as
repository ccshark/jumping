package objects
{
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Obstacle extends Sprite
	{
		private var _type:int;
		private var _speed:int;
		private var _distance:int;
		private var _watchOut:Boolean;
		private var _alreadyHit:Boolean;
		private var _position:String;
		private var obstacleImage:Image;
		private var obstacleCrashImage:Image;
		private var obstacleAnimation:Image;
		private var watchOutAnimation:MovieClip;
		
		public function Obstacle(_type:int, _distance:int, _watchOut:Boolean = true, _speed:int = 0)
		{
			super();
			
			this._type = _type;
			this._distance = _distance;
			this._watchOut = _watchOut;
			this._speed = _speed;
			
			_alreadyHit = false;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function get speed():int
		{
			return _speed;
		}

		public function set speed(value:int):void
		{
			_speed = value;
		}

		public function get distance():int
		{
			return _distance;
		}

		public function set distance(value:int):void
		{
			_distance = value;
		}

		public function get position():String
		{
			return _position;
		}

		public function set position(value:String):void
		{
			_position = value;
		}

		public function get alreadyHit():Boolean
		{
			return _alreadyHit;
		}

		public function set alreadyHit(value:Boolean):void
		{
			_alreadyHit = value;
			
			if (value)
			{
				obstacleCrashImage.visible = true;
				if (_type == 4) obstacleAnimation.visible = false;
				else obstacleImage.visible = false;
			}
		}

		public function get watchOut():Boolean
		{
			return _watchOut;
		}

		public function set watchOut(value:Boolean):void
		{
			_watchOut = value;
			
			if (watchOutAnimation)
			{
				if (value) watchOutAnimation.visible = true;
				else watchOutAnimation.visible = false;
			}
		}

		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			createObstacleArt();
			createObstacleCrashArt();
			createWatchOutAnimation();
		}
		
		private function createWatchOutAnimation():void
		{
			watchOutAnimation = new MovieClip(Assets.getAtlas().getTextures("watchOut_"), 10);
			Starling.juggler.add(watchOutAnimation);
			
			if (_type == 4)
			{
				//watchOutAnimation.x = -watchOutAnimation.texture.width;
				//watchOutAnimation.y = obstacleAnimation.y + (obstacleAnimation.texture.height * 0.5) - (watchOutAnimation.texture.height * 0.5);
			}
			else
			{
				watchOutAnimation.x = -watchOutAnimation.texture.width;
				watchOutAnimation.y = obstacleImage.y + (obstacleImage.texture.height * 0.5) - (watchOutAnimation.texture.height * 0.5);
			}
			this.addChild(watchOutAnimation);
		}
		
		private function createObstacleCrashArt():void
		{
			obstacleCrashImage = new Image(Assets.getAtlas().getTexture("iceblock"));
			obstacleCrashImage.visible = false;
			this.addChild(obstacleCrashImage);
		}
		
		
		/**
		 * Skapar ett nytt isblock
		 */
		private function createObstacleArt():void
		{
			if (_type == 4)
			{
				var block:Image = new Image(Assets.getAtlas().getTexture("icewall"));
				
				block.x = 0;
				block.y = 0
				block.scaleY = 4; //temp
				
				this.addChild(block);
			}
			else
			{			
				obstacleImage = new Image(Assets.getAtlas().getTexture("iceblock"));
				obstacleImage.x = 0;
				obstacleImage.y = 0;
				this.addChild(obstacleImage);
			}
		}
		
	}
}