package pl.cani.mindmap.commands.mindmap {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.mikenimer.components.Debug;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	
	import pl.cani.mindmap.business.MindmapServiceDelegate;
	import pl.cani.mindmap.events.MindmapEvent;
	import pl.cani.mindmap.model.AppModelLocator;

	public class GetMindmapsByOwnerIdCommand implements ICommand, IResponder {
		
		private static var cachedMindmaps : ArrayCollection = new ArrayCollection();
		
		public function execute( event : CairngormEvent ) : void {
			var mindmapEvent : MindmapEvent = event as MindmapEvent;
			
			if ( mindmapEvent.type == MindmapEvent.GET_BY_OWNER_ID 
				&& cachedMindmaps.length > 0 ) {
			
				var result : Object = { result: cachedMindmaps };
				result( result );

			} else {

				var delegate : MindmapServiceDelegate 
					= new MindmapServiceDelegate( this );
				
				delegate.getMindmapsByOwnerId( mindmapEvent.ownerId );
			}
		}
		
		public function result( data : Object ) : void {
			var mindmaps : Array = data.result;
			cachedMindmaps = new ArrayCollection( mindmaps );
			AppModelLocator.getInstance().myMindmaps = cachedMindmaps;
			
			var mindmapEvent : MindmapEvent = new MindmapEvent(
				MindmapEvent.MINDMAPS_FOUND );
			mindmapEvent.mindmaps = mindmaps;
			
			CairngormEventDispatcher.getInstance().dispatchEvent( mindmapEvent );
		}
		
		public function fault( info : Object ) : void {
			Debug.show( info.fault );
		}
		
	}
}