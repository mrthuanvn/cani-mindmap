package pl.cani.mindmap.events {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import pl.cani.mindmap.control.Controller;

	public class LogOutEvent extends CairngormEvent	{
	
		public function LogOutEvent() {
			super( Controller.LOGOUT );
		}
		
	}
	
}