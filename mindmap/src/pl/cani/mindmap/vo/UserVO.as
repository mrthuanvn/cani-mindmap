package pl.cani.mindmap.vo {
	
	import com.adobe.cairngorm.vo.IValueObject;
	
	import flash.net.registerClassAlias;
	
	[Bindable]
	[RemoteClass( alias = "pl.cani.mindmap.vo.UserVO" )]
	public class UserVO implements IValueObject {
		
		public var id : uint;

		public var email : String;
		public var password : String;

		public var forname : String;
		public var surname : String;

		public var isActive : Boolean;
		public var activationKey : String;
		
		public function UserVO( forname : String = null, surname : String = null,
				email : String = null ) {

			registerClassAlias( "pl.cani.mindmap.vo.UserVO", UserVO );

			this.forname = forname;
			this.surname = surname;
			this.email = email;
		}
		
		public function toString() : String {
			return forname + " " + surname + ", " + email;
		}
		
		public function equals( user : UserVO ) : Boolean {
			return user.id == id
					&& user.forname == forname
					&& user.surname == surname
					&& user.email == email
					&& user.password == password
					&& user.isActive == isActive
					&& user.activationKey == activationKey;
		}
		
	}
	
}