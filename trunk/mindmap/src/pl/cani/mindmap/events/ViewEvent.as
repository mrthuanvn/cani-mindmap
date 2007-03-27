package pl.cani.mindmap.events {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import pl.cani.mindmap.control.Controller;

	public class ViewEvent extends CairngormEvent {
		
		public var section : String;
		public var subsection : String;
		public var params : Array;
		
		public function ViewEvent( section : String = "", subsection : String = "",
				params : Array = null ) {
					
			super( Controller.VIEW );
			this.section = section;
			this.subsection = subsection;
			this.params = params;
		}
		
	}

}