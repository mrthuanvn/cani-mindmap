package pl.cani.test.events {
	
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import pl.cani.mindmap.events.ActivationEvent;
	import pl.cani.mindmap.events.EventFactory;
	import pl.cani.mindmap.events.ViewEvent;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class EventFactoryTest extends TestCase {

		public function EventFactoryTest( methodName : String ) {
			super( methodName );
		}
		
		public static function suite() : TestSuite {
   			var ts : TestSuite = new TestSuite();
   			
   			ts.addTest( new EventFactoryTest( "testCreateEvent" ) );

   			return ts;
   		}
		
		public function testCreateEvent() : void {
			var sections : Array = [ "login" ];
			var params : Array = [];
			var expectedViewEvent : ViewEvent = new ViewEvent( "login" );
			var actualViewEvent : ViewEvent 
				= EventFactory.createEvent( sections, params ) as ViewEvent;
			assertEquals( expectedViewEvent.section, actualViewEvent.section );	
			
			sections = [ "registration" ];
			expectedViewEvent.section = sections[ 0 ];
			actualViewEvent = EventFactory.createEvent( sections, params )
				as ViewEvent;
			assertEquals( expectedViewEvent.section, actualViewEvent.section );	
			
			sections = [ "activation" ];
			params[ "activationKey" ] = "dupa";
			var expectedActivationEvent : ActivationEvent 
				= new ActivationEvent( params[ "activationKey" ] );
			var actualActivationEvent : ActivationEvent 
				= EventFactory.createEvent( sections, params ) as ActivationEvent;
			assertEquals( expectedActivationEvent.activationKey,
				actualActivationEvent.activationKey );
				
			sections = [];
			params = [];
			var actualEvent : CairngormEvent 
				= EventFactory.createEvent( sections, params );
			assertNull( actualEvent );
		}
		
	}

}