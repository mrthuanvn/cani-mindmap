package pl.cani.mindmap.view.helpers {
	
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.adobe.cairngorm.view.ViewHelper;
	
	import pl.cani.mindmap.events.UserServiceEvent;
	import pl.cani.mindmap.view.PrivilagesPanel;
	import pl.cani.mindmap.controls.RemotingButton;

	public class PrivilagesPanelHelper extends ViewHelper {
		
		private var concreteView : PrivilagesPanel;
		
		public function PrivilagesPanelHelper( view : PrivilagesPanel )	{
			this.view = view;
			concreteView = view;
			CairngormEventDispatcher.getInstance().addEventListener( 
				UserServiceEvent.USERS_FOUND, onUsersFound );
		}
		
		public function findUsers() : void {
			concreteView.findBtn.currentState = RemotingButton.STATE_DISABLED;
			
			var event : UserServiceEvent 
				= new UserServiceEvent( UserServiceEvent.FIND_USERS );
			event.queryString = concreteView.searchTxt.text;
			
			CairngormEventDispatcher.getInstance().dispatchEvent( event );
		}
		
		private function onUsersFound( event : UserServiceEvent ) : void {
			concreteView.findBtn.currentState = RemotingButton.STATE_ENABLED;
		}
		
	}
}