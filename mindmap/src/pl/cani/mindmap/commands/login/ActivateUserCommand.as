package pl.cani.mindmap.commands.login {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.mikenimer.components.Debug;
	
	import mx.controls.Alert;
	import mx.resources.ResourceBundle;
	import mx.rpc.IResponder;
	
	import pl.cani.mindmap.business.RegistrationServiceDelegate;
	import pl.cani.mindmap.events.ActivationEvent;

	public class ActivateUserCommand implements ICommand, IResponder {
	
		[ResourceBundle( name = "ActivateUserCommand" )]
		private var rb : ResourceBundle;
	
		public function execute( event : CairngormEvent ) : void {
			var activationEvent : ActivationEvent
				= event as ActivationEvent;
			
			var delegate : RegistrationServiceDelegate
				= new RegistrationServiceDelegate( this );

			delegate.activateUser( activationEvent.activationKey );
		}
		
		public function result( data : Object ) : void {
			Alert.show( rb.getString( "message" ) );
		}
		
		public function fault( info : Object ) : void {
			Debug.show( info );
		}
		
	}
	
}