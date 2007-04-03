package pl.cani.mindmap.business {
	
	import com.adobe.crypto.MD5;
	
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import mx.events.ResizeEvent;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	import pl.cani.mindmap.business.exceptions.UserDoesntExistException;
	import pl.cani.mindmap.business.exceptions.UserNotActivatedException;
	import pl.cani.mindmap.business.exceptions.WrongPasswordException;
	import pl.cani.mindmap.vo.UserVO;

	public class LoginServiceTest extends TestCase 
	{
		
		private const DESTINATION : String = "mindmapLoginServiceDestination";
		private const TIMEOUT : Number = 5000;
		
		public function LoginServiceTest(methodName:String=null)
		{
			super(methodName);
		}
		
		public static function suite() : TestSuite {
			var ts : TestSuite = new TestSuite();
   			
   			ts.addTest( new LoginServiceTest( "testLoginUser" ) );
  			ts.addTest( new LoginServiceTest( "testWrongEmail" ) );
  			ts.addTest( new LoginServiceTest( "testWrongPassword" ) );
  			ts.addTest( new LoginServiceTest( "testNotActive" ) );

   			return ts;
		}
		
		public function testLoginUser() : void {
			var email : String = "test@test.pl";
			var password : String = MD5.hash( "testpass" );
			
			var service : RemoteObject = new RemoteObject( DESTINATION );
			service.loginUser.addEventListener( ResultEvent.RESULT, 
				addAsync( onLoginResult, TIMEOUT ) );
			
			service.loginUser( email, password );
		}
		
		public function onLoginResult( result : ResultEvent ) : void {
			assertTrue( result.result is UserVO );
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