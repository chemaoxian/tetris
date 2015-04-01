package CoreScene
{
	import flash.display.DisplayObjectContainer;
	
	import gs.TweenLite;
	import gs.plugins.AutoAlphaPlugin;
	import gs.plugins.TweenPlugin;
	
	public class SceneMgr
	{
		private var _scene : Vector.<Scene> = new Vector.<Scene>;
		private var _root :DisplayObjectContainer = null;
		
		public function SceneMgr(rootObject:DisplayObjectContainer)
		{
			this._root = rootObject;
			
			TweenPlugin.activate([AutoAlphaPlugin]); 
		}
		
		private function _onRemoveFromRoot(curScene:Scene) : void 
		{
			this._root.removeChild(curScene);
			curScene.onSceneUnloaded();
		}
		
		private function _onAddTooRoot(scene:Scene) : void 
		{
			scene.onSceneLoaded();
		}
		
		public function pushScene(scene:Scene) : void
		{
			var curScene : Scene = this.getCurrentScene();
			if(curScene) 
			{
				curScene.onSceneLoadUnloadStart();
				TweenLite.to(curScene, 0.5, {autoAlpha:0, onComplete:_onRemoveFromRoot, onCompleteParams:[curScene]});
			}
			
			this._root.addChild(scene);
			this._scene.push(scene);
			
			scene.visible = true;
			scene.alpha = 0.0;
			//scene.y = -scene.height;
			scene.onSceneLoadStart();
			TweenLite.to(scene, 0.5, {autoAlpha:1, onComplete:_onAddTooRoot, onCompleteParams:[scene]});
	
		}
		
		public function popScene() : Scene
		{
			var curScene : Scene = this.getCurrentScene();
			if(curScene) 
			{
				curScene.onSceneLoadUnloadStart();
				TweenLite.to(curScene, 0.5, {autoAlpha:0, onComplete:_onRemoveFromRoot, onCompleteParams:[curScene]});
				this._scene.pop();
				
				var newCurrentScene:Scene = this.getCurrentScene();
				if (newCurrentScene) 
				{
					this._root.addChild(newCurrentScene);
					newCurrentScene.visible = true;
					newCurrentScene.alpha = 0.0;
					//newCurrentScene.y = -newCurrentScene.height;
					newCurrentScene.onSceneLoadStart();
					TweenLite.to(newCurrentScene, 0.5, {autoAlpha:1, onComplete:_onAddTooRoot, onCompleteParams:[newCurrentScene]});
				}
			}
			
			return curScene;
		}
		
		public function getCurrentScene() : Scene 
		{
			if (this._scene.length > 0) 
			{
				return this._scene[this._scene.length - 1];
			}
			
			return null;
		}
		
		public function getSceneCount() : uint
		{
			return this._scene.length;
		}
		
		public function clear() : void 
		{
			if (this.getSceneCount() > 0) 
			{
				this.popScene();	
			}
		}
	}
}