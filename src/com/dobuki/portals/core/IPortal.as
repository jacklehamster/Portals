package com.dobuki.portals.core
{
	import com.dobuki.portals.ScoreTable;
	import com.dobuki.portals.Trophy;
	
	import flash.events.IEventDispatcher;

	public interface IPortal extends IEventDispatcher
	{
		function get active():Boolean;
		function get username():String;
		function postScore(score:Number,table:ScoreTable,tag:String=null):void;
		function unlock(achievement:Trophy):void
	}
}