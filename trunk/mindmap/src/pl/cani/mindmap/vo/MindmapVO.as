package pl.cani.mindmap.vo {
	
	import com.adobe.cairngorm.vo.ValueObject;
	import flash.net.registerClassAlias;
	import flash.net.getClassByAlias;

	[RemoteClass( alias = "pl.cani.mindmap.vo.MindmapVO" )]
	public class MindmapVO implements ValueObject {
		
		public var id : uint;
		public var name : String;
		
		public var owner : UserVO;
		
		public var requiresPassword : Boolean;
		
		/**
		 * md5 hashed password 
		 */
		public var password : String;
		
		public function MindmapVO() {
			if ( getClassByAlias( "pl.cani.mindmap.vo.MindmapVO" ) != MindmapVO ) {
				registerClassAlias( "pl.cani.mindmap.vo.MindmapVO", MindmapVO );
			}
		}
		
		public function toString() : String {
			return name;
		}
		
	}
	
}