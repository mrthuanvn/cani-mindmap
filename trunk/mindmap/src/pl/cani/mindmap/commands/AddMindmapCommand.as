package pl.cani.mindmap.commands {
	
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.mikenimer.components.Debug;
	
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	
	import pl.cani.mindmap.business.MindmapServiceDelegate;
	import pl.cani.mindmap.events.MindmapEvent;

	public class AddMindmapCommand implements ICommand, IResponder {
		
		public function execute( event : CairngormEvent ) : void {
			var mindmapEvent : MindmapEvent = event as MindmapEvent;
			
			var delegate : MindmapServiceDelegate = new MindmapServiceDelegate( this );
			
			delegate.addMindmap( mindmapEvent.mindmap );
		}
		
		public function result( data : Object ) : void {
			var mindmapId : uint = data.result as uint;
			Alert.show( "added mindmap id " + mindmapId );
		}
		
		public function fault( info : Object ) : void {
			Debug.show( info.fault );
		}
		
	}
}