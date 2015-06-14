/**
 * Klassen returnerar grafik och texturer.
 * 
 * Lagrar grafik och fonts embedat i parametrar.
 */
package
{
	//----------------------------------------------------
	// Imports
	//----------------------------------------------------
	import flash.display.Bitmap;
	import flash.text.Font;
	import flash.utils.Dictionary;
	import starling.text.BitmapFont;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.text.TextField;

	//----------------------------------------------------
	// Class Assets
	//----------------------------------------------------
	public class Assets
	{
		
		//----------------------------------------------------
		// Public properties
		//----------------------------------------------------
		
		/* Bakgrund för startskärmen */
		[Embed(source="../media/graphics/bgWelcome.jpg")]
		public static const BgWelcome:Class;
		
		/* Bakgrund i spelet */
		[Embed(source="../media/graphics/bgLayer1.jpg")]
		public static const BgLayer1:Class;
		
		[Embed(source="../media/graphics/bgLayer2.jpg")]
		public static const BgLayer2:Class;
		
		[Embed(source="../media/graphics/bgLayer2change.jpg")]
		public static const BgLayer2change:Class;
		
		/* Bibliotek för grafiken */
		private static var gameTextures:Dictionary = new Dictionary();
		private static var gameTextureAtlas:TextureAtlas;
		
		/* Spritesheet för grafik i spelet */
		[Embed(source="../media/graphics/mySpritesheet.png")]
		public static const AtlasTextureGame:Class;
		
		/* XML för grafikens position i spritesheetet */
		[Embed(source="../media/graphics/mySpritesheet.xml", mimeType="application/octet-stream")]
		public static const AtlasXmlGame:Class;
		
		/* Spritesheet med grafik för text */
		[Embed(source="../media/fonts/myFont/desyrel.png")]
		public static const FontTexture:Class;
		
		/* XML för textens position i spritesheetet */
		[Embed(source="../media/fonts/myFont/desyrel.fnt", mimeType="application/octet-stream")]
		public static const FontXML:Class;
		
		/* Bitmap för att hålla fontsen */
		public static var myFont:BitmapFont;
		
		/* Standard font */
		[Embed(source="../media/fonts/embedded/Ubuntu-R.ttf", fontFamily="MyFontName", embedAsCFF="false")]
		public static var MyFont:Class;
		
		//----------------------------------------------------
		// Public methods
		//----------------------------------------------------
		
		/**
		 * Returnerar en font
		 */
		public static function getFont():BitmapFont
		{
			var fontTexture:Texture = Texture.fromBitmap(new FontTexture());
			var fontXML:XML = XML(new FontXML());
			
			var font:BitmapFont = new BitmapFont(fontTexture, fontXML);
			TextField.registerBitmapFont(font);
			
			return font;
		}
		
		/**
		 * Returnerar grafik från spritesheetet
		 */
		public static function getAtlas():TextureAtlas
		{
			if (gameTextureAtlas == null)
			{
				var texture:Texture = getTexture("AtlasTextureGame");
				var xml:XML = XML(new AtlasXmlGame());
				gameTextureAtlas = new TextureAtlas(texture, xml);
			}
			return gameTextureAtlas;
		}

		/**
		 * 
		 */
		public static function getTexture(name:String):Texture
		{
			if (gameTextures[name] == undefined)
			{
				
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
	}
}