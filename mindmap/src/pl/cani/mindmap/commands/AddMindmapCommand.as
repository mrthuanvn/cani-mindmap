package pl.cani.mindmap.commands {
	
	import com.adobe.cairngorm.commands.SequenceCommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.mikenimer.components.Debug;
	
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	
	import pl.cani.mindmap.business.MindmapServiceDelegate;
	import pl.cani.mindmap.events.MindmapEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;

	public class AddMindmapCommand extends SequenceCommand implements IResponder {
		
		override public function execute( event : CairngormEvent ) : void {
			var mindmapEvent : MindmapEvent = event as MindmapEvent;
			
			var delegate : MindmapServiceDelegate = new MindmapServiceDelegate( this );
			
			delegate.addMindmap( mindmapEvent.mindmap );
			
			var nextMindmapEvent : MindmapEvent 
				= new MindmapEvent( MindmapEvent.GET_BY_OWNER_ID_REFRESHED );
			nextMindmapEvent.ownerId = mindmapEvent.mindmap.owner.id;
			
			nextEvent = nextMindmapEvent;
		}
		
		public function result( data : Object ) : void {
			var mindmapId : uint = data.result as uint;

			var event : MindmapEvent = new MindmapEvent( MindmapEvent.ADDED );
			CairngormEventDispatcher.getInstance().dispatchEvent( event );

			executeNextCommand();
		}
		
		public function fault( info : Object ) : void {
			Debug.show( info.fault );
		}
		
	}
}