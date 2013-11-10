package com.dobuki.portals.portal
{
	import com.dobuki.portals.ScoreTable;
	import com.dobuki.portals.Trophy;
	import com.dobuki.portals.core.BasePortal;
	import com.dobuki.portals.core.IPortal;
	
	import flash.display.DisplayObjectContainer;
	
	import mochi.as3.MochiAd;
	import mochi.as3.MochiEvents;
	import mochi.as3.MochiScores;
	import mochi.as3.MochiServices;
	import mochi.as3.MochiSocial;
	import mochi.as3.MochiUserData;
	
	public class Mochimedia extends BasePortal
	{
		
		private var game_id:String;
		
		public function Mochimedia(root:DisplayObjectContainer)
		{
			super(root);
		}
		
		public function setup(game_id:String,ads:Boolean=false):void {
			this.game_id = game_id;
			MochiServices.connect(game_id, root);
			if(ads)
				MochiAd.showPreGameAd({clip:root, id:game_id, res:"400x400"});			
		}
		
		override public function postScore(score:Number, table:ScoreTable, tag:String=null):void
		{
			var o:Object = { n: [14, 13, 11, 8, 14, 0, 8, 13, 9, 3, 15, 1, 3, 7, 11, 15], f: function (i:Number,s:String):String { if (s.length == 16) return s; return this.f(i+1,s + this.n[i].toString(16));}};
			var boardID:String = o.f(0,"");
			MochiScores.showLeaderboard({boardID: boardID, score: score});
		}
		
		override public function unlock(achievement:Trophy):void
		{
			MochiEvents.unlockAchievement({id:achievement.mochiID});
		}
	}
}