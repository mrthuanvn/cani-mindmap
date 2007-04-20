package pl.cani.mindmap.events {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import pl.cani.mindmap.control.Controller;
	import pl.cani.mindmap.vo.UserVO;
	
	
	public class RegistrationEvent extends CairngormEvent {
		
		public static const REGISTER_USER : String = "registerUser";
		public static const REGISTRATION_COMPLETE : String = "registrationComplete";
		public static const USER_ALREADY_EXISTS : String = "userAlreadyExists";
		
		public var user : UserVO;
		
		public function RegistrationEvent( type : String, user : UserVO = null ) {
			super( type );
			this.user = user;
		}
		
	}
}