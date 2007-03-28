package pl.cani.test.utils {
	
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	import pl.cani.mindmap.utils.SWFAddressHandler;

	public class SWFAddressHandlerTest extends TestCase	{

		public function SWFAddressHandlerTest( methodName : String ) {
			super( methodName );
		}

		public static function suite() : TestSuite {
   			var ts : TestSuite = new TestSuite();
   			
   			ts.addTest( new SWFAddressHandlerTest( "testGetSections" ) );

   			return ts;
   		}
   		
   		public function testGetSections() : void {
   			var str : String = "section1/section2";
   			var expected : Array = [ "section1", "section2" ];
   			var actual : Array = SWFAddressHandler.getSections( str );
   			assertEquals( expected[ 0 ], actual[ 0 ] );
   			assertEquals( expected[ 1 ], actual[ 1 ] );   			
   			assertEquals( expected.length, actual.length );
   			
   			str = "activation?activationKey=dupa";
   			expected = [ "activation" ];
   			actual = SWFAddressHandler.getSections( str );
  			assertEquals( expected.length, actual.length );
 			assertEquals( expected[ 0 ], actual[ 0 ] );
 			
 			str = "activation/?activationKey=dupa";
   			actual = SWFAddressHandler.getSections( str );
  			assertEquals( expected.length, actual.length );
   		}


	}
	
}