package pl.cani.mindmap.view.helper {
	
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import pl.cani.mindmap.view.helpers.LoginRegistrationHelper;
	import pl.cani.mindmap.view.helpers.ViewNames;

	public class LoginRegistrationHelperTest extends TestCase {
		
		private var helper : LoginRegistrationHelper;
		
		public function LoginRegistrationHelperTest( methodName : String ) {
   			super( methodName );
        }
  	
  		public static function suite() : TestSuite {
   			var ts : TestSuite = new TestSuite();
   			
   			ts.addTest( new LoginRegistrationHelperTest( "testShowForm" ) );

   			return ts;
   		}

		override public function setUp() : void {
			helper = new LoginRegistrationHelper( null );
		}

		public function testShowForm() : void {
			var formName : String = ViewNames.REGISTRATION_FORM;
			var expected : int = 1;
			var actual : int = helper.showForm( formName );
			assertEquals( expected, actual );
		}
		
	}
	
}