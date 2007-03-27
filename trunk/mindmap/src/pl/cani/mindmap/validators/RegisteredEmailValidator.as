package pl.cani.mindmap.validators {
	
	import flexunit.utils.ArrayList;
	import mx.validators.ValidationResult;
	import mx.validators.EmailValidator;
	import mx.resources.ResourceBundle;

	public class RegisteredEmailValidator extends EmailValidator	{
		
		public var registeredEmails : ArrayList = new ArrayList();
		
		[ResourceBundle( name = "RegisteredEmailValidator" )]
		private var rb : ResourceBundle;
		
		override protected function doValidation( value : Object ) : Array {
			trace( value );
			var results : Array = super.doValidation( value );
			if ( results.length > 0 ) {
				return results;
			}
			
			var valueEmail : String = value as String;
			for ( var i : int = 0; i < registeredEmails.length(); i++ ) {
				var email : String = registeredEmails.getItemAt( i ) as String;
				if ( valueEmail == email ) {
					var result : ValidationResult = new ValidationResult( true, 
						null, "", "E-mail " + email + " " + rb.getString( "exists" ) );
					results.push( result );
					break;
				}
			}

			return results;
		}
		
		public function addRegisteredEmail( email : String ) : void {
			registeredEmails.addItem( email );
		}
		
		public function getRegisteredEmails() : ArrayList {
			return registeredEmails;
		}
		
	}
	
}