package mx.collections {
	
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import pl.cani.mindmap.model.MindmapUserPair;
	import pl.cani.mindmap.vo.MindmapVO;
	import pl.cani.mindmap.vo.UserVO;

	public class ArrayCollectionTest extends TestCase {
		
		public function ArrayCollectionTest( methodName : String = null ) {
			super( methodName );
		}
		
		public static function suite() : TestSuite {
			var ts : TestSuite = new TestSuite();
			
			ts.addTest( new ArrayCollectionTest( "testContains" ) );
			ts.addTest( new ArrayCollectionTest( "testContainsSimple" ) );
			
			return ts;
		}
		
		public function testContains() : void {
			var collection : ArrayCollection = new ArrayCollection();
			
			var mindmap : MindmapVO = new MindmapVO();
			mindmap.name = "dupa";
			
			var user : UserVO = new UserVO( "janek" );
			var pair : MindmapUserPair = new MindmapUserPair( mindmap, user );
			collection.addItem( pair );
			assertTrue( "same pair", collection.contains( pair ) );
			
			var differentUser : UserVO = new UserVO( "franek" );
			var differentPair : MindmapUserPair = new MindmapUserPair( mindmap, 
				differentUser )
			assertFalse( "different pair", collection.contains( differentPair ) );
			
			var differentObjectSamePair : MindmapUserPair 
				= new MindmapUserPair( mindmap, user );
			assertTrue( "different object, same pair", 
				collection.contains( differentObjectSamePair ) );
		}
		
		public function testContainsSimple() : void {
			var user1 : UserVO = new UserVO( "janek" );
			var user2 : UserVO = new UserVO( "janek" );
			
			var collection : ArrayCollection = new ArrayCollection();
			collection.addItem( user1 );
			
			assertTrue( "same values, differnet objects", collection.contains( user2 ) );
		}
		
	}
}