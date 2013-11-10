package com.dobuki.portals.core
{
	import com.dobuki.portals.ScoreTable;
	import com.dobuki.portals.Trophy;
	import com.dobuki.portals.portal.Gamejolt;
	import com.dobuki.portals.portal.Kongregate;
	import com.dobuki.portals.portal.Mochimedia;
	import com.dobuki.portals.portal.Newgrounds;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import avmplus.getQualifiedClassName;

	public class Portal extends BasePortal
	{
		static private const HOSTS:Object = {
			gamejolt: 	"http://data-02.gamejolt.com",
			mochimedia: "http://games.mochiads.com",
			newgrounds: "http://uploads.ungrounded.net",
			kongregate: "http://chat.kongregate.com/gamez"
		};
		
		
		private var _gamejolt:Gamejolt;
		private var _kongregate:Kongregate;
		private var _mochimedia:Mochimedia;
		private var _newgrounds:Newgrounds;
		private var _hostPortal:IPortal;
		
		static private var _instance:Portal;
		
		public function Portal(root:DisplayObjectContainer)
		{
			super(root);
		}
		
		static public function init(root:DisplayObjectContainer):void {
			_instance = new Portal(root);
		}
		
		static public function get instance():Portal {
			return _instance;
		}
		
		override public function get username():String {
			return hostPortal.username;
		}
		
		override public function postScore(score:Number,table:ScoreTable,tag:String=null):void {
			hostPortal.postScore(score,table,tag);
		}
		
		override public function unlock(achievement:Trophy):void {
			hostPortal.unlock(achievement);
		}
		
		public function setup(
			gamejolt_id:String, gamejolt_key:String,
			mochi_id:String,
			newgrounds_id:String,newgrounds_key:String):void {
			if(host=="gamejolt") {
				gamejolt.setup(gamejolt_id,gamejolt_key);
			}
			if(host=="kongregate") {
				kongregate.setup();
			}
			if(host=="mochimedia") {
				mochimedia.setup(mochi_id);
			}
			if(host=="newgrounds") {
				newgrounds.setup(newgrounds_id,newgrounds_key);
			}
		}
		
		public function createScoreTable(
				gamejoltID:String,
				kongregateStat:String,
				mochiID:String,
				newgroundsName:String
			):ScoreTable
		{
			var table:ScoreTable = new ScoreTable(this);
			table.gamejoltID = gamejoltID;
			table.kongregateStat = kongregateStat;
			table.mochiID = mochiID;
			table.newgroundsName = newgroundsName;
			return table;
		}
		
		public function createTrophy(
			gamejoltID:String,
			kongregateStat:String,
			mochiID:String,
			newgroundsName:String
		):Trophy
		{
			var trophy:Trophy = new Trophy(this);
			trophy.gamejoltID = gamejoltID;
			trophy.kongregateStat = kongregateStat;
			trophy.mochiID = mochiID;
			trophy.newgroundsName = newgroundsName;
			return trophy;
		}
	
		private function get hostPortal():IPortal {
			if(_hostPortal) {
				return _hostPortal;
			}
			switch(host) {
				case "gamejolt":
					_hostPortal = gamejolt;
					break;
				case "mochimedia":
					_hostPortal = mochimedia;
					break;
				case "kongregate":
					_hostPortal = kongregate;
					break;
				case "newgrounds":
					_hostPortal = newgrounds;
					break;
			}
			return _hostPortal;
		}

		
		public function get host():String {
			for(var i:String in host) {
				if(root.loaderInfo.url.indexOf(HOSTS[i])==0) {
					return i;
				}
			}
			return null;
		}
		
		public function get gamejolt():Gamejolt {
			return _gamejolt ? _gamejolt : _gamejolt = (new Gamejolt(root)) as Gamejolt;
		}
		
		public function get newgrounds():Newgrounds {
			return _newgrounds ? _newgrounds : _newgrounds = (new Newgrounds(root)) as Newgrounds;
		}
		
		public function get kongregate():Kongregate {
			return _kongregate ? _kongregate : _kongregate = (new Kongregate(root)) as Kongregate;
		}
		
		public function get mochimedia():Mochimedia {
			return _mochimedia ? _mochimedia : _mochimedia = (new Mochimedia(root)) as Mochimedia;
		}
		
		
	}
}