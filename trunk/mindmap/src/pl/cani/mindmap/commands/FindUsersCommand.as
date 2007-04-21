package pl.cani.mindmap.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.mikenimer.components.Debug;
	
	import mx.rpc.IResponder;
	
	import pl.cani.mindmap.business.UserServiceDelegate;
	import pl.cani.mindmap.events.UserServiceEvent;

	public class FindUsersCommand implements ICommand, IResponder {
		
		public function FindUsersCommand() {
		}
		
		public function execute( event : CairngormEvent ) : void {
			var userServiceEvent : UserServiceEvent = event as UserServiceEvent;
			var queryString : String = userServiceEvent.queryString;
			
			var delegate : UserServiceDelegate = new UserServiceDelegate( this );
			delegate.findUsers( queryString );
		}
		
		public function result( data : Object ) : void {
			var users : Array = data.result;
			var event : UserServiceEvent 
				= new UserServiceEvent( UserServiceEvent.USERS_FOUND );
			event.users = users;
			CairngormEventDispatcher.getInstance().dispatchEvent( event );
		}
		
		public function fault( info : Object ) : void {
			Debug.show( info.fault );
		}
		
	}
}