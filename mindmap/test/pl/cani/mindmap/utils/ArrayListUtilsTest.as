package pl.cani.mindmap.utils {
	
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	import flexunit.utils.ArrayList;
	
	import pl.cani.mindmap.validators.EmailPasswordPair;

	public class ArrayListUtilsTest extends TestCase {
		
		public function ArrayListUtilsTest( methodName : String = null ) {
			super( methodName );
		}
		
		public static function suite() : TestSuite {
			var ts : TestSuite = new TestSuite();
			
			ts.addTest( new ArrayListUtilsTest( "testGetByKey" ) );
			ts.addTest( new ArrayListUtilsTest( "testGetByKeyWithEmailPasswordPairs" ) );
			
			return ts;
		}
		
		public function testGetByKey() : void {
			var arrayList : ArrayList = createInputList();
			var key : String = "email";
			var email : String = "test@test.pl";
			
			var expectedList : ArrayList = createArrayList();
			
			var actualList : ArrayList 
				= ArrayListUtils.getByKey( arrayList, key, email );
				
			for ( var i : uint = 0; i < expectedList.length(); i++ ) {
				var expected : Object = expectedList.getItemAt( i );
				var actual : Object = actualList.getItemAt( i );
				assertEquals( "password " + i, expected.password, actual.password );
			}
		}
		
		public function testGetByKeyWithEmailPasswordPairs() : void {
			var arrayList : ArrayList = createInputEmailPasswordList();
			var key : String = "email";
			var email : String = "test@test.pl";
			
			var expectedList : ArrayList = createOutputEmailPasswordList();
			
			var actualList : ArrayList 
				= ArrayListUtils.getByKey( arrayList, key, email );
				
			for ( var i : uint = 0; i < expectedList.length(); i++ ) {
				var expected : Object = expectedList.getItemAt( i );
				var actual : Object = actualList.getItemAt( i );
				assertEquals( "password " + i, expected.password, actual.password );
			}
		}
		
		private function createArrayList() : ArrayList {
			var list : ArrayList = new ArrayList();
			
			list.addItem( { email: "test@test.pl", password: "testpass1" } );
			list.addItem( { email: "test@test.pl", password: "testpass2" } );
			
			return list;
		}
		
		private function createInputList() : ArrayList {
			var list : ArrayList = createArrayList();
			
			list.addItem( { email: "test2@test.pl", password: "testpass2" } );
			
			return list;

		}
		
		private function createOutputEmailPasswordList() : ArrayList {
			var list : ArrayList = new ArrayList();
			
			list.addItem( new EmailPasswordPair( "test@test.pl", "testpass1" ) );
			list.addItem( new EmailPasswordPair( "test@test.pl", "testpass2" ) );
			
			return list;
		}
		
		private function createInputEmailPasswordList() : ArrayList {
			var list : ArrayList = createOutputEmailPasswordList();
			
			list.addItem( new EmailPasswordPair( "test2@test.pl", "testpass2" ) );
			
			return list;
		}
		
	}
}