package pl.cani.mindmap.view.helpers {
	
	import com.adobe.cairngorm.view.ViewHelper;
	
	import pl.cani.mindmap.view.LoginRegistration;

	public class LoginRegistrationHelper extends ViewHelper	{
		
		private var concreteView : LoginRegistration;
		
		private var forms : Array = [ 
			ViewNames.LOGIN_FORM, 
			ViewNames.REGISTRATION_FORM 
		];
		
		public function LoginRegistrationHelper( view : LoginRegistration ) {
			this.view = view;
			concreteView = view;
		}
		
		public function showForm( formName : String ) : int {
			var index : int = forms.indexOf( formName );
			concreteView.container.selectedIndex = index;
			return index;
		}
		
	}
}