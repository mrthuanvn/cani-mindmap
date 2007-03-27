package pl.cani.mindmap.events {

	import com.adobe.cairngorm.control.CairngormEvent;
	
	import pl.cani.mindmap.control.Controller;
	import pl.cani.mindmap.view.helpers.ViewNames;
	
	
	public class EventFactory {
		
		public static function createEvent( sections : Array, params : Array ) 
				: CairngormEvent {
			
			if ( sections.length > 0 ) {
				var section : String = sections[ 0 ];
				
				switch ( section ) {
					
				case ViewNames.LOGIN_FORM:
					return new ViewEvent( section );
					
				case ViewNames.REGISTRATION_FORM:
					return new ViewEvent( section );
					
				case Controller.ACTIVATION:
					var activationKey : String = params[ "activationKey" ];
					return new ActivationEvent( activationKey );
					
				}
			}
			
			return null;
		}
		
	}
	
}