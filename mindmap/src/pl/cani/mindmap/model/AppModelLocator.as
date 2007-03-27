package pl.cani.mindmap.model {

	import com.adobe.cairngorm.model.ModelLocator;
	import pl.cani.mindmap.view.RegistrationForm;
	import pl.cani.mindmap.view.LoginForm;
	import pl.cani.mindmap.view.LoginRegistration;

	[Bindable]
	public class AppModelLocator implements ModelLocator {
		
		private static var instance : AppModelLocator;
		
		public var loginAndRegistrationView : LoginRegistration;
		public var loginForm : LoginForm;
		public var registrationForm : RegistrationForm;
		
		public static function getInstance() : AppModelLocator {
			if ( instance == null ) {
				instance = new AppModelLocator();
			}
			return instance;
		}
		
		
		
	}
}