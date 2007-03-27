package pl.cani.mindmap.events {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.crypto.MD5;
	
	import pl.cani.mindmap.control.Controller;

	public class LoggingEvent extends CairngormEvent {
		
		public var email : String;
		public var password : String;
		
		public function LoggingEvent( email : String, password : String ) {
			super( Controller.LOGGING );
			this.email = email;
			this.password = MD5.hash( password );
		}
		
	}
	
}