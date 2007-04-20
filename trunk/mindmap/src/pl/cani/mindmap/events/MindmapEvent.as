package pl.cani.mindmap.events {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import pl.cani.mindmap.vo.MindmapVO;

	public class MindmapEvent extends CairngormEvent {
		
		public static const ADD : String = "add";
		public static const GET_BY_OWNER_ID : String= "getByOwnerId";
		public static const GET_BY_OWNER_ID_REFRESHED : String = "getByOwnerIdRefreshed";
		
		public var mindmap : MindmapVO;
		public var ownerId : uint;
		
		public function MindmapEvent( type : String, mindmap : MindmapVO = null, 
				ownerId : uint = 0 ) {
			super( type );
			this.mindmap = mindmap;
			this.ownerId = ownerId;
		}
		
	}
}