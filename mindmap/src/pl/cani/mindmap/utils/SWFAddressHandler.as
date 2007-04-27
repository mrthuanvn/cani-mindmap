package pl.cani.mindmap.utils {

	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.asual.swfaddress.SWFAddress;
	
	import mx.controls.Alert;
	
	import pl.cani.mindmap.business.SessionAndPersitentData;
	import pl.cani.mindmap.control.Controller;
	import pl.cani.mindmap.events.ActivationEvent;
	import pl.cani.mindmap.events.EventFactory;
	import pl.cani.mindmap.events.LoggingEvent;
	import pl.cani.mindmap.events.RegistrationEvent;
	import pl.cani.mindmap.events.ViewEvent;
	import pl.cani.mindmap.view.helpers.ViewNames;
	import pl.cani.mindmap.vo.UserVO;
	
	
	public class SWFAddressHandler {
		
		public static function handle() : void {
			var value : String = SWFAddress.getValue();
//			Alert.show( value );
			
			var sections : Array = getSections( value );
			var params : Array = getParams();
			
			var event : CairngormEvent = EventFactory.createEvent( sections, params );

			// redirect if not logged in
			var viewEvent : ViewEvent = event as ViewEvent;
			var loggedInUser : UserVO = SessionAndPersitentData.getInstance()
				.getLoggedInUser();
			if ( viewEvent != null ) {

				var isLoginOrRegistration : Boolean = 
					viewEvent.section == ViewNames.LOGIN_FORM 
					|| viewEvent.section == ViewNames.REGISTRATION_FORM;

				if ( isLoginOrRegistration == false && loggedInUser == null ) {
					event = new ViewEvent( "login" );
				}
			}

			if ( event != null ) {
				CairngormEventDispatcher.getInstance().dispatchEvent( event );
			}
		}
		
		private static function getFirstWord( str : String ) : String {
			var index : int = str.indexOf( "?" );
			if ( index != -1 ) {
				return str.substring( 0, index );
			} else {
				return null;
			}
		}
		
		public static function getSections( str : String ) : Array {
			var sections : Array = new Array();
			
			var questionMarkIndex : int = str.indexOf( "?" );
			if ( questionMarkIndex != -1 ) {
				str = str.substring( 0, questionMarkIndex );
			}
			
			sections = str.split( "/" );
			if ( sections[ sections.length - 1 ] == "" ) {
				sections.splice( sections.length - 1 );
			}
			
			return sections;
		}
		
		private static function getParams() : Array {
			var params : Array = new Array();
			var names : Array = SWFAddress.getParameterNames();
			for each ( var name : String in names ) {
				params[ name ] = SWFAddress.getParameter( name );
			}
			return params;
		}
		
	}
	
}