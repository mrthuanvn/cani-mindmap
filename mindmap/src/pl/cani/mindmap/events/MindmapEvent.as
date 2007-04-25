package pl.cani.mindmap.events {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import pl.cani.mindmap.vo.MindmapVO;
	import pl.cani.mindmap.vo.UserVO;

	public class MindmapEvent extends CairngormEvent {
		
		public static const ADD : String = "add";
		public static const ADDED : String = "mindmapAdded";
		public static const GET_BY_OWNER_ID : String= "getByOwnerId";
		public static const GET_BY_OWNER_ID_REFRESHED : String = "getByOwnerIdRefreshed";
		public static const SET_PRIVILAGES_FOR_USER : String = "setPrivilagesForUser";
		
		public var mindmap : MindmapVO;
		public var ownerId : uint;
		public var user : UserVO;
		public var privilages : uint;
		
		public function MindmapEvent( type : String, mindmap : MindmapVO = null, 
				ownerId : uint = 0 ) {
			super( type );
			this.mindmap = mindmap;
			this.ownerId = ownerId;
		}
		
	}
}