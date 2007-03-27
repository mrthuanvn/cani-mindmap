package pl.cani.mindmap.events {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.crypto.MD5;
	
	import pl.cani.mindmap.control.Controller;

	public class ActivationAndLoggingEvent extends CairngormEvent {
		
		public var email : String;
		public var password : String;
		public var activationKey : String;
		
		public function ActivationAndLoggingEvent( email : String, 
				password : String, activationKey : String ) {
					
			super( Controller.ACTIVATION_AND_LOGGING );
			
			this.email = email;
			
			// I dont need to hash the password as it will be when wraped in LoggingEvent object
			this.password = password;
			
			this.activationKey = activationKey;
		}
		
	}
	
}