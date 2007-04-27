package pl.cani.mindmap.model {
	
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;

	public class MindmapUserPairTest extends TestCase {
		
		public function MindmapUserPairTest( methodName : String = null ) {
			super( methodName );
		}
		
		public static function suite() : TestSuite {
			var ts : TestSuite = new TestSuite();
			
			ts.addTest( new MindmapUserPairTest( "testPrivilagesSetter" ) );
			ts.addTest( new MindmapUserPairTest( "testCanReadSetter" ) );
			ts.addTest( new MindmapUserPairTest( "testCanWriteSetter" ) );
			
			return ts;
		}
		
		public function testPrivilagesSetter() : void {
			var pair : MindmapUserPair = new MindmapUserPair();
			pair.privilages = MindmapPrivilages.READ;
			
			assertEquals( MindmapPrivilages.READ, pair.privilages );
			assertTrue( pair.canRead );
			assertFalse( pair.canWrite );
		}
		
		public function testCanReadSetter() : void {
			var pair : MindmapUserPair = new MindmapUserPair();

			pair.canRead = true;
			
			assertEquals( MindmapPrivilages.READ, pair.privilages );
			assertTrue( pair.canRead );
			assertFalse( pair.canWrite );
			
			pair.canRead = false;
			assertEquals( MindmapPrivilages.NONE, pair.privilages );
			assertFalse( pair.canRead );
			assertFalse( pair.canWrite );
		}
		
		public function testCanWriteSetter() : void {
			var pair : MindmapUserPair = new MindmapUserPair();

			pair.canWrite = true;
			
			assertEquals( MindmapPrivilages.READ_WRITE, pair.privilages );
			assertTrue( pair.canRead );
			assertTrue( pair.canWrite );
			
			pair.canWrite = false;
			assertEquals( MindmapPrivilages.READ, pair.privilages );
			assertTrue( pair.canRead );
			assertFalse( pair.canWrite );
		}
		
	}
}