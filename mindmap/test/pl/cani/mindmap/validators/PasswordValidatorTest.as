package pl.cani.mindmap.validators {
	
	import com.adobe.crypto.MD5;
	
	import flexunit.framework.Assert;
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;

	public class PasswordValidatorTest extends TestCase	{
		
		private var validator : PasswordValidator;
		
		public function PasswordValidatorTest( methodName : String = null ) {
			super( methodName );
		}
		
		public static function suite() : TestSuite {
			var ts : TestSuite = new TestSuite();
			
			ts.addTest( new PasswordValidatorTest( "testDoCustomValidation" ) );
			
			return ts;
		}
		
		override public function setUp() : void {
			validator = new PasswordValidator();
		}
		
		public function testDoCustomValidation() : void {
			var toValidate : String = "testpass";
			var email : String = "test@test.pl";
			
			validator.email = email;
			
			var results : Array = validator.doCustomValidation( toValidate );
			assertEquals( 0, results.length );
			
			var emailPasswordPair : EmailPasswordPair 
				= new EmailPasswordPair( "test@test.pl", MD5.hash( toValidate ) );
			validator.addWrongPassword( emailPasswordPair );
			
			results = validator.doCustomValidation( toValidate );
			assertEquals( 1, results.length );
			
			validator.email = "different@one.pl";
			results = validator.doCustomValidation( toValidate );
			assertEquals( 0, results.length );
		}
		
	}
}