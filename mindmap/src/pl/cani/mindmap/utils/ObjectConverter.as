package pl.cani.mindmap.utils {
	
	import pl.cani.mindmap.model.MindmapPrivilages;
	import pl.cani.mindmap.model.MindmapUserPair;
	import pl.cani.mindmap.vo.UserVO;
	import pl.cani.mindmap.model.AppModelLocator;
	import pl.cani.mindmap.vo.MindmapVO;
	
	public class ObjectConverter {
		
		public static function convertUserVOtoMindmapUserPair( user : UserVO )
				: MindmapUserPair {
		
			var mindmap : MindmapVO 
				= AppModelLocator.getInstance().selectedMindmap;
		
			return new MindmapUserPair( mindmap, user, MindmapPrivilages.READ );
		}
		
	}
	
}