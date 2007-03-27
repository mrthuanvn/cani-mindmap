package pl.cani.mindmap.business
{
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
  		
  	    public function RegistrationServiceTest( methodName : String ) {
   			super( methodName );
        }
  	
  		public static function suite() : TestSuite {
   			var ts : TestSuite = new TestSuite();
   			
   			ts.addTest( new RegistrationServiceTest( "testRegisterUser" ) );

   			return ts;
   		}
  		
  		public function testRegisterUser() : void {
  			var user : UserVO = new UserVO();
  			user.forname = "test";
  			user.surname = "user";
  			user.email = "test@test.pl";
  			user.password = "testpass";
  			user.isActive = false;
  			user.activationKey = "activationKey";
  			
			var remoteObject : RemoteObject = new RemoteObject( DESTINATION );
			remoteObject.addEventListener( "result", onResult );
			remoteObject.addEventListener( "fault", onFault );
			remoteObject.registerUser( user );
			
//			fail();
   		}
   		
   		private function onResult( event : Event ) : void {
   			assertTrue( event is ResultEvent );
   			var resultEvent : ResultEvent = event as ResultEvent;
   			trace( resultEvent.result );
   		}
   		
   		private function onFault( event : Event ) : void {
   			fail( ( event as FaultEvent ).fault.message );
   		}
  		
  	}
}