package pl.cani.mindmap.control {
	
	import com.adobe.cairngorm.control.FrontController;
	
	import pl.cani.mindmap.commands.*;
	import pl.cani.mindmap.events.MindmapEvent;
	import pl.cani.mindmap.events.RegistrationEvent;
	import pl.cani.mindmap.events.UserServiceEvent;

	public class Controller extends FrontController	{
		
		public static const LOGGING : String = "logging";
		public static const ACTIVATION_AND_LOGGING : String = "activationAndLogging";
		public static const ACTIVATION : String = "activation";
		public static const VIEW : String = "view";
		public static const LOGOUT : String = "logout";

		public function Controller() {
			addCommand( RegistrationEvent.REGISTER_USER, RegisterUserCommand );
			addCommand( LOGGING, LogInUserCommand );
			addCommand( ACTIVATION_AND_LOGGING, ActivateAndLogInUserSequenceCommand );
			addCommand( ACTIVATION, ActivateUserCommand );
			addCommand( VIEW, ShowViewCommand );
			addCommand( LOGOUT, LogOutUserCommand );
			
			addCommand( MindmapEvent.ADD, AddMindmapCommand );
			addCommand( MindmapEvent.GET_BY_OWNER_ID, GetMindmapsByOwnerIdCommand );
			addCommand( MindmapEvent.GET_BY_OWNER_ID_REFRESHED, GetMindmapsByOwnerIdCommand );
			addCommand( MindmapEvent.SET_PRIVILAGES_FOR_USER, SetPrivilagesForUserCommand );
			addCommand( MindmapEvent.FIND_MINDMAP_USERS, FindMindmapUsersCommand );
			
			addCommand( UserServiceEvent.FIND_USERS, FindUsersCommand );
		}
		
	}
}