package pl.cani.mindmap.business.exceptions {

	[RemoteClass( alias = "pl.cani.mindmap.business.exceptions.UserNotActivatedException" )]
	public class UserNotActivatedException {
		
		public var email : String;
		public var activationKey : String;
		
	}
	
}