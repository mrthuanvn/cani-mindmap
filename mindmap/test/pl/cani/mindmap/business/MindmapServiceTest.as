package pl.cani.mindmap.business {
	
	import com.adobe.crypto.MD5;
	import com.mikenimer.components.Debug;
	
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	import pl.cani.mindmap.vo.MindmapVO;
	import pl.cani.mindmap.vo.UserVO;
	import mx.logging.targets.MiniDebugTarget;

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
			ts.addTest( new MindmapServiceTest( "testGetMindmapsByOwnerId" ) );			

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
		
		public function testGetMindmapsByOwnerId() : void {
			var ownerId : uint = 1;

			service.addEventListener( ResultEvent.RESULT, onGetMindmapsByOwnerIdResult );
			service.getMindmapsByOwnerId( ownerId );
		}
		
		private function onGetMindmapsByOwnerIdResult( result : ResultEvent ) : void {
			var ownerId : uint = 1;
			
			var owner : UserVO = new UserVO;
			owner.id = ownerId;

			var expectedMindmap1 : MindmapVO = new MindmapVO();
			expectedMindmap1.name = "test mindmap 1";
			expectedMindmap1.owner = owner;
			
			var expectedMindmap2 : MindmapVO = new MindmapVO();
			expectedMindmap2.name = "test mindmap 2";
			expectedMindmap2.owner = owner;
			
			var expectedMindmaps : Array = [ expectedMindmap1, expectedMindmap2 ];

			var actualMindmaps : Array = result.result as Array;
			
			for ( var i : uint = 0; i < actualMindmaps.length; i++ ) {
				var expectedMindmap : MindmapVO = expectedMindmaps[ i ] as MindmapVO;
				var actualMindmap : MindmapVO = actualMindmaps[ i ] as MindmapVO;
				assertEquals( expectedMindmap.name, actualMindmap.name );
			}
		}
		
		private function onFault( fault : FaultEvent ) : void {
			Debug.show( fault.fault );
			fail();
		}
		
	}
}