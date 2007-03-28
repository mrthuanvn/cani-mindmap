package pl.cani.mindmap.business {
	
	import flexunit.framework.TestCase;
 	import flexunit.framework.TestSuite;
 	import mx.rpc.remoting.RemoteObject;
 	import pl.cani.mindmap.vo.UserVO;
 	import flash.events.Event;
 	import mx.rpc.events.ResultEvent;
 	import mx.rpc.events.FaultEvent;
 	
 	public class RegistrationServiceTest extends TestCase {
  		
  		private static const DESTINATION : String 
  			= "mindmapRegistrationServiceDestination";
  		private static const TIMEOUT : Number = 5000;
  		
  	    public function RegistrationServiceTest( methodName : String ) {
   			super( methodName );
        }
  	
  		public static function suite() : TestSuite {
   			var ts : TestSuite = new TestSuite();
   			
   			ts.addTest( new RegistrationServiceTest( "testRegisterUser" ) );
   			ts.addTest( new RegistrationServiceTest( "testSayHello" ) );

   			return ts;
   		}
  		
  		public function testRegisterUser() : void {
  			var user : UserVO = new UserVO();
  			user.forname = "test";
  			user.surname = "user";
  			user.email = "test2@test.pl";
  			user.password = "testpass";
  			user.isActive = false;
  			user.activationKey = "activationKey";
  			
			var remoteObject : RemoteObject = new RemoteObject( DESTINATION );
			remoteObject.registerUser.addEventListener( ResultEvent.RESULT, 
				addAsync( onRegisterResult, TIMEOUT ) );
			remoteObject.addEventListener( FaultEvent.FAULT, onFault );
			remoteObject.registerUser( user );
   		}
   		
   		public function onRegisterResult( result : ResultEvent ) : void {
   			assertTrue( result.result is int );
//			assertEquals( result.result, "ok" );
   		}
   		
   		public function testSayHello() : void {
			var remoteObject : RemoteObject = new RemoteObject( DESTINATION );
			remoteObject.sayHello.addEventListener( ResultEvent.RESULT, 
				addAsync( onSayHelloResult, TIMEOUT ) );
			remoteObject.addEventListener( FaultEvent.FAULT, onFault );
   			remoteObject.sayHello();
   		}
   		
   		public function onSayHelloResult( result : ResultEvent ) : void {
   			assertEquals( result.result, "Hello world!" );
   		}
   		
   		public function onFault( fault : FaultEvent ) : void {
   			fail( fault.fault.message );
   		}
  		
  	}
}