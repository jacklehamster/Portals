package com.dobuki.portals.portal
{
	import com.dobuki.portals.ScoreTable;
	import com.dobuki.portals.Trophy;
	import com.dobuki.portals.core.BasePortal;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import by.blooddy.crypto.MD5;
	import by.blooddy.crypto.serialization.JSON;

	public class Gamejolt extends BasePortal
	{
		private var game_id:String, private_key:String;
		
		public function Gamejolt(root:DisplayObjectContainer)
		{
			super(root);
		}

		public function setup(game_id:String,private_key:String):void
		{
			this.game_id = game_id;
			this.private_key = private_key;
		}
		
		override public function get username():String {
			return root.loaderInfo.parameters.gjapi_username;
		}
		
		public function get token():String {
			return root.loaderInfo.parameters.gjapi_token;
		}
		
		public function isGuest():Boolean {
			return username=="" && token=="";
		}
				
		override public function postScore(score:Number,table:ScoreTable,tag:String=null):void {
			var url:String = "http://gamejolt.com/api/game/v1/scores/add?game_id="+game_id;
			url += "&score="+score;
			url += "&sort="+score;
			url += "&username="+username;
			url += "&user_token="+token;
			if(table.gamejoltID) {
				url += "&table_id="+table.gamejoltID;
			}
			if(tag) {
				url += "&extra_data"+tag;
			}
			performRequest(url,null);
		}
		
		override public function unlock(achievement:Trophy):void {
			var url:String = "http://gamejolt.com/api/game/v1/trophies/add-achieved?game_id="+game_id;			
			url += "&username="+username;
			url += "&user_token="+token;
			url += "&trophy_id="+achievement.gamejoltID;
			performRequest(url,null);
		}
		
		private function performRequest(url:String,callback:Function):void {
			if(username && token) {
				var md5:String = MD5.hash(url+private_key);
				url += "&signature="+md5;
				var loader:URLLoader = new URLLoader();
				var request:URLRequest = new URLRequest(url);
				var onComplete:Function = function(e:Event):void {
					loader.removeEventListener(Event.COMPLETE,onComplete);
					loader.removeEventListener(IOErrorEvent.IO_ERROR,onError);
					var result:Object = {};
					var itemSplit:Array = loader.data.split("\n");
					for each(var line:String in itemSplit) {
						var pair:Array = line.split(":");
						result[pair[0]] = by.blooddy.crypto.serialization.JSON.decode(pair[1]);
					}
					if(callback)
						callback(result);
				};
				var onError:Function = function(e:Event):void {
					loader.removeEventListener(Event.COMPLETE,onComplete);
					loader.removeEventListener(IOErrorEvent.IO_ERROR,onError);
					if(callback)
						callback(null);
				};
				loader.addEventListener(Event.COMPLETE,onComplete);
				loader.addEventListener(IOErrorEvent.IO_ERROR,onError);
				loader.load(request);
			}
			else {
				if(callback)
					callback(null);
			}
		}
		
	}
}