package pl.cani.mindmap.business {

	import com.adobe.cairngorm.business.ServiceLocator;
	
	import flash.events.Event;
	
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;
	
	
	public class LoginServiceDelegate {
		
		private var responder : IResponder;
		private var service : RemoteObject;
		
		public function LoginServiceDelegate( responder : IResponder ) {
			service = ServiceLocator.getInstance().getRemoteObject(
				"loginService" );
			this.responder = responder;
		}
		
		public function loginUser( email : String, password : String ) : void {
			var token : AsyncToken = service.loginUser( email, password );
			token.resultHandler = responder.result;
			token.faultHandler = responder.fault;
		}
		
	}
	
}