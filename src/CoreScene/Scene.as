package CoreScene
{
	import flash.display.Sprite;

	public class Scene extends Sprite
	{
		public static const SCENE_ANIM_BEFOR_ENTER:String = "beforEnterScene";
		public static const SCENE_ANIM_AFTER:String = "afterEnterScene";
		public static const SCENE_ANIM_BEFOR_OUTER:String = "beforOutScene";
		public static const SCENE_ANIM_AFTER_ENTER:String = "afterOutScene";
		
		private var _name:String = "";

		public function Scene(name)
		{
			this._name = name;			
		}
	
		public function sceneName() : String
		{
			return this._name;	
		}
		
		public function onSceneLoadStart() : void
		{
			trace ("onSceneLoadStart "+ this._name);
		}
		
		public function onSceneLoaded() : void
		{
			trace ("onSceneLoaded " + this._name);
		}
		
		public function onSceneLoadUnloadStart() : void
		{
			trace ("onSceneLoadUnloadStart "+ this._name);
		}
		
		public function onSceneUnloaded() : void
		{
			trace ("onSceneUnloaded "+ this._name);
		}
	}
}