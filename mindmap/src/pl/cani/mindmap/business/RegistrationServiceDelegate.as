package pl.cani.mindmap.business {

	import com.adobe.cairngorm.business.ServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;
	
	import pl.cani.mindmap.vo.UserVO;
	
	public class RegistrationServiceDelegate {
		
		private var responder : IResponder;
		private var service : RemoteObject;
		
		public function RegistrationServiceDelegate( responder : IResponder ) {
			service = ServiceLocator.getInstance().getRemoteObject(
				"registrationService" );
			this.responder = responder;
		}
		
		public function registerUser( user : UserVO ) : void {
			var token : AsyncToken = service.registerUser( user );
			token.resultHandler = responder.result;
			token.faultHandler = responder.fault;
		}
		
		public function activateUser( activationKey : String ) : void {
			var token : AsyncToken = service.activateUser( activationKey );
			token.resultHandler = responder.result;
			token.faultHandler = responder.fault;
		}
		
	}
}