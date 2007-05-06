package pl.cani.mindmap.commands.mindmap {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.mikenimer.components.Debug;
	
	import mx.rpc.IResponder;
	import pl.cani.mindmap.events.MindmapEvent;
	import pl.cani.mindmap.business.MindmapServiceDelegate;

	public class UpdateMindmapStructureCommand implements ICommand, IResponder {
		
		public function execute( event : CairngormEvent ) : void {
			var mindmapEvent : MindmapEvent = event as MindmapEvent;
			var delegate : MindmapServiceDelegate 
				= new MindmapServiceDelegate( this );
			delegate.updateMindmapStructure( mindmapEvent.mindmap.id, 
				mindmapEvent.mindmapStructure.toString() );
		}
		
		public function result( data : Object ) : void {
			var event : MindmapEvent = new MindmapEvent( 
				MindmapEvent.MINDMAP_STRUCTURE_UPDATED );
			event.dispatch();
		}
		
		public function fault( info : Object ) : void {
			Debug.show( info.fault );
		}
		
	}
	
}