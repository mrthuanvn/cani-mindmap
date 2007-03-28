package pl.cani.test.business {
	
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	import pl.cani.mindmap.business.LoginServiceDelegate;
	import mx.events.ResizeEvent;
	import pl.cani.mindmap.business.exceptions.UserDoesntExistException;
	import pl.cani.mindmap.business.exceptions.WrongPasswordException;
	import pl.cani.mindmap.business.exceptions.UserNotActivatedException;

	public class LoginServiceDelegateTest extends TestCase 
	{
		
		private const DESTINATION : String = "mindmapLoginServiceDestination";
		private const TIMEOUT : Number = 5000;
		
		public function LoginServiceDelegateTest(methodName:String=null)
		{
			super(methodName);
		}
		
		public static function suite() : TestSuite {
			var ts : TestSuite = new TestSuite();
   			
   			ts.addTest( new LoginServiceDelegateTest( "testLoginUser" ) );
  			ts.addTest( new LoginServiceDelegateTest( "testWrongEmail" ) );
  			ts.addTest( new LoginServiceDelegateTest( "testWrongPassword" ) );
  			ts.addTest( new LoginServiceDelegateTest( "testNotActive" ) );

   			return ts;
		}
		
		public function testLoginUser() : void {
			var email : String = "van_jan@o2.pl";
			var password : String = "avejuve";
			
			var service : RemoteObject = new RemoteObject( DESTINATION );
			service.loginUser.addEventListener( ResultEvent.RESULT, 
				addAsync( onLoginResult, TIMEOUT ) );
			
			service.loginUser( email, password );
		}
		
		public function onLoginResult( data : Object ) : void {
			assertTrue( "test login result", data is ResultEvent );
		}
		
		public function testWrongEmail() : void {
			var email : String = "wrong@o2.pl";
			var password : String = "pass";
			
			var service : RemoteObject = new RemoteObject( DESTINATION );
			service.loginUser.addEventListener( ResultEvent.RESULT, 
				addAsync( onWrongEmailResult, TIMEOUT ) );
			
			service.loginUser( email, password );
		}
		
		public function onWrongEmailResult( result : ResultEvent ) : void {
			assertTrue( result.result is UserDoesntExistException );
		}
		
		public function testWrongPassword() : void {
			var email : String = "test@test.pl";
			var password : String = "wrongpass";
			
			var service : RemoteObject = new RemoteObject( DESTINATION );
			service.loginUser.addEventListener( ResultEvent.RESULT, 
				addAsync( onWrongPasswordResult, TIMEOUT ) );
			
			service.loginUser( email, password );
		}
		
		public function onWrongPasswordResult( result : ResultEvent ) : void {
			assertTrue( result.result is WrongPasswordException );
		}
		
		public function testNotActive() : void {
			var email : String = "not@active.pl";
			var password : String = "wrongpass";
			
			var service : RemoteObject = new RemoteObject( DESTINATION );
			service.loginUser.addEventListener( ResultEvent.RESULT, 
				addAsync( onNotActiveResult, TIMEOUT ) );
			
			service.loginUser( email, password );
		}
		
		public function onNotActiveResult( result : ResultEvent ) : void {
			assertTrue( result.result is UserNotActivatedException );
		}
		
		public function onLoginFault( info : Object ) : void {
			fail( info.toString() );
		}
		
	}
}