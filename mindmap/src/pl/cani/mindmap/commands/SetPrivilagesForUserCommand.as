package pl.cani.mindmap.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.mikenimer.components.Debug;
	
	import mx.rpc.IResponder;
	
	import pl.cani.mindmap.business.MindmapServiceDelegate;
	import pl.cani.mindmap.events.MindmapEvent;

	public class SetPrivilagesForUserCommand implements ICommand, IResponder {
		
		public function execute( event : CairngormEvent ) : void {
			var mindmapEvent : MindmapEvent = event as MindmapEvent;
			
			var delegate : MindmapServiceDelegate = new MindmapServiceDelegate( this );
			delegate.setPrivilagesForUser( mindmapEvent.mindmap, mindmapEvent.user,
				mindmapEvent.privilages );
		}
		
		public function result( data : Object ) : void {
			
		}
		
		public function fault( info : Object ) : void {
			Debug.show( info.fault );
		}
		
	}
}