package com.dobuki.portals
{
	import com.dobuki.portals.core.IPortal;

	public class Trophy
	{
		private var portal:IPortal;
		public var newgroundsName:String, gamejoltID:String, kongregateStat:String, mochiID:String;
		public function Trophy(portal:IPortal)
		{
			this.portal = portal;
		}
		
		public function unlock():void {
			portal.unlock(this);
		}
	}
}