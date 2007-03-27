package pl.cani.mindmap.view.helpers {
	
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.adobe.cairngorm.view.ViewHelper;
	
	import flash.net.SharedObject;
	
	import pl.cani.mindmap.events.LogOutEvent;
	import pl.cani.mindmap.view.MainView;

	public class MainViewHelper extends ViewHelper {

		public static var BASE_STATE : String = "";
		public static var LOGGED_OUT_STATE : String = "loggedOut";
		public static var LOGGED_IN_STATE : String = "loggedIn";
	
		private var concreteView : MainView;
	
		public function MainViewHelper( view : MainView ) {
			this.view = view;
			concreteView = view;
		}
		
		public function logout() : void {
			CairngormEventDispatcher.getInstance().dispatchEvent(
				new LogOutEvent() );
		}
		
		public function setState( state : String ) : void {
			concreteView.currentState = state;
		}
		
	}
	
}