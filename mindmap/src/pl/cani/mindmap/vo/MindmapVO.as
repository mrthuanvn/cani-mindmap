package pl.cani.mindmap.vo {
	
	import com.adobe.cairngorm.vo.ValueObject;
	
	import flash.net.getClassByAlias;
	import flash.net.registerClassAlias;

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
		
		public function MindmapVO( name : String = null ) {
			if ( getClassByAlias( "pl.cani.mindmap.vo.MindmapVO" ) != MindmapVO ) {
				registerClassAlias( "pl.cani.mindmap.vo.MindmapVO", MindmapVO );
			}
			this.name = name;
		}
		
		public function equals( mindmap : MindmapVO ) : Boolean {
			var areOwnersEqual : Boolean;
			if ( mindmap.owner == null ) {
				areOwnersEqual = owner == null;
			} else {
				areOwnersEqual = mindmap.owner.equals( owner );
			} 
			
			return mindmap.id == id
					&& mindmap.name == name
					&& areOwnersEqual
					&& mindmap.password == password
					&& mindmap.requiresPassword == requiresPassword;
		}
		
		public function toString() : String {
			return name;
		}
		
	}
	
}