package UI
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Transform;

	public class Button extends Sprite
	{	
		private var _mc :MovieClip  = null;
		public static const BUTTON_CLICK_EVENT: String = "BUTTON_CLICK_EVENT";
		
		public function Button(mc:MovieClip)
		{
			this._mc = mc;	
			this.buttonMode = true;
			this.mouseChildren = false;
			this.doubleClickEnabled = false;
			
			this.addChild(this._mc);
			this.addEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
			this.addEventListener(MouseEvent.MOUSE_OVER, _onMouseHover);
			this.addEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
			this.addEventListener(MouseEvent.MOUSE_OUT, _onMouseOut);
			
			this._mc.gotoAndStop(1);
		}
		
		private function _onMouseHover(e : MouseEvent) : void
		{
			this._mc.gotoAndStop(3);
		}
		
		private function _onMouseDown(e : MouseEvent) : void 
		{
			this._mc.gotoAndStop(2);
		}
		
		private function _onMouseUp (e: MouseEvent) : void 
		{		
			this._mc.gotoAndStop(3);
			this.dispatchEvent(new Event(Button.BUTTON_CLICK_EVENT));
		}
		
		private function _onMouseDisable(e : MouseEvent) : void 
		{
			this._mc.gotoAndStop(4);
		}
		
		private function _onMouseOut(e : MouseEvent) : void 
		{
			this._mc.gotoAndStop(1);
		}
	}
}