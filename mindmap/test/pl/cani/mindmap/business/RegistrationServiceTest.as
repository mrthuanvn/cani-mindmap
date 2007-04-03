package pl.cani.mindmap.business {
	
	import flash.events.Event;
	
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	import pl.cani.mindmap.vo.UserVO;
	import pl.cani.mindmap.business.exceptions.UserAlreadyExistsException;
 	
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
   			ts.addTest( new RegistrationServiceTest( "testUserExists" ) );
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
   			assertTrue( typeof( result.result ) + ": " + result.result, 
   				result.result is int );
   		}
   		
   		public function testUserExists() : void {
  			var user : UserVO = new UserVO();
  			user.email = "van_jan@o2.pl";
  			
			var remoteObject : RemoteObject = new RemoteObject( DESTINATION );
			remoteObject.registerUser.addEventListener( ResultEvent.RESULT, 
				addAsync( onUserExistsResult, TIMEOUT ) );
			remoteObject.addEventListener( FaultEvent.FAULT, onFault );
			remoteObject.registerUser( user );
   		}
   		
   		public function onUserExistsResult( result : ResultEvent ) : void {
   			assertTrue( typeof( result.result ) + ": " + result.result, 
   				result.result is UserAlreadyExistsException );
   		}
   		
   		public function onFault( fault : FaultEvent ) : void {
   			fail( fault.fault.message );
   		}
  		
  	}
}