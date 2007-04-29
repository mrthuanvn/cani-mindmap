package pl.cani.mindmap.commands {
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.model.ModelLocator;
	import com.adobe.cairngorm.view.ViewLocator;
	
	import pl.cani.mindmap.events.ViewEvent;
	import pl.cani.mindmap.model.AppModelLocator;
	import pl.cani.mindmap.view.helpers.LoginRegistrationHelper;
	import pl.cani.mindmap.view.helpers.MainViewHelper;
	import pl.cani.mindmap.view.helpers.ViewNames;

	public class ShowViewCommand implements ICommand {
		
		public function execute( event : CairngormEvent ) : void {
			
			var viewEvent : ViewEvent = event as ViewEvent;
			
			var section : String = viewEvent.section;
			
			switch ( section ) {

			case ViewNames.LOGIN_FORM:
//				AppModelLocator.getInstance().mainAppView.currentState = "";
				var loginRegistrationHelper : LoginRegistrationHelper
					= ViewLocator.getInstance()
						.getViewHelper( ViewNames.LOGIN_AND_REGISTRATION )
						as LoginRegistrationHelper;

				loginRegistrationHelper.showForm( ViewNames.LOGIN_FORM );
				break;

			case ViewNames.REGISTRATION_FORM:
				loginRegistrationHelper = ViewLocator.getInstance()
						.getViewHelper( ViewNames.LOGIN_AND_REGISTRATION )
						as LoginRegistrationHelper;

				loginRegistrationHelper.showForm( ViewNames.REGISTRATION_FORM );
				break;
						
			case ViewNames.PRIVILAGES:
				AppModelLocator.getInstance().mainView.currentState 
					= ViewNames.PRIVILAGES;
				break;
			
			}
			
		}
		
	}
	
}