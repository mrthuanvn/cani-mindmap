package pl.cani.mindmap.events {
	
	import com.adobe.cairngorm.control.CairngormEvent;

	public class UserServiceEvent extends CairngormEvent {
		
		public static const FIND_USERS : String = "findUsers";
		public static const USERS_FOUND : String = "usersFound";
		
		public var queryString : String;
		public var users : Array;
		
		public function UserServiceEvent( type : String ) {
			super( type );
		}
		
	}
}