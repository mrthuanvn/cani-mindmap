package pl.cani.mindmap.commands.mindmap {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.mikenimer.components.Debug;
	
	import mx.rpc.IResponder;
	import pl.cani.mindmap.events.MindmapEvent;
	import pl.cani.mindmap.business.MindmapServiceDelegate;
	import pl.cani.mindmap.model.AppModelLocator;

	public class GetMindmapStructureCommand implements ICommand, IResponder {
		
		public function execute( event : CairngormEvent ) : void {
			var mindmapEvent : MindmapEvent = event as MindmapEvent;
			var delegate : MindmapServiceDelegate 
				= new MindmapServiceDelegate( this );
			delegate.getMindmapStructure( mindmapEvent.mindmap.id );
		}
		
		public function result( data : Object ) : void {
//			var event : MindmapEvent = new MindmapEvent( 
//				MindmapEvent.MINDMAP_STRUCTRE_RECEIVED );
//			event.mindmapStructure = new XML( data.result );
//			event.dispatch();
			AppModelLocator.getInstance().mindmap.mindmapData 
				= new XML( data.result );
		}
		
		public function fault( info : Object ) : void {
			Debug.show( info.fault );
		}
		
	}
	
}