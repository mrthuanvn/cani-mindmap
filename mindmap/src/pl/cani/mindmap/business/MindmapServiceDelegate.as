package pl.cani.mindmap.business {

	import com.adobe.cairngorm.business.ServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;
	
	import pl.cani.mindmap.vo.MindmapVO;
	import pl.cani.mindmap.vo.UserVO;
	
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
			token.addResponder( responder );
		}
		
		public function getMindmapsByOwnerId( ownerId : uint ) : void {
			var token : AsyncToken = service.getMindmapsByOwnerId( ownerId );
			token.addResponder( responder );
		}
		
		public function setPrivilagesForUser( mindmap : MindmapVO, user : UserVO,
				privilages : uint ) : void {

			var token : AsyncToken = service.setPrivilagesForUser( mindmap,
				user, privilages );
			token.addResponder( responder );
		}
		
		public function findMindmapUsers( mindmap : MindmapVO ) : void {
			var token : AsyncToken = service.findMindmapUsers( mindmap );
			token.addResponder( responder );
		}
		
	}
}