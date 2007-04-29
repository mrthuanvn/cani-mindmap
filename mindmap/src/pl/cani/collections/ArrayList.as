package pl.cani.collections {
	
	import as3.util.Comparator;
	
	import flexunit.utils.ArrayList;
	import flexunit.utils.Collection;
	import flexunit.utils.Iterator;
	
	import mx.controls.Alert;
	import as3.util.DefaultComparator;

	public class ArrayList extends flexunit.utils.ArrayList implements Collection {

		private var _comparator : Comparator;

		public function ArrayList()	{
			super();
			_comparator = new DefaultComparator();
		}
		
		public function set comparator( value : Comparator ) : void {
			_comparator = value;
		}
		
		public function get comparator() : Comparator {
			return _comparator;
		}
		
		override public function contains( item : Object ) : Boolean {
			return ( getItemIndex( item ) > -1 );
		}
		
		private function getItemIndex( item : Object ) : int {
			var items : Array = toArray();
			for ( var i : uint = 0; i < items.length; i++ ) {
				if ( _comparator.compare( item, items[ i ] ) == 0 ) {
					return i;
				}
			}
			return -1;
		}
		
	}
}