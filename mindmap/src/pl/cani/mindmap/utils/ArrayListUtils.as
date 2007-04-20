package pl.cani.mindmap.utils {
	
	import flexunit.utils.ArrayList;
	import flexunit.utils.CollectionIterator;
	
	public class ArrayListUtils	{
		
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