package pl.cani.mindmap.business {

	import com.adobe.cairngorm.business.ServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;
	
	public class UserServiceDelegate {
		
		private var service : RemoteObject;
		private var responder : IResponder;
		
		public function UserServiceDelegate( responder : IResponder ) {
			this.responder = responder;
			service = ServiceLocator.getInstance().getRemoteObject( "userService" );
		}
		
		public function findUsers( queryString : String ) : void {
			var token : AsyncToken = service.findUsers( queryString );
			token.addResponder( responder );
		}
		
	}
	
}