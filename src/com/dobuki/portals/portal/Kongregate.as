package com.dobuki.portals.portal
{
	import com.dobuki.portals.core.BasePortal;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.Security;
	
	public class Kongregate extends BasePortal
	{
		
		private var kongregate:Object;
		
		public function Kongregate(root:DisplayObjectContainer)
		{
			super(root);
		}
		
		public function setup():void {
			var apiPath:String = root.loaderInfo.parameters.kongregate_api_path || "http://www.kongregate.com/flash/API_AS3_Local.swf";
			Security.allowDomain(apiPath);
			
			var request:URLRequest = new URLRequest(apiPath);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
			loader.load(request);
			root.addChild(loader);
		}
		
		private function loadComplete(event:Event):void {
			kongregate = event.target.content;
			
			// Connect to the back-end
			kongregate.services.connect();
		}
		
		override public function get username():String {
			return root.loaderInfo.parameters.kongregate_username;
		}
	}
}