/**
 * @author Jan (Can I) Kłosiński janek@cani.pl
 **/
package pl.cani.controls {
	
	import mx.collections.ArrayCollection;
	import mx.controls.listClasses.ListBase;
	import mx.core.UIComponent;
	import mx.events.DragEvent;
	
	/**
	 * Allows for draging'n'droping elements from <code>source</code> to <code>
	 * destination</code>. Elements being already on the destination list are 
	 * not allowed to be droped again.
	 * 
	 */
	
	/**
	 * Dispatched when some items being dragged are already on the destination list
	 */ 
	[Event( name = "disallowedItems", type = "pl.cani.controls.DragAndDropNoRepeatEvent" )]
	
	/**
	 * Dispatched when drag is completed
	 */ 
	[Event( name = "dragComplete", type = "mx.events.DragEvent" )]
	 
	public class DragAndDropNoRepeat extends UIComponent {
		
		private var _source : ListBase;
		private var _destination : ListBase;
		
		private var supressEvents : Boolean = false;
		private var allowedItems : Array;
		private var disallowedItems : Array;
		

		public function set source( value : ListBase ) : void {
			_source = value;
			_source.addEventListener( DragEvent.DRAG_COMPLETE, clearInfo )
		}
		
		public function get source() : ListBase {
			return _source;
		}
		
		public function set destination( value : ListBase ) : void {
			_destination = value;
			_destination.addEventListener( DragEvent.DRAG_ENTER, onDestinationDragEnter );
		}
		
		public function get destination() : ListBase {
			return _destination;
		}
		

		private function onDestinationDragEnter( event : DragEvent ) : void {
			if ( supressEvents == false ) {
				var items : Array = 
                    event.dragSource.dataForFormat( "items" ) as Array;
                    
				if ( destination.dataProvider != null ) {
					
					disallowedItems = new Array();
					allowedItems = new Array();
					
					var allow : Boolean = distinguishItems( items );
					
					event.dragSource.addData( allowedItems, "items" );

					if ( allowedItems.length == 0 ) {
						supressEvents = true;
						destination.dropEnabled = false;
						prepareAndDispatchDisallowedItemsEvent();
					} else if ( allow == false && allowedItems.length > 0 ) {
						supressEvents = true;
						destination.dropEnabled = true;
						prepareAndDispatchDisallowedItemsEvent();
					} else {
						destination.dropEnabled = true;
					}
				} 
			}
		}	
		
		/**
		 * Divides items into allowed and disallowed
		 * @param Array items
		 * @return Boolean <code>false</code> if there are any disallowed items,
		 * <code>true</code> otherwise
		 **/
		private function distinguishItems( items : Array ) : Boolean {
			var destinationItems : ArrayCollection 
				= destination.dataProvider as ArrayCollection;
				
			for ( var i : uint = 0; i < items.length; i++ ) {
				var item : Object = items[ i ];
				var allowItem : Boolean = destinationItems.contains( item ) == false;
				if ( allowItem == false ) {
					disallowedItems.push( item );
				} else {
					allowedItems.push( item );
				}
			}
			
			return disallowedItems.length == 0;
		}
		
		private function clearInfo( event : DragEvent ) : void {
			supressEvents = false;
			dispatchEvent( new DragEvent( DragEvent.DRAG_COMPLETE ) );
		}
		
		private function prepareAndDispatchDisallowedItemsEvent() : Boolean {
			var dndEvent : DragAndDropNoRepeatEvent = 
				new DragAndDropNoRepeatEvent( 
					DragAndDropNoRepeatEvent.DISALLOWED_ITEMS );
			dndEvent.allowedItems = allowedItems;
			dndEvent.disallowedItems = disallowedItems;

			return dispatchEvent( dndEvent );
		}
		
	}
	
}