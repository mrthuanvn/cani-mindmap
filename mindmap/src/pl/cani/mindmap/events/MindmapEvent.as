package pl.cani.mindmap.events {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import pl.cani.mindmap.model.MindmapUserPair;
	import pl.cani.mindmap.vo.MindmapVO;
	import pl.cani.mindmap.vo.UserVO;

	public class MindmapEvent extends CairngormEvent {
		
		public static const ADD : String = "add";
		public static const ADDED : String = "mindmapAdded";
		
		public static const GET_BY_OWNER_ID : String= "getByOwnerId";
		public static const GET_BY_OWNER_ID_REFRESHED : String = "getByOwnerIdRefreshed";
		public static const MINDMAPS_FOUND : String = "mindmapsFound";
		
		public static const SET_PRIVILAGES_FOR_USER : String = "setPrivilagesForUser";
		
		public static const FIND_MINDMAP_USERS : String = "findMindmapUsers";
		public static const MINDMAP_USERS_FOUND : String = "mindmapUsersFound";
		
		public static const UPDATE_MINDMAP_STRUCTURE : String = "updateMindmapStructure";
		public static const MINDMAP_STRUCTURE_UPDATED : String = "mindmapStructureUpdated";
		
		public static const GET_MINDMAP_STRUCTURE : String = "getMindmapStructure";
		public static const MINDMAP_STRUCTRE_RECEIVED : String = "mindmapStructureReceived";
		
		public var mindmap : MindmapVO;
		public var ownerId : uint;
		public var user : UserVO;
		public var privilages : uint;
		public var mindmapUserPairs : Array;
		public var mindmaps : Array;
		public var mindmapUserPair : MindmapUserPair;
		public var mindmapStructure : XML;
		
		public function MindmapEvent( type : String, mindmap : MindmapVO = null, 
				ownerId : uint = 0 ) {
			super( type );
			this.mindmap = mindmap;
			this.ownerId = ownerId;
		}
		
	}
}