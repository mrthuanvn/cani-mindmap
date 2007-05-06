package pl.cani.mindmap.model {
	
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;

	public class MindmapTest extends TestCase {
		
		public function MindmapTest( methodName : String = null ) {
			super( methodName );
		}
		
		public static function suite() : TestSuite {
			var ts : TestSuite = new TestSuite();
			
			ts.addTest( new MindmapTest( "testXML" ) );
			
			return ts;
		}
		
		public function testXML() : void {
			var xml : XML = new XML( "" );
			assertFalse( xml.localName() == "mindmap" );
			
			xml = new XML( "<mindmap name='elo ziom!' />" );
			assertTrue( xml.@name == "elo ziom!" );
			assertTrue( xml.localName() == "mindmap" );
		}
		
	}
}