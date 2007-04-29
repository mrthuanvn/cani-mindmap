package pl.cani.mindmap.utils {
	
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	import pl.cani.mindmap.vo.UserVO;
	import pl.cani.mindmap.vo.MindmapVO;
	import pl.cani.mindmap.model.MindmapUserPairTest;
	import pl.cani.mindmap.model.MindmapUserPair;

	public class MindmapUserPairComparatorTest extends TestCase	{
		
		private var comparator : MindmapUserPairComparator;
		
		public function MindmapUserPairComparatorTest( methodName : String = null )	{
			super( methodName );
		}
		
		public static function suite() : TestSuite {
			var ts : TestSuite = new TestSuite();
			
			ts.addTest( new MindmapUserPairComparatorTest( "testCompare" ) );
			
			return ts;
		}
		
		override public function setUp() : void {
			comparator = new MindmapUserPairComparator();
		}
		
		public function testCompare() : void {
			var user1 : UserVO = new UserVO( "janek" );
			var user2 : UserVO = new UserVO( "janek" );
			
			var mindmap1 : MindmapVO = new MindmapVO( "mindmap" );
			var mindmap2 : MindmapVO = new MindmapVO( "mindmap" );
			
			var pair1 : MindmapUserPair = new MindmapUserPair( null, user1, 0 );
			var pair2 : MindmapUserPair = new MindmapUserPair( null, user2, 0 );
			
			assertFalse( "==", user1 == user2 );
			assertTrue( "equals", user1.equals( user2 ) );
			assertEquals( "compare", 0, comparator.compare( pair1, pair2 ) );
		}
		
	}
}