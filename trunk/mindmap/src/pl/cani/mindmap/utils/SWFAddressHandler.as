package pl.cani.mindmap.utils {

	import com.asual.swfaddress.SWFAddress;
	
	import mx.controls.Alert;
	import pl.cani.mindmap.view.helpers.ViewNames;
	import pl.cani.mindmap.events.RegistrationEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import pl.cani.mindmap.events.ActivationEvent;
	import com.adobe.cairngorm.control.CairngormEvent;
	import pl.cani.mindmap.events.EventFactory;
	
	
	public class SWFAddressHandler {
		
		public static function handle() : void {
			var value : String = SWFAddress.getValue();
//			Alert.show( value );
			
			var sections : Array = getSections( value );
			var params : Array = getParams();
			
			var event : CairngormEvent = EventFactory.createEvent( sections, params );
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