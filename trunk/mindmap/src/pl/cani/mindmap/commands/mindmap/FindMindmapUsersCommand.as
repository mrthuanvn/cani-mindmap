package pl.cani.mindmap.commands.mindmap {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.mikenimer.components.Debug;
	
	import mx.rpc.IResponder;
	
	import pl.cani.mindmap.business.MindmapServiceDelegate;
	import pl.cani.mindmap.events.MindmapEvent;
	import pl.cani.mindmap.model.MindmapUserPair;
	import pl.cani.mindmap.vo.MindmapVO;

	public class FindMindmapUsersCommand implements ICommand, IResponder {
		
		private var mindmap : MindmapVO;
		
		public function execute( event : CairngormEvent ) : void {
			var mindmapEvent : MindmapEvent = event as MindmapEvent;
			
			var delegate : MindmapServiceDelegate = new MindmapServiceDelegate( this );
			
			mindmap = mindmapEvent.mindmap;	
			delegate.findMindmapUsers( mindmapEvent.mindmap );
		}
		
		public function result( data : Object ) : void {
			var event : MindmapEvent 
				= new MindmapEvent( MindmapEvent.MINDMAP_USERS_FOUND );

			var mindmapUserPairs : Array = data.result;
			mindmapUserPairs.forEach( fillPair );

			event.mindmapUserPairs = mindmapUserPairs;
			
			CairngormEventDispatcher.getInstance().dispatchEvent( event );
		}
		
		private function fillPair( item : *, index : int, array : Array ) : void {
			var pair : MindmapUserPair = item;
			pair.mindmap = mindmap;
		} 
		
		public function fault( info : Object ) : void {
			Debug.show( info.fault );
		}
		
	}
}