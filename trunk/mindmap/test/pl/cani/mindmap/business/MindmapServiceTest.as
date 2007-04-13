package pl.cani.mindmap.business {
	
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	import pl.cani.mindmap.vo.MindmapVO;
	import com.adobe.crypto.MD5;
	import pl.cani.mindmap.vo.UserVO;
	import mx.rpc.remoting.RemoteObject;
	import mx.rpc.events.FaultEvent;
	import com.mikenimer.components.Debug;
	import mx.rpc.events.ResultEvent;

	public class MindmapServiceTest extends TestCase {
		
		private const DESTINATION : String = "mindmapMindmapServiceDestination";
		private const TIMEOUT : Number = 5000;
		
		private var service : RemoteObject;
		
		public function MindmapServiceTest( methodName : String = null ) {
			super( methodName );
		}
		
		public static function suite() : TestSuite {
			var ts : TestSuite = new TestSuite();
   			
			ts.addTest( new MindmapServiceTest( "testAddMindmap" ) );

   			return ts;
		}
				
		override public function setUp() : void {
			service = new RemoteObject( DESTINATION );
			service.addEventListener( FaultEvent.FAULT, onFault );
		}
		
		public function testAddMindmap() : void {
			var mindmap : MindmapVO = new MindmapVO();
			mindmap.name = "test mindmap from flex";
			mindmap.requiresPassword = true;
			mindmap.password = MD5.hash( "pass" );
			var owner : UserVO = new UserVO();
			owner.id = 1;
			mindmap.owner = owner;
			
			service.addMindmap.addEventListener( ResultEvent.RESULT, 
				addAsync( onAddMindmapResult, TIMEOUT ) );
			
			service.addMindmap( mindmap );
		}
		
		private function onAddMindmapResult( result : ResultEvent ) : void {
//			var mindmapId : uint = result.result as uint;
			assertTrue( result.result is uint );
		}
		
		private function onFault( fault : FaultEvent ) : void {
			Debug.show( fault.fault );
			fail();
		}
		
	}
}