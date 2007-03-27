package pl.cani.mindmap.commands {
	
	import com.adobe.cairngorm.commands.SequenceCommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.mikenimer.components.Debug;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	
	import pl.cani.mindmap.business.RegistrationServiceDelegate;
	import pl.cani.mindmap.events.ActivationAndLoggingEvent;
	import pl.cani.mindmap.events.LoggingEvent;

	public class ActivateAndLogInUserSequenceCommand extends SequenceCommand 
			implements IResponder {
		
		override public function execute( event : CairngormEvent ) : void {
			var activationEvent : ActivationAndLoggingEvent
				= event as ActivationAndLoggingEvent;
			
			var delegate : RegistrationServiceDelegate
				= new RegistrationServiceDelegate( this );

			delegate.activateUser( activationEvent.activationKey );
			
			nextEvent = new LoggingEvent( activationEvent.email, 
				activationEvent.password );
		}
		
		public function result( result : Object ) : void {
			executeNextCommand();
		}
		
		public function fault( fault : Object ) : void {
			Debug.show( fault );
		}
		
	}
	
}