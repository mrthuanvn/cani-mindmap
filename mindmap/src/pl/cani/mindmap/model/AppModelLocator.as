package pl.cani.mindmap.model {

	import com.adobe.cairngorm.model.ModelLocator;
	
	import mx.collections.ArrayCollection;
	
	import pl.cani.mindmap.view.LoginForm;
	import pl.cani.mindmap.view.LoginRegistration;
	import pl.cani.mindmap.view.RegistrationForm;
	import pl.cani.mindmap.view.MainView;

	[Bindable]
	public class AppModelLocator implements ModelLocator {
		
		private static var instance : AppModelLocator;
		
		public var mainView : MainView;
		
		public var loginAndRegistrationView : LoginRegistration;
		public var loginForm : LoginForm;
		public var registrationForm : RegistrationForm;
		
		public var myMindmaps : ArrayCollection;
		
		public static function getInstance() : AppModelLocator {
			if ( instance == null ) {
				instance = new AppModelLocator();
			}
			return instance;
		}
		
		
		
	}
}