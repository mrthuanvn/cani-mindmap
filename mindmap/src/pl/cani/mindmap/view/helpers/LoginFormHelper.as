package pl.cani.mindmap.view.helpers {
	
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.adobe.cairngorm.view.ViewHelper;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.events.ValidationResultEvent;
	import mx.resources.ResourceBundle;
	import mx.validators.Validator;
	
	import pl.cani.mindmap.events.ActivationAndLoggingEvent;
	import pl.cani.mindmap.events.LoggingEvent;
	import pl.cani.mindmap.events.RegistrationEvent;
	import pl.cani.mindmap.events.ViewEvent;
	import pl.cani.mindmap.validators.EmailPasswordPair;
	import pl.cani.mindmap.view.LoginForm;


	public class LoginFormHelper extends ViewHelper	{
	
		private var formIsValid : Boolean = false;
		private var passwordIsValid : Boolean = true;
		private var passwordHadFocus : Boolean = false;
		
		private var focussedFormControl : DisplayObject;
		
		[ResourceBundle( "LoginForm" )]
		private var rb : ResourceBundle;
	
		private var concreteView : LoginForm;
		
		private var _pendingEvent : ViewEvent;
	
		public function LoginFormHelper( view : LoginForm ) {
			this.view = view;
			concreteView = view;
			
			CairngormEventDispatcher.getInstance().addEventListener( 
        		RegistrationEvent.REGISTRATION_COMPLETE, 
        		onRegistrationComplete );
		}
		
		public function onRegistrationComplete( event : RegistrationEvent ) : void {
			concreteView.emailValidator.removeNotRegisteredEmail( event.user.email );
		}

		public function showBaseState() : void {
			concreteView.currentState = "";
			concreteView.loginBtn.label = rb.getString( "loginBtn" );
			concreteView.loginBtn.enabled = true;
			concreteView.focusManager.setFocus( concreteView.loginBtn );
		}
		
		public function showUserDoesntExistError( email : String ) : void {
        	view.emailValidator.addNotRegisteredEmail( email );
        	focussedFormControl = view.emailTxt;
        	validate( view.emailValidator );
        	view.focusManager.setFocus( view.emailTxt );
        	view.emailTxt.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_OVER ) );
        	
        	resetForm();
        }
        
        public function showUserNotActivatedError( email : String, 
        		activationKey : String ) : void {
        	
        	var view : LoginForm = view as LoginForm;
        	
        	view.currentState = view.ACTIVATE_AND_LOG_IN_STATE;
        	view.invalidateSize();
        	view.invalidateDisplayList();
        	view.invalidateProperties();
        	
//        	view.emailValidator.addNotActivatedEmail( email );
        	view.activationKeyValidator.addActivationKey( email, activationKey );
        	
/*         	focussedFormControl = view.emailTxt;
        	validate( view.emailValidator );
        	view.emailTxt.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_OVER ) );
 */        	
        	focussedFormControl = view.activationKeyTxt;
        	validate( view.activationKeyValidator );
        	view.activationKeyTxt.dispatchEvent( 
        		new MouseEvent( MouseEvent.MOUSE_OVER ) );

        	view.focusManager.setFocus( view.activationKeyTxt );
            view.formIsValid = false;
        }
        
        public function showWrongPasswordError( wrongPassword : String ) : void {
        	var view : LoginForm = view as LoginForm;

        	view.currentState = "";
        	
        	var emailPasswordPair : EmailPasswordPair = new EmailPasswordPair();
        	emailPasswordPair.email = concreteView.emailTxt.text;
        	emailPasswordPair.password = wrongPassword;
        	view.passwordValidator.addWrongPassword( emailPasswordPair );
        	focussedFormControl = view.passwordTxt;
        	validate( view.passwordValidator );

        	view.passwordTxt.dispatchEvent( 
        		new MouseEvent( MouseEvent.MOUSE_OVER ) );

        	view.focusManager.setFocus( view.passwordTxt );
            view.formIsValid = false;
            
            concreteView.loginBtn.label = rb.getString( "loginBtn" );
        }
    
    	public function resetForm() : void {
    		view.loginBtn.label = rb.getString( "loginBtn" );
    		view.loginBtn.enabled = true;
    	}
    
	    public function validateForm( event : Event ) : void {       
            var view : LoginForm = view as LoginForm;

            focussedFormControl = event.target as DisplayObject;
            passwordHadFocus = focussedFormControl == concreteView.passwordTxt;

            formIsValid = true;            

            validate( view.emailValidator );
            validate( view.passwordValidator );   

            if ( view.currentState == view.ACTIVATE_AND_LOG_IN_STATE ) {
            	validate( view.activationKeyValidator );
            }
            
            view.formIsValid = formIsValid;             
        }
        
		public function login() : void {
			var view : LoginForm = view as LoginForm;
			view.loginBtn.label = rb.getString( "loggingBtn" );
			view.loginBtn.enabled = false;
			
			if ( view.currentState != view.ACTIVATE_AND_LOG_IN_STATE ) {
			
				var loggingEvent : LoggingEvent 
					= new LoggingEvent( view.emailTxt.text, view.passwordTxt.text );
			
				CairngormEventDispatcher.getInstance().dispatchEvent( loggingEvent );
			
			} else {
				var email : String = view.emailTxt.text;
				var password : String = view.passwordTxt.text;
				var activationKey : String = view.activationKeyTxt.text;
			
				var activationAndLoggingEvent : ActivationAndLoggingEvent
					= new ActivationAndLoggingEvent( email, password, activationKey );
			
				CairngormEventDispatcher.getInstance()
				.dispatchEvent( activationAndLoggingEvent );					
			}
		}
		
		public function isRememberMeSet() : Boolean {
			var view : LoginForm = view as LoginForm;
			return view.remeberMeChb.selected;
		}
 
        private function validate( validator : Validator ) : Boolean {                
            var validatorSource : DisplayObject 
             	= validator.source as DisplayObject;
            
            var suppressEvents : Boolean 
            	= ( validatorSource != focussedFormControl );
            	
            if ( validatorSource == concreteView.passwordTxt 
            	&& passwordIsValid == false ) {
            
        		suppressEvents = false;
        	}
            
            var event : ValidationResultEvent
            	= validator.validate( null, suppressEvents ); 
                            
            var currentControlIsValid : Boolean 
             	= ( event.type == ValidationResultEvent.VALID );
             	
            if ( validatorSource == concreteView.passwordTxt && passwordHadFocus ) {
            	passwordIsValid = currentControlIsValid;
            }
             
            formIsValid = formIsValid && currentControlIsValid;
             
            return currentControlIsValid;
       }
       
       public function set pendingEvent( value : ViewEvent ) : void {
       		_pendingEvent = pendingEvent;
       }
       
       public function get pendingEvent() : ViewEvent {
       		return _pendingEvent;
       }
	
	}
	
}