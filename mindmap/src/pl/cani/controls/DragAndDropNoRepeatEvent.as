package pl.cani.controls {
	
	import flash.events.Event;

	public class DragAndDropNoRepeatEvent extends Event	{

		public static const DISALLOWED_ITEMS : String = "disallowedItems";

		public var allowedItems : Array;
		public var disallowedItems : Array;
	
		public function DragAndDropNoRepeatEvent( type : String, 
				allowedItems : Array = null, disallowedItems : Array = null ) {
			super( type );
		}
		
	}
}