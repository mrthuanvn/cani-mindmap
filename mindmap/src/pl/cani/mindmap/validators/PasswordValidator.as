package pl.cani.mindmap.validators {

	import flexunit.utils.ArrayList;
	
	import mx.resources.ResourceBundle;
	import mx.validators.StringValidator;
	import mx.validators.ValidationResult;
	import com.adobe.crypto.MD5;

	public class PasswordValidator extends StringValidator {
		
		[Inspectable]
		public var passwordToMatch : String;
		
		[ResourceBundle( name = "PasswordValidator" )]
		private var rb : ResourceBundle;
		
		// passwords are MD5 hashed
		private var wrongPasswords : ArrayList = new ArrayList();
		
		public function PasswordValidator()	{
			super();
		}
		
		override protected function doValidation( value : Object ) : Array {
			var results : Array = super.doValidation( value );
			
			if ( results.length > 0 ) {
                return results;
   			}

			var enteredPassword : String = value as String;

			if ( passwordToMatch != null ) {
				if ( enteredPassword != passwordToMatch ) {
					var result : ValidationResult = new ValidationResult( true, null,
						"passwordDoesntMatch", rb.getString( "passwordDoesntMatch" ) );
					results.push( result );
	
					return results;
				}
			} else {
				for ( var i : uint = 0; i < wrongPasswords.length(); i++ ) {
					var wrongPassword : String 
						= wrongPasswords.getItemAt( i ) as String;
					var hashedEnteredPassword : String
						= MD5.hash( enteredPassword );
					if ( hashedEnteredPassword == wrongPassword ) {
						result = new ValidationResult( true, null,
							"wrongPassword", rb.getString( "wrongPassword" ) );
						results.push( result );
		
						return results;
					}
				}
			}
			
			return results;
		}
		
		public function addWrongPassword( wrongPassword : String ) : void {
			wrongPasswords.addItem( wrongPassword );
		}
		
	}
}