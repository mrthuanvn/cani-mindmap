package pl.cani.mindmap.validators {
	
	public class EmailPasswordPair {
	
		public var email : String;
		public var password : String;
		
		public function EmailPasswordPair( email : String = null, 
				password : String = null ) {
					
			this.email = email;
			this.password = password;
		}
		
	}
	
}