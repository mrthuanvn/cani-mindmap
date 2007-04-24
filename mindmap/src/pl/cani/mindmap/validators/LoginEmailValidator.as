package pl.cani.mindmap.validators {
	
	import mx.validators.EmailValidator;
	import flexunit.utils.ArrayList;
	import mx.resources.ResourceBundle;
	import mx.validators.ValidationResult;

	public class LoginEmailValidator extends EmailValidator	{
		
		[ResourceBundle( name = "LoginEmailValidator" )]
		private var rb : ResourceBundle;
		
		private var notRegisteredEmails : ArrayList = new ArrayList();
		private var notActivatedEmails : ArrayList = new ArrayList();//Array = new Array(); // [ email, activationKey ]
		
		
		override protected function doValidation( value : Object ) : Array {
			var results : Array = super.doValidation( value );
			
			if ( results.length > 0 ) {
				return results;
			}
			
			var valueEmail : String = value as String;

			for ( var i : int = 0; i < notRegisteredEmails.length(); i++ ) {
				var email : String = notRegisteredEmails.getItemAt( i ) as String;
				if ( email == valueEmail ) {
					var errorMessage : String = rb.getString( "notRegistered" );
					var result : ValidationResult 
						= new ValidationResult( true, null, null, errorMessage );
					results.push( result );
					return results;
				}
			}
			
/* 			for ( i = 0; i < notActivatedEmails.length(); i++ ) {
				email = notActivatedEmails.getItemAt( i ) as String;
				if ( email == valueEmail ) {
					errorMessage = rb.getString( "notActivated" );
					result  
						= new ValidationResult( true, null, null, errorMessage );
					results.push( result );
					return results;
				}
			} */
			
			return results;
		}
	
		public function addNotRegisteredEmail( email : String ) : void {
			notRegisteredEmails.addItem( email );
		}
		
		public function removeNotRegisteredEmail( email : String ) : void {
			if ( notRegisteredEmails.contains( email ) ) {
				notRegisteredEmails.removeItem( email );
			}
		}
		
		public function addNotActivatedEmail( email : String ) : void {
			notActivatedEmails.addItem( email );
		}
		
	}

}