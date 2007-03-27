package pl.cani.mindmap.events {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import pl.cani.mindmap.control.Controller;
	import pl.cani.mindmap.vo.UserVO;
	
	
	public class RegistrationEvent extends CairngormEvent {
		
		public var user : UserVO;
		
		public function RegistrationEvent( user : UserVO ) {
			super( Controller.REGISTRATION );
			this.user = user;
		}
		
	}
}