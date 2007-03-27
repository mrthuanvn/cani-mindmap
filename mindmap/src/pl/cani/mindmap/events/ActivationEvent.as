package pl.cani.mindmap.events {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import pl.cani.mindmap.control.Controller;

	public class ActivationEvent extends CairngormEvent	{
	
		public var activationKey : String;	
		
		public function ActivationEvent( activationKey : String ) {
			super( Controller.ACTIVATION );
			this.activationKey = activationKey;
		}
		
	}
	
}