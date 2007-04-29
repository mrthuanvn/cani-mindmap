package pl.cani.collections {
	
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	import pl.cani.mindmap.model.MindmapUserPair;
	import pl.cani.mindmap.vo.MindmapVO;
	import pl.cani.mindmap.vo.UserVO;
	import pl.cani.mindmap.utils.MindmapUserPairComparator;

	public class ArrayListTest extends TestCase	{
		
		public function ArrayListTest( methodName : String = null )	{
			super( methodName );
		}
		
		public static function suite() : TestSuite {
			var ts : TestSuite = new TestSuite();
			
			ts.addTest( new ArrayListTest( "testContains" ) );
			
			return ts;
		}
		
		public function testContains() : void {
			var list : ArrayList = new ArrayList();
			list.comparator = new MindmapUserPairComparator();
			
			var mindmap : MindmapVO = new MindmapVO();
			mindmap.name = "dupa";
			
			var user : UserVO = new UserVO( "janek" );
			var pair : MindmapUserPair = new MindmapUserPair( mindmap, user );
			list.addItem( pair );
			assertTrue( "same pair", list.contains( pair ) );
			
			var differentUser : UserVO = new UserVO( "franek" );
			var differentPair : MindmapUserPair = new MindmapUserPair( mindmap, 
				differentUser )
			assertFalse( "different pair", list.contains( differentPair ) );
			
			var differentObjectSamePair : MindmapUserPair 
				= new MindmapUserPair( mindmap, user );
			assertTrue( "different object, same pair", 
				list.contains( differentObjectSamePair ) );
		}
		
		public function testContainsSimple() : void {
			var user1 : UserVO = new UserVO( "janek" );
			var user2 : UserVO = new UserVO( "janek" );
			
			var list : ArrayList = new ArrayList();
			list.addItem( user1 );
			
			assertTrue( "same values, differnet objects", list.contains( user2 ) );
		}
		
	}
	
}