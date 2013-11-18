package com.dobuki.portals.core
{
	
	import com.dobuki.portals.ScoreTable;
	import com.dobuki.portals.Trophy;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	
	public class BasePortal extends EventDispatcher implements IPortal
	{
		protected var root:DisplayObjectContainer;
		public var _active:Boolean = false;
		
		public function BasePortal(root:DisplayObjectContainer)
		{
			this.root = root;
		}
		
		public function get active():Boolean {
			return _active;
		}
		
		public function get username():String {
			return null;
		}
		
		public function postScore(score:Number,table:ScoreTable,tag:String=null):void {
		}
		
		public function unlock(achievement:Trophy):void {
		}
		
	}
}