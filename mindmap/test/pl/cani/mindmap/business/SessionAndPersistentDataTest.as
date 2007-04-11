package pl.cani.mindmap.business {
	
	import flash.net.SharedObject;
	
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import pl.cani.mindmap.vo.UserVO;

	public class SessionAndPersistentDataTest extends TestCase {
	
		public function SessionAndPersistentDataTest( methodName : String ) {
   			super( methodName );
        }
  	
  		public static function suite() : TestSuite {
   			var ts : TestSuite = new TestSuite();
   			
   			ts.addTest( new SessionAndPersistentDataTest( "testSetLoggedInUser" ) );
   			ts.addTest( new SessionAndPersistentDataTest( "testSetRememberUser" ) );
   			
   			return ts;
   		}
   		
   		public function testSetLoggedInUser() : void {
   			var user : UserVO = new UserVO();
   			user.forname = "ziutek";
   			
			var data : SessionAndPersitentData = SessionAndPersitentData.getInstance();
			assertNotNull( data );
 			data.setLoggedInUser( user, true );
   			
   			var so : SharedObject = SharedObject.getLocal( 
   				SessionAndPersitentData.SHARED_OBJECT_NAME );
   				
   			var savedUser : UserVO = so.data.user as UserVO;
   			var sessionUser : UserVO 
   				= SessionAndPersitentData.getInstance().getLoggedInUser();
   			assertEquals( user.forname, savedUser.forname );
   			assertEquals( user.forname, sessionUser.forname );
   			
   			data.setLoggedInUser( user, false );
   			savedUser = so.data.user as UserVO;
   			sessionUser = SessionAndPersitentData.getInstance().getLoggedInUser();
   			assertNull( savedUser );
   			assertEquals( user.forname, sessionUser.forname );
    	}
    	
    	public function testSetRememberUser() : void {
    		var user : UserVO = new UserVO();
   			user.forname = "ziutek";
   			
   			var so : SharedObject = SharedObject.getLocal( 
   				SessionAndPersitentData.SHARED_OBJECT_NAME );
   				
   			so.data.user = user;
   			so.flush();
   			
   			SessionAndPersitentData.getInstance().setRememberUser( false );
   			
   			var savedUser : UserVO = so.data.user as UserVO;
   			assertNull( savedUser );   			
    	}
		
	}
	
}
