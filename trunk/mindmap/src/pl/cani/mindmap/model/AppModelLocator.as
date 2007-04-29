package pl.cani.mindmap.model {

	import com.adobe.cairngorm.model.ModelLocator;
	
	import mx.collections.ArrayCollection;
	import mx.controls.DataGrid;
	
	import pl.cani.mindmap.view.LoginForm;
	import pl.cani.mindmap.view.LoginRegistration;
	import pl.cani.mindmap.view.MainView;
	import pl.cani.mindmap.view.ManagementPanel;
	import pl.cani.mindmap.view.RegistrationForm;
	import pl.cani.mindmap.vo.MindmapVO;

	[Bindable]
	public class AppModelLocator implements ModelLocator {
		
		private static var instance : AppModelLocator;
		
		public var mainView : MainView;
		
		public var loginAndRegistrationView : LoginRegistration;
		public var loginForm : LoginForm;
		public var registrationForm : RegistrationForm;
		
		public var managementPanel : ManagementPanel;
		public var myMindmaps : ArrayCollection;
		public var selectedMindmap : MindmapVO;
		public var mindmapUsersDataGrid : DataGrid;
		
		public static function getInstance() : AppModelLocator {
			if ( instance == null ) {
				instance = new AppModelLocator();
			}
			return instance;
		}
		
	}
}