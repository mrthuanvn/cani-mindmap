package as3.util {
	
	public class DefaultComparator implements Comparator {
		
		public function equals( obj : Object ) : Boolean {
			return obj == this;
		}
		
		public function compare( obj1 : Object, obj2 : Object ) : int {
			if ( obj1 == obj2 ) {
				return 0;
			} else if ( obj1 > obj2 ) {
				return 1;
			} 
			return -1;
		}
		
	}
}