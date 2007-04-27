package pl.cani.mindmap.model {

	import pl.cani.mindmap.vo.MindmapVO;
	import pl.cani.mindmap.vo.UserVO;
	
	[RemoteClass( alias = "pl.cani.mindmap.model.MindmapUserPair" )]
	public class MindmapUserPair {
		
		public var mindmap : MindmapVO;
		public var user : UserVO;

		private var _privilages : uint;
		private var _read : Boolean;
		private var _write : Boolean;
		
		public function MindmapUserPair( mindmap : MindmapVO = null,
				user : UserVO = null, privilages : uint = 0 ) {
		
			this.mindmap = mindmap;
			this.user = user;
			this.privilages = privilages;			
		}
		
		public function get canRead() : Boolean {
			return _read;
		}
		
		public function set canRead( value : Boolean ) : void {
			privilages = value == false
				? MindmapPrivilages.NONE
				: MindmapPrivilages.READ;
		}
		
		public function get canWrite() : Boolean {
			return _write;
		}
		
		public function set canWrite( value : Boolean ) : void {
			privilages = value == true
				? MindmapPrivilages.READ_WRITE
				: MindmapPrivilages.READ;
		}
		
		public function get privilages() : uint {
			return _privilages;
		}
		
		public function set privilages( value : uint ) : void {
			if ( value == MindmapPrivilages.READ ) {
				_read = true;
				_write = false;
			} else if ( value == MindmapPrivilages.READ_WRITE ) {
				_read = true;
				_write = true;
			} else if ( value == MindmapPrivilages.NONE ) {
				_read = false;
				_write = false;
			} else {
				throw new Error( "Value out of range" );
			}
			_privilages = value;
		}
		
	}
}