package pl.cani.mindmap.control {
	
	import com.adobe.cairngorm.control.FrontController;
	import pl.cani.mindmap.commands.*;

	public class Controller extends FrontController	{
		
		public static const REGISTRATION : String = "registration";
		public static const LOGGING : String = "logging";
		public static const ACTIVATION_AND_LOGGING : String = "activationAndLogging";
		public static const ACTIVATION : String = "activation";
		public static const VIEW : String = "view";
		public static const LOGOUT : String = "logout";

		public function Controller() {
			addCommand( REGISTRATION, RegisterUserCommand );
			addCommand( LOGGING, LogInUserCommand );
			addCommand( ACTIVATION_AND_LOGGING, ActivateAndLogInUserSequenceCommand );
			addCommand( ACTIVATION, ActivateUserCommand );
			addCommand( VIEW, ShowViewCommand );
			addCommand( LOGOUT, LogOutUserCommand );
		}
		
	}
}