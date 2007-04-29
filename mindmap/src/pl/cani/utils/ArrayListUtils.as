package pl.cani.utils {

	import mx.collections.ArrayCollection;
	
	import pl.cani.collections.ArrayList;
	import flexunit.utils.CollectionIterator;
	
	public class ArrayListUtils	{
		
		public static function createFromArrayCollection( 
				collection : ArrayCollection ) : ArrayList {
			
			var list : ArrayList = new ArrayList();
			for ( var i : uint = 0; i < collection.length; i++ ) {
				list.addItem( collection.getItemAt( i ) );
			}
			return list;
		}
		
		public static function getByKey( list : ArrayList, keyName : String, 
				keyValue : String ) : ArrayList {
			
			var resultList : ArrayList = new ArrayList();
			
			var iterator : CollectionIterator = new CollectionIterator( list );
			while ( iterator.hasNext() ) {
				var keyValuePair : Object = iterator.next();
				if ( keyValuePair[ keyName ] == keyValue ) {
					resultList.addItem( keyValuePair );
				}
			}
			
			return resultList;
		}
		
	}
	
}