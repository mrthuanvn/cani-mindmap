package pl.cani.mindmap.business.exceptions {

	import pl.cani.mindmap.vo.UserVO;
	
	[RemoteClass( alias = "pl.cani.mindmap.business.exceptions.UserAlreadyExistsException" )]
	public class UserAlreadyExistsException {
		
		public var user : UserVO;
		public var message : String;
		
		public function UserAlreadyExistsException( message : String = "", 
				user : UserVO = null ) {

			this.message = message;
			this.user = user;
		}
		
	}
	
}