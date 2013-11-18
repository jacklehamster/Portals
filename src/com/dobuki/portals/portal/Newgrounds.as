package com.dobuki.portals.portal
{
	import com.dobuki.portals.ScoreTable;
	import com.dobuki.portals.Trophy;
	import com.dobuki.portals.core.BasePortal;
	import com.newgrounds.API;
	
	import flash.display.DisplayObjectContainer;

	public class Newgrounds extends BasePortal
	{
		public function Newgrounds(root:DisplayObjectContainer)
		{
			super(root);
		}
		
		public function setup(apiId:String=null,encryptionKey:String=null):void {
			this._active = true;
			if(apiId && encryptionKey)
				API.connect(root, apiId, encryptionKey);			
		}
		
		override public function postScore(score:Number,table:ScoreTable,tag:String=null):void {
			API.postScore(table.newgroundsName?table.newgroundsName:API.scoreBoards[0],score,tag);
		}
		
		override public function unlock(achievement:Trophy):void {
			API.unlockMedal(achievement.newgroundsName);
		}
		
		override public function get username():String {
			return API.username;
		}
	}
}