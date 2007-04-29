package pl.cani.mindmap.utils {
	
	import as3.util.Comparator;
	
	import pl.cani.mindmap.model.MindmapUserPair;

	public class MindmapUserPairComparator implements Comparator {
		
		public function equals( obj : Object ) : Boolean {
			return obj == this;
		}
		
		public function compare( obj1 : Object, obj2 : Object ) : int {
			var pair1 : MindmapUserPair = obj1 as MindmapUserPair;
			var pair2 : MindmapUserPair = obj2 as MindmapUserPair;
			
			var areMindmapsEqual : Boolean;
			if ( pair1.mindmap == null ) {
				areMindmapsEqual = pair2.mindmap == null;
			} else {
				areMindmapsEqual = pair1.mindmap.equals( pair2.mindmap );
			} 
			
			var areUsersEqual : Boolean;
			if ( pair1.user == null ) {
				areUsersEqual = pair2.user == null;
			} else {
				areUsersEqual = pair1.user.equals( pair2.user );
			} 
			
			var arePrivilagesEqual : Boolean 
				= pair1.privilages == pair2.privilages;
			
			if ( areUsersEqual ) {
				return 0;
			}
			return 1;
		}
		
	}
}