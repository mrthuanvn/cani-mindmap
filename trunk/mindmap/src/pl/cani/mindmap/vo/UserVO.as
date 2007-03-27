package pl.cani.mindmap.vo {
	
	import com.adobe.cairngorm.vo.IValueObject;
	
	import flash.net.registerClassAlias;
	
	import mx.core.IUID;
	
	[Bindable]
	[RemoteClass( alias = "pl.cani.mindmap.vo.UserVO" )]
	public class UserVO implements IValueObject, IUID	{
		
		public var id : uint;

		public var email : String;
		public var password : String;

		public var forname : String;
		public var surname : String;

		public var isActive : Boolean;
		public var activationKey : String;
		
		public function UserVO() {
			registerClassAlias( "pl.cani.mindmap.vo.UserVO", UserVO );
		}
		
		public function toString() : String {
			return forname + " " + surname + ", " + email;
		}
		
		public function get uid() : String {
			return String(id);
		}
		
		public function set uid( value : String ) : void {
			id = int(value);
		}
		
	}
	
}