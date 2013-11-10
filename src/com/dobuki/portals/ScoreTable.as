package com.dobuki.portals
{
	import com.dobuki.portals.core.IPortal;
	import com.dobuki.portals.core.Portal;

	public class ScoreTable
	{
		private var portal:IPortal;
		public var newgroundsName:String, gamejoltID:String,kongregateStat:String,mochiID:String;
		public function ScoreTable(portal:IPortal)
		{
			this.portal = portal;
		}
		
		public function postScore(score:Number,tag:String=null):void {
			portal.postScore(score,this,tag);
		}
	}
}