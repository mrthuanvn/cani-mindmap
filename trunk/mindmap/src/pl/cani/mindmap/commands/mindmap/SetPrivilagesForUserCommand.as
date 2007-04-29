package pl.cani.mindmap.commands.mindmap {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.mikenimer.components.Debug;
	
	import mx.rpc.IResponder;
	
	import pl.cani.mindmap.business.MindmapServiceDelegate;
	import pl.cani.mindmap.events.MindmapEvent;
	import pl.cani.mindmap.model.MindmapUserPair;

	public class SetPrivilagesForUserCommand implements ICommand, IResponder {
		
		public function execute( event : CairngormEvent ) : void {
			var mindmapEvent : MindmapEvent = event as MindmapEvent;
			var pair : MindmapUserPair = mindmapEvent.mindmapUserPair;
			
			var delegate : MindmapServiceDelegate = new MindmapServiceDelegate( this );
			delegate.setPrivilagesForUser( pair.mindmap, pair.user,	pair.privilages );
		}
		
		public function result( data : Object ) : void {
			// do nothing
		}
		
		public function fault( info : Object ) : void {
			Debug.show( info.fault );
		}
		
	}
}