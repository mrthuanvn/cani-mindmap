package pl.cani.mindmap.commands {
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.view.ViewLocator;
	import pl.cani.mindmap.view.helpers.ViewNames;
	import pl.cani.mindmap.view.helpers.MainViewHelper;
	import flash.net.SharedObject;
	import pl.cani.mindmap.business.SessionAndPersitentData;

	public class LogOutUserCommand implements ICommand {
		
		public function execute( event : CairngormEvent ) : void {
			SessionAndPersitentData.getInstance().setRememberUser( false );
			
			var mainViewHelper : MainViewHelper = ViewLocator.getInstance()
				.getViewHelper( ViewNames.MAIN ) as MainViewHelper;
			mainViewHelper.setState( MainViewHelper.LOGGED_OUT_STATE );
		}
		
	}
	
}