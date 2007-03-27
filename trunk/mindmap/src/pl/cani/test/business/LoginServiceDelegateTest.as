package pl.cani.test.business {
	
	import flexunit.framework.TestCase;
	import pl.cani.mindmap.business.LoginServiceDelegate;
	import mx.rpc.IResponder;

	public class LoginServiceDelegateTest extends TestCase implements IResponder
	{
		public function LoginServiceDelegateTest(methodName:String=null)
		{
			super(methodName);
		}
		
		public static function suite() : LoginServiceDelegateTest {
			var ts : TestSuite = new TestSuite();
   			
   			ts.addTest( new LoginServiceDelegateTest( "testLoginUser" ) );

   			return ts;
		}
		
		public function testLoginUser() : void {
			var email : String = "van_jan@o2.pl";
			var password : String = "avejuve";
			
			var delegate : LoginServiceDelegate = new LoginServiceDelegate( this );
			delegate.loginUser( email, password );
		}
		
		public function result( data : Object ) : void {
			assertTrue( "test login result", data is ResultEvent );
		}
		
		public function fault( info : Object ) : void {
			fail( "dupa", info.toString() );
		}
		
	}
}