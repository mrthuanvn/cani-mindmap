package pl.cani.mindmap.validators {

	import com.adobe.crypto.MD5;
	
	import flexunit.utils.CollectionIterator;
	
	import mx.controls.treeClasses.ITreeDataDescriptor;
	import mx.resources.ResourceBundle;
	import mx.validators.StringValidator;
	import mx.validators.ValidationResult;
	
	import pl.cani.collections.ArrayList;
	import pl.cani.utils.ArrayListUtils;

	public class PasswordValidator extends StringValidator {
		
		[Inspectable]
		public var passwordToMatch : String;
		
		[Inspectable]
		public var email : String;
		
		[ ResourceBundle( name = "PasswordValidator" ) ]
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

			results = doCustomValidation( value as String );
			
			return results;
		}
		
		public function addWrongPassword( emailPasswordPair : EmailPasswordPair ) : void {
			wrongPasswords.addItem( emailPasswordPair );
		}
		
		internal function doCustomValidation( value : String ) : Array {
			var results : Array = new Array();
			
			var enteredPassword : String = value;

			if ( passwordToMatch != null ) {
				if ( enteredPassword != passwordToMatch ) {
					var result : ValidationResult = new ValidationResult( true, null,
						"passwordDoesntMatch", rb.getString( "passwordDoesntMatch" ) );
					results.push( result );
	
					return results;
				}
			} else {
				trace( "PasswordValidator::doCustomValidation" );
				var emailPasswordPairs : ArrayList 
					= ArrayListUtils.getByKey( wrongPasswords, "email", email );
				trace( "emailPasswordPairs.length: " + emailPasswordPairs.length() );
				var iterator : CollectionIterator 
					= new CollectionIterator( emailPasswordPairs );

				while ( iterator.hasNext() ) {
					var emailPasswordPair : EmailPasswordPair 
						= iterator.next() as EmailPasswordPair;

					var wrongPassword : String = emailPasswordPair.password;
					var hashedEnteredPassword : String
						= MD5.hash( enteredPassword );

					trace( "wrong password: " + wrongPassword );
					trace( "hashed entered password: " + hashedEnteredPassword );

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
		
	}
}