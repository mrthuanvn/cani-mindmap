package pl.cani.mindmap.business {
    
    import pl.cani.mindmap.vo.UserVO;
    import flash.net.SharedObject;
    
    public class SessionAndPersitentData {
        
        private static var instance : SessionAndPersitentData = null;
        
        public static const SHARED_OBJECT_NAME : String = "mindmap";

        private var loggedInUser : UserVO;
        private var sharedObject : SharedObject;
        
        
        public function SessionAndPersitentData() {
            sharedObject = SharedObject.getLocal( SHARED_OBJECT_NAME );
            loggedInUser = sharedObject.data.user;
        }
        
        public static function getInstance() : SessionAndPersitentData {
            if ( instance == null ) {
                instance = new SessionAndPersitentData();
            }
            return instance;
        }
        
        public function setLoggedInUser( user : UserVO, persist : Boolean ) : void {
            loggedInUser = user;
            setRememberUser( persist );
        }
        
        public function getLoggedInUser() : UserVO {
            return loggedInUser;
        }
        
        public function setRememberUser( remember : Boolean ) : void {
            if ( remember ) {
                sharedObject.data.user = loggedInUser;
            } else {
            	if ( sharedObject.data != null ) {
                	delete sharedObject.data.user;
             	}
            }
            sharedObject.flush();
        }
        
        public function logoutUser() : void {
        	loggedInUser = null;
        	setRememberUser( false );
        }
        
    }
    
}