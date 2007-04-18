package pl.cani.mindmap.business {

	import com.adobe.cairngorm.business.ServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;
	
	import pl.cani.mindmap.vo.MindmapVO;
	
	public class MindmapServiceDelegate	{
		
		private var responder : IResponder;
		private var service : RemoteObject;

		public function MindmapServiceDelegate( responder : IResponder ) {
			service = ServiceLocator.getInstance().getRemoteObject(
				"mindmapService" );
			this.responder = responder;
		}
		
		public function addMindmap( mindmap : MindmapVO ) : void {
			var token : AsyncToken = service.addMindmap( mindmap );
			token.resultHandler = responder.result;
			token.faultHandler = responder.fault;
		}
		
		public function getMindmapsByOwnerId( ownerId : uint ) : void {
			var token : AsyncToken = service.getMindmapsByOwnerId( ownerId );
			token.addResponder( responder );
		}
		
	}
}