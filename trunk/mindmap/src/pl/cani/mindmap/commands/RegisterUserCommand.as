package pl.cani.mindmap.commands {

	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.view.ViewLocator;
	import com.mikenimer.components.Debug;
	
	import flash.events.EventDispatcher;
	
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import pl.cani.mindmap.business.RegistrationServiceDelegate;
	import pl.cani.mindmap.business.exceptions.UserAlreadyExistsException;
	import pl.cani.mindmap.events.RegistrationEvent;
	import pl.cani.mindmap.model.AppModelLocator;
	import pl.cani.mindmap.view.RegistrationForm;
	import pl.cani.mindmap.view.helpers.RegistrationFormHelper;
	import pl.cani.mindmap.view.helpers.ViewNames;
	import pl.cani.mindmap.vo.UserVO;

	[ Event( name = "registrationComplete", 
		type = "pl.cani.mindmap.events.RegistrationEvent" ) ]

	[ Event( name = "userAleradyExists", 
		type = "pl.cani.mindmap.events.RegistrationEvent" ) ]

	public class RegisterUserCommand extends EventDispatcher 
		implements ICommand, IResponder {
		
		public function RegisterUserCommand() {
			registerListener();
		}
		
		private function registerListener() : void {
			var registrationFormHelper : RegistrationFormHelper
				= ViewLocator.getInstance().getViewHelper( 
					ViewNames.REGISTRATION_FORM ) as RegistrationFormHelper;
					
			addEventListener( RegistrationEvent.REGISTRATION_COMPLETE, 
				registrationFormHelper.onRegistrationComplete );
			addEventListener( RegistrationEvent.USER_ALREADY_EXISTS, 
				registrationFormHelper.onUserAlreadyExists );				
		}

		public function execute( event : CairngormEvent ) : void {
			var registrationEvent : RegistrationEvent = event as RegistrationEvent;
			var delegate : RegistrationServiceDelegate 
				= new RegistrationServiceDelegate( this );
 			delegate.registerUser( registrationEvent.user ); 
		}
		
		public function result( event : Object ) : void {
			event = event as ResultEvent;
			
			if ( event.result is UserAlreadyExistsException ) {
				var exception : UserAlreadyExistsException 
					= event.result as UserAlreadyExistsException;
					
				var user : UserVO = exception.user;
				
				var registrationEvent : RegistrationEvent = new RegistrationEvent( 
					RegistrationEvent.USER_ALREADY_EXISTS, user );
					
				dispatchEvent( registrationEvent );
			} else {
				registrationEvent = new RegistrationEvent( 
					RegistrationEvent.REGISTRATION_COMPLETE );
					
				dispatchEvent( registrationEvent );
			}
		}
		
		public function fault( event : Object ) : void {
			var faultEvent : FaultEvent = event as FaultEvent;
			Debug.show( faultEvent.fault );
		}
		
	}
}
