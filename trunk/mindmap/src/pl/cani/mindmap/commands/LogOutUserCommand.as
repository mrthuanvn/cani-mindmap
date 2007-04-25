package pl.cani.mindmap.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.view.ViewLocator;
	import com.asual.swfaddress.SWFAddress;
	
	import flash.net.SharedObject;
	
	import pl.cani.mindmap.business.SessionAndPersitentData;
	import pl.cani.mindmap.view.helpers.MainViewHelper;
	import pl.cani.mindmap.view.helpers.ViewNames;

	public class LogOutUserCommand implements ICommand {
		
		public function execute( event : CairngormEvent ) : void {
			SessionAndPersitentData.getInstance().logoutUser();
			
			var mainViewHelper : MainViewHelper = ViewLocator.getInstance()
				.getViewHelper( ViewNames.MAIN ) as MainViewHelper;
			mainViewHelper.setState( MainViewHelper.LOGGED_OUT_STATE );
			
			SWFAddress.setValue( "" );
		}
		
	}
	
}